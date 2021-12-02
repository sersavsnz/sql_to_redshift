import re

with open('redshift.sql', 'w') as redshift:
    with open('dump-database-callpanda.sql', 'r') as sql:
        for l in sql:
            l = re.sub(r'/\*.+\*/;', '', l)
            l = re.sub(r'`', '', l)
            l = re.sub(r'`', '', l)
            l = re.sub(r' ENGINE.+', ';', l)
            l = re.sub(r'COLLATE utf8mb4_unicode_ci', '', l)
            l = re.sub(r'COLLATE utf8mb4_bin', '', l)
            redshift.write(l)


s = ") ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;"
x=re.sub(r' ENGINE.+', ';', s)
print(x)