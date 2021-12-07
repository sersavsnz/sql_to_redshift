import re

name = 'table'

with open(f'redshift_{name}.sql', 'w') as redshift:
    with open(f'{name}.sql', 'r') as sql:
        for l in sql:
            if l.strip() == '':
                redshift.write(l)
            else:
                l = re.sub(r'/\*.+\*/;', '', l)  # removes commented strings
                l = re.sub(r'`', '"', l)  # change quotation marks

                l = l.replace('CREATE TABLE', 'CREATE TABLE IF NOT EXISTS')

                # MySQL table_options (Redshift table_attributes)
                l = re.sub(r'ENGINE=InnoDB', '', l)  # removes ENGINE
                l = re.sub(r'DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci', '',
                           l)  # removes charset collate stuff
                l = re.sub(r"AUTO_INCREMENT=[0-9]+", '', l)

                # MySQL column_definition (Redshift column_attributes & column_constraints)
                l = re.sub(r'AUTO_INCREMENT', '',
                           l)  # remove AUTO_INCREMENT since we copy data from the files queried from
                # MySQL DB
                l = re.sub(r'COLLATE utf8mb4_unicode_ci', 'COLLATE CASE_INSENSITIVE', l)  # replace COLLATE statement
                l = re.sub(r'CHARACTER SET utf8mb4 COLLATE utf8mb4_bin', 'COLLATE CASE_SENSITIVE', l)
                l = re.sub(r'CHECK \(json_valid\(.+\)\)', '', l)  # Redshift does not have it

                # MySQL create_definition (Redshift table_constraints)
                l = re.sub('^ *KEY.+', ' ', l)  # remove indexing of columns
                # l = re.sub(r"(CONSTRAINT.+) (?=FOREIGN)", '',
                #            l)  # remove CONSTRAINT statement and keep FOREIGN KEY only
                if 'FOREIGN KEY' in l:  # remove FOREIGN KEY constraints since cross-table references create ambiguity
                    l = ''
                l = re.sub(r"UNIQUE.+(?=\()", 'UNIQUE ', l)  # correct syntax is UNIQUE ( column_name [, ... ] )

                # Data types
                l = re.sub('int\(.+\)', 'INT', l)
                l = l.replace(' varchar(', ' VARCHAR(')
                l = l.replace(' char(', ' CHAR(')
                l = l.replace(' tinyINT ', ' SMALLINT ')
                l = l.replace(' date ', ' DATE ')
                l = l.replace(' datetime ', ' DATETIME ')
                l = l.replace(' text ', ' VARCHAR(max) ')
                l = re.sub(r'enum\(.+\)', 'VARCHAR(32)', l)
                l = l.replace(' varbinary(', ' VARBINARY(')
                l = l.replace(' binary(', 'VARBINARY(')
                l = l.replace(' longtext ', ' TEXT ')

                # save
                if l.strip() != '':
                    redshift.write(l)

with open(f'redshift_{name}.sql', 'r') as redshift:
    lines = redshift.read().splitlines()

for i, line in enumerate(lines):
    if ';' in line:
        if lines[i-1][-1]==',':
            lines[i-1] = lines[i-1][:-1]

with open(f'redshift_{name}.sql', 'w') as redshift:
    for l in lines:
        redshift.write(l+'\n')


name = 'insert'
with open(f'redshift_{name}.sql', 'w') as redshift:
    with open(f'{name}.sql', 'r') as sql:
        for l in sql:
            if l.strip() == '':
                redshift.write(l)
            else:
                l = re.sub(r'`', '"', l)  # change quotation marks

                # save
                if l.strip() != '':
                    redshift.write(l)