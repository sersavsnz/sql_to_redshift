import redshift_connector
import re
import parameters


class SQLRedshiftConverter:

    def __init__(self, sql_dump_file_name):
        self.sql_dump_file_name = sql_dump_file_name
        self.create_table_sql_name = f'{self.sql_dump_file_name}_create_table_sql.sql'
        self.create_table_redshift_name = f'{self.sql_dump_file_name}_create_table_redshift.sql'

    def extract_create_table_queries(self):

        with open(f'data/{self.sql_dump_file_name}.sql', 'r') as f:
            sqlFile = f.read()
            sqlCommands = sqlFile.split(";\n")
            sqlCommands = [i.strip() + ';' for i in sqlCommands]
            sqlCommands_create_table = [i for i in sqlCommands if 'CREATE TABLE' in i]

        with open(f'data/{self.create_table_sql_name}', 'w') as f:
            for query in sqlCommands_create_table:
                f.write(f"{query}\n")

        print(f"'CREATE TABLE' queries are extracted and are saved into {self.create_table_sql_name}")

    def convert_create_table_queries(self):
        '''
        Converts 'create table' queries from MySQL to Redshift
        '''

        redshift = open(f'data/{self.create_table_redshift_name}', 'w')
        sql = open(f'data/{self.create_table_sql_name}', 'r')

        for l in sql:
            if l.strip() == '':
                redshift.write(l)
            else:
                l = re.sub(r'-- .+', '', l)  # removes commented strings
                # l = re.sub(r'/\*.+\*/;', '', l)  # removes commented strings
                l = re.sub(r'`', '"', l)  # change quotation marks

                # l = l.replace('CREATE TABLE', 'CREATE TABLE IF NOT EXISTS')

                # MySQL table_options (Redshift table_attributes)
                l = re.sub(r'ENGINE=InnoDB', '', l)  # removes ENGINE
                l = re.sub(r'DEFAULT CHARSET=utf8mb4', '', l)  # removes charset collate stuff
                l = re.sub(r'USING HASH', '', l)
                l = re.sub(r"AUTO_INCREMENT=[0-9]+", '', l)
                l = re.sub(r"CHARACTER SET utf8mb4", '', l)

                l = re.sub(r'AUTO_INCREMENT', '', l)  # remove AUTO_INCREMENT since we copy data from the files queried from MySQL DB
                l = re.sub(r'COLLATE utf8mb4_unicode_ci', 'COLLATE CASE_INSENSITIVE', l)  # replace COLLATE statement
                l = re.sub(r'CHARACTER SET utf8mb4 COLLATE utf8mb4_bin', 'COLLATE CASE_SENSITIVE', l)
                l = re.sub(r'CHECK \(json_valid\(.+\)\)', '', l)  # Redshift does not have it
                l = re.sub("COMMENT '.*?'", '', l)
                l = re.sub('^ *KEY.+', ' ', l)  # remove indexing of columns
                if 'FOREIGN KEY' in l:  # remove FOREIGN KEY constraints since cross-table references create ambiguity
                    l = ''
                l = re.sub(r"UNIQUE.+(?=\()", 'UNIQUE ', l)  # correct syntax is UNIQUE ( column_name [, ... ] )

                # Data types
                l = re.sub('int\(.+\)', 'INT', l)
                l = l.replace(' varchar(', ' VARCHAR(')
                l = l.replace(' varbinary(', ' VARCHAR(')
                l = l.replace(' varbinary ', ' VARCHAR ')
                l = l.replace(' char(', ' CHAR(')
                l = l.replace(' tinyINT ', ' SMALLINT ')
                l = l.replace(' date ', ' DATE ')
                l = l.replace(' datetime ', ' DATETIME ')
                l = l.replace(' datetime(3) ', ' DATETIME ')
                l = l.replace(' text ', ' VARCHAR(max) ')
                l = re.sub(r'enum\(.+\)', 'VARCHAR(32)', l)
                # l = l.replace(' varbinary(', ' VARBINARY(')
                l = l.replace(' binary(', 'VARBINARY(')
                l = l.replace(' longtext ', ' TEXT ')

                # save
                if l.strip() != '':
                    redshift.write(l)
        redshift.close()
        sql.close()

        with open(f'data/{self.create_table_redshift_name}', 'r') as redshift:
            lines = redshift.read().splitlines()

        for i, line in enumerate(lines):
            if ';' in line:
                if lines[i - 1][-1] == ',':
                    lines[i - 1] = lines[i - 1][:-1]

        with open(f'data/{self.create_table_redshift_name}', 'w') as redshift:
            for l in lines:
                redshift.write(l + '\n')

        print(f"'CREATE TABLE' queries are converted to Redshift dialect and are saved into {self.create_table_redshift_name}")

    def process(self):
        self.extract_create_table_queries()
        self.convert_create_table_queries()


class Redshift:

    def __init__(self, sql_dump_file_name):
        self.sql_dump_file_name = sql_dump_file_name
        self.host = parameters.HOST
        self.port = parameters.PORT
        self.database = parameters.DATABASE
        self.user = parameters.USER
        self.password = parameters.PASSWORD
        self.s3_path_to_table_data = parameters.S3_FILE_PATH_TO_DATA
        self.s3_credentials = parameters.S3_CREDENTIALS
        self.s3_region = parameters.S3_REGION
        self.create_table_file = SQLRedshiftConverter(sql_dump_file_name).create_table_redshift_name

    def connect_to_redshift(self):

        conn = redshift_connector.connect(
            host=self.host,
            port=self.port,
            database=self.database,
            user=self.user,
            password=self.password)
        cursor = conn.cursor()

        print(f'Connection to {self.database} database established')
        return conn, cursor

    def create_tables(self, conn, cursor):

        with open(f'data/{self.create_table_file}', 'r') as f:
            sqlFile = f.read()
            sqlCommands = sqlFile.split(";\n")
            sqlCommands = [i.strip() + ';' for i in sqlCommands  if i.strip()]

        row_create_table = [l for command in sqlCommands for l in command.split('\n') if "CREATE TABLE" in l]
        self.tables = [','.join(re.findall(r'"([^"]*)"', i)) for i in row_create_table]

        total = len(sqlCommands)
        for i, query in enumerate(sqlCommands):
            if i in (2, 31, 71):
                cursor.execute(query)
                conn.commit()
                print(f'{i+1}/{total}: {self.tables[i]} table was created')

    def fill_tables(self, conn, cursor):

        total = len(self.tables)
        for i, table in enumerate(self.tables):
            if i in (2, 31, 71):
                try:
                    print(f'{i}/{total}: Copying data to table {table}')
                    query = f'''COPY "{table}"
                                FROM '{self.s3_path_to_table_data}{table}.csv'
                                CREDENTIALS '{self.s3_credentials}'
                                REGION '{self.s3_region}'
                                CSV QUOTE as '\"'
                                IGNOREHEADER 1; '''
                    print(query)
                    cursor.execute(query)
                    conn.commit()
                    print(query)
                    print('done')
                except:
                    print('failed')
                    continue

    def process(self):

        conn, cursor = self.connect_to_redshift()

        self.create_tables(conn, cursor)
        self.fill_tables(conn, cursor)

        conn.close()


def main():
    dump_file_name = 'callpanda_prod'
    converter = SQLRedshiftConverter(dump_file_name)
    converter.process()

    redshift = Redshift(dump_file_name)
    redshift.process()

main()

