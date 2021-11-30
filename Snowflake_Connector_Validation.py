#!/usr/bin/env python
import snowflake.connector
import getpass as pwd
# Gets the version
ctx = snowflake.connector.connect(
    user=input("Enter User LDAP Name :"),
    password=pwd.getpass("Enter LDAP Password :"),
    account=''
    )
cs = ctx.cursor()
try:
    cs.execute("SELECT current_version()")
    one_row = cs.fetchone()
    print(one_row[0])
finally:
    cs.close()
ctx.close()
