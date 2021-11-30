"USE ROLE USERADMIN;",
"CREATE ROLE IF NOT EXISTS <database_name>_<schema_name>_sr;",
"CREATE ROLE IF NOT EXISTS <database_name>_<schema_name>_srw;",
"CREATE ROLE IF NOT EXISTS <database_name>_<schema_name>_sfull;",
"GRANT ROLE <database_name>_<schema_name>_sr TO ROLE <database_name>_<schema_name>_srw;",
"GRANT ROLE <database_name>_<schema_name>_srw TO ROLE <database_name>_<schema_name>_sfull;",
"GRANT ROLE <database_name>_<schema_name>_sfull TO ROLE SYSADMIN;",
"USE ROLE SECURITYADMIN;",
"GRANT USAGE ON DATABASE <database_name> TO ROLE <database_name>_<schema_name>_sr;",
"GRANT USAGE ON SCHEMA <database_name>.<schema_name> TO ROLE <database_name>_<schema_name>_sr;"

"select schema_name from " + database_name + ".information_schema.schemata where schema_name not in ('PUBLIC', 'INFORMATION_SCHEMA')"

      ('SELECT ON ALL TABLES',                                'SCHEMA', 'SR',        TRUE,  01)
     ,('SELECT ON ALL VIEWS ',                                'SCHEMA', 'SR',        TRUE,  02)
     ,('USAGE, READ ON ALL STAGES',                           'SCHEMA', 'SR',        TRUE,  03)
     ,('USAGE ON ALL FILE FORMATS',                           'SCHEMA', 'SR',        TRUE,  04)
     ,('SELECT ON ALL STREAMS',                               'SCHEMA', 'SR',        TRUE,  05)
     ,('USAGE ON ALL FUNCTIONS',                              'SCHEMA', 'SR',        TRUE,  06)
     ,('INSERT, UPDATE, DELETE, REFERENCES ON ALL TABLES',    'SCHEMA', 'SRW',       TRUE,  07)
     ,('READ, WRITE ON ALL STAGES',                           'SCHEMA', 'SRW',       TRUE,  08)
     ,('USAGE ON ALL SEQUENCES',                              'SCHEMA', 'SRW',       TRUE,  09)
     ,('USAGE ON ALL PROCEDURES',                             'SCHEMA', 'SRW',       TRUE,  10)
     ,('MONITOR, OPERATE ON ALL TASKS',                       'SCHEMA', 'SRW',       TRUE,  11)
     ,('OWNERSHIP ON ALL TABLES',                             'SCHEMA', 'SFULL',     TRUE,  12)
     ,('OWNERSHIP ON ALL EXTERNAL TABLES',                    'SCHEMA', 'SFULL',     TRUE,  13)
     ,('OWNERSHIP ON ALL VIEWS ',                             'SCHEMA', 'SFULL',     TRUE,  14)
     ,('OWNERSHIP ON ALL MATERIALIZED VIEWS',                 'SCHEMA', 'SFULL',     TRUE,  15)
     ,('OWNERSHIP ON ALL STAGES',                             'SCHEMA', 'SFULL',     TRUE,  16)
     ,('OWNERSHIP ON ALL FILE FORMATS',                       'SCHEMA', 'SFULL',     TRUE,  17)
     ,('OWNERSHIP ON ALL STREAMS',                            'SCHEMA', 'SFULL',     TRUE,  18)
     ,('OWNERSHIP ON ALL PROCEDURES',                         'SCHEMA', 'SFULL',     TRUE,  19)
     ,('OWNERSHIP ON ALL FUNCTIONS',                          'SCHEMA', 'SFULL',     TRUE,  20)
     ,('OWNERSHIP ON ALL SEQUENCES ',                         'SCHEMA', 'SFULL',     TRUE,  21)
     ,('OWNERSHIP ON ALL TASKS',                              'SCHEMA', 'SFULL',     TRUE,  22)
     ,('CREATE TABLE',                                        'SCHEMA', 'SFULL',     FALSE, 23)
     ,('CREATE VIEW',                                         'SCHEMA', 'SFULL',     FALSE, 24)
     ,('CREATE FILE FORMAT',                                  'SCHEMA', 'SFULL',     FALSE, 25)
     ,('CREATE SEQUENCE',                                     'SCHEMA', 'SFULL',     FALSE, 26)
     ,('CREATE FUNCTION',                                     'SCHEMA', 'SFULL',     FALSE, 27)
     ,('CREATE STREAM',                                       'SCHEMA', 'SFULL',     FALSE, 28)
     ,('CREATE TASK',                                         'SCHEMA', 'SFULL',     FALSE, 29)
     ,('CREATE PROCEDURE',                                    'SCHEMA', 'SFULL',     FALSE, 30)
     ,('CREATE EXTERNAL TABLE',                               'SCHEMA', 'SFULL',     FALSE, 31)
     ,('CREATE STAGE',                                        'SCHEMA', 'SFULL',     FALSE, 32)
     ,('CREATE PIPE',                                         'SCHEMA', 'SFULL',     FALSE, 33)
      
      --- Functional Roles ----

use role SECURITYADMIN; 
GRANT ROLE PROD_ADMIN to ROLE USERADMIN;
GRANT ROLE PROD_AUTOMATION to ROLE PROD_ADMIN;
GRANT ROLE PROD_DATAENG to ROLE PROD_ADMIN;
GRANT ROLE PROD_ANALYTICS to ROLE PROD_ADMIN;
GRANT ROLE PROD_DATASCIENCE to ROLE PROD_ADMIN;
GRANT ROLE PROD_CONTINGENT to ROLE PROD_ADMIN;
GRANT ROLE PROD_SECOPS to ROLE PROD_ADMIN;

GRANT ROLE DEV_ADMIN to ROLE USERADMIN;
GRANT ROLE DEV_AUTOMATION to ROLE DEV_ADMIN;
GRANT ROLE DEV_DATAENG to ROLE DEV_ADMIN;
GRANT ROLE DEV_ANALYTICS to ROLE DEV_ADMIN;
GRANT ROLE DEV_DATASCIENCE to ROLE DEV_ADMIN;
GRANT ROLE DEV_CONTINGENT to ROLE DEV_ADMIN;
GRANT ROLE DEV_CONSUMER to ROLE DEV_ADMIN;
GRANT ROLE DEV_SECOPS to ROLE DEV_ADMIN;

--- Security Roles ----USE DATABASE DEV_BRONZE_DB


USE ROLE SECURITYADMIN;
GRANT ROLE DEV_ADMIN TO ROLE SYSADMIN;

USE ROLE 
USE DATABASE DEV_BRONZE_DB;
