import pandas as pd
import snowflake.connector
import getpass as pwd


pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth',None)

default_warehouse = 'PROD_ANALYTICS_WH'


ctx = snowflake.connector.connect(
    user='',
    password='',
    account=''
    )

build_admin_permissions = '''
USE ROLE ACCOUNTADMIN;
CREATE OR REPLACE USER PROD_DEVOPS_ADMIN
PASSWORD = '' 
COMMENT = 'Service User for Developer Admin Operations' 
DISPLAY_NAME = 'Production Developer Admin' 
DEFAULT_ROLE = "PROD_ADMIN"
MUST_CHANGE_PASSWORD = FALSE;
--GRANT ROLE "SYSADMIN" TO USER PROD_DEVOPS_ADMIN;

-----------------------------------------------
CREATE OR REPLACE USER DEV_DEVOPS_ADMIN
PASSWORD     = ''
COMMENT      = 'Service User for Developer Admin Operations' 
DISPLAY_NAME = 'Development Developer Admin' 
DEFAULT_ROLE = "DEV_ADMIN"
MUST_CHANGE_PASSWORD = FALSE;
-----------------------------------------------
-----------------------------------------------
CREATE OR REPLACE USER PROD_BI_CONSUMER
PASSWORD     = ''
COMMENT      = 'Service User for Developer Admin Operations' 
DISPLAY_NAME = 'Prod Business Intelligence Consumer' 
DEFAULT_ROLE = "PROD_ANALYTICS"
MUST_CHANGE_PASSWORD = FALSE;
------------------------------
CREATE OR REPLACE USER DEV_BI_CONSUMER
PASSWORD     = ''
COMMENT      = 'Dev service user for consuming data for data visualizations' 
DISPLAY_NAME = 'Dev Business Intelligence Consumer' 
DEFAULT_ROLE = "DEV_ANALYTICS"
MUST_CHANGE_PASSWORD = FALSE;
------------------------------
------- Grant Functional Roles -------
USE ROLE ACCOUNTADMIN;
GRANT ROLE PROD_ADMIN to USER PROD_DEVOPS_ADMIN;

USE ROLE ACCOUNTADMIN;
GRANT ROLE DEV_ADMIN to USER DEV_DEVOPS_ADMIN;

------- Create Functional Roles -------
USE ROLE SECURITYADMIN;
CREATE OR REPLACE ROLE PROD_ADMIN;
CREATE OR REPLACE ROLE PROD_SECOPS;
CREATE OR REPLACE ROLE PROD_AUTOMATION;
CREATE OR REPLACE ROLE PROD_ANALYTICS;
CREATE OR REPLACE ROLE PROD_CONTINGENT;

CREATE or REPLACE ROLE DEV_ADMIN;
CREATE OR REPLACE ROLE DEV_SECOPS;
CREATE or REPLACE ROLE DEV_AUTOMATION;
CREATE OR REPLACE ROLE DEV_ANALYTICS;
CREATE OR REPLACE ROLE DEV_CONTINGENT;


------- Grant Functional Roles -------

GRANT ROLE PROD_ADMIN      TO ROLE SYSADMIN;
GRANT ROLE PROD_SECOPS     TO ROLE PROD_ADMIN;
GRANT ROLE PROD_AUTOMATION TO ROLE PROD_ADMIN;
GRANT ROLE PROD_ANALYTICS  TO ROLE PROD_ADMIN;
GRANT ROLE PROD_CONTINGENT TO ROLE PROD_ADMIN;

GRANT ROLE DEV_ADMIN      TO ROLE SYSADMIN;
GRANT ROLE DEV_SECOPS     TO ROLE DEV_ADMIN;
GRANT ROLE DEV_AUTOMATION TO ROLE DEV_ADMIN;
GRANT ROLE DEV_ANALYTICS  TO ROLE DEV_ADMIN;
GRANT ROLE DEV_CONTINGENT TO ROLE DEV_ADMIN;

------- Grant Usage on Prod WH -------

GRANT USAGE ON WAREHOUSE PROD_ANALYTICS_WH to ROLE PROD_ADMIN;
GRANT USAGE ON WAREHOUSE PROD_DATASCIENCE_WH to ROLE PROD_ADMIN;
GRANT USAGE ON WAREHOUSE PROD_DATA_ENG_WH to ROLE PROD_ADMIN;
GRANT USAGE ON WAREHOUSE PROD_ANALYTICS_WH to ROLE PROD_ANALYTICS;

------- Grant Usage on Dev WH -------

GRANT USAGE ON WAREHOUSE DEV_ANALYTICS_WH to ROLE DEV_ADMIN;
GRANT USAGE ON WAREHOUSE DEV_DATASCIENCE_WH to ROLE DEV_ADMIN;
GRANT USAGE ON WAREHOUSE DEV_DATA_ENG_WH to ROLE DEV_ADMIN;
GRANT USAGE ON WAREHOUSE DEV_ANALYTICS_WH to ROLE DEV_ANALYTICS;
'''

print(build_admin_permissions)
exe_permission_matrix=  ctx.execute_string(f'USE ROLE ACCOUNTADMIN;{build_admin_permissions}',remove_comments=True)
for c in exe_permission_matrix:
    for row in c :
        print(row)
