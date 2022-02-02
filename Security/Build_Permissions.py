import pandas as pd
import snowflake.connector
import getpass as pwd


pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth',None)

default_warehouse = 'PROD_ANALYTICS_WH'


ctx = snowflake.connector.connect(
    user='ZM_PROD_DEVOPS_ADMIN',
    password='7bda50233add907d18e2a2e866c073a1',
    account='xoa77688'
    )

gen_schema_sql = '''
USE ROLE ACCOUNTADMIN;
USE PROD_BRONZE_DB;
USE WAREHOUSE PROD_ELT_WH;
show schemas in account;
'''

cursor_list=  ctx.execute_string(f'{gen_schema_sql}',remove_comments=True)
schema_df = pd.DataFrame(cursor_list[-1],columns=['timestamp','Schema','n','n2','Database','Owner','Comment','n3','active'])
schema_df = schema_df[['Database','Schema']]
schema_df_filter1 = schema_df['Schema'].str.contains('INFORMATION_SCHEMA')==False
schema_df_filter2 = schema_df['Schema'].str.contains('PUBLIC')==False
schema_df_filter3 = schema_df['Schema'].str.contains('SAMPLE')==False
database_df_filter1 = schema_df['Database'].str.contains('BRONZE') == True
database_df_filter2 = schema_df['Database'].str.contains('SILVER') == True
database_df_filter3 = schema_df['Database'].str.contains('GOLD') == True
database_df_filter4 = schema_df['Database'].str.contains('ADMIN') == True

schema_df = schema_df[(database_df_filter1 | database_df_filter2 | database_df_filter3 | database_df_filter4 )&(schema_df_filter1 & schema_df_filter2 & schema_df_filter3)]
print(schema_df)

gen_permissions_sql = '''
USE ROLE ACCOUNTADMIN;
USE DATABASE ADMIN;
USE SCHEMA SECOPS;
SELECT * FROM RBAC_GRANTS
'''
cursor_list         = ctx.execute_string(f'{gen_permissions_sql}',remove_comments=True)
permissions_df      = pd.DataFrame(cursor_list[-1],columns=['id','future_grant','privilege','object_level','role_level','PARENT_HIERARCHY','ordinal','created_role','created_by','created_on','updated_role','updated_by','updated_on'])
permissions_df      = permissions_df[['future_grant','privilege','role_level','PARENT_HIERARCHY','object_level']]



permission_schema_df                                = schema_df.merge(permissions_df, how = 'cross')
'''permission_schema_df['Environment']                 = permission_schema_df.apply(lambda x: f'{"DEV" if "DEV" in x["Database"] else "PROD" if "PROD" in x["Database"] or "ADMIN" in x["Database"] else "SANDBOX"}',axis = 1 )
permission_schema_df['Environment_Admin']           = permission_schema_df.apply(lambda x: f'{x["Environment"]}_ADMIN',axis = 1 )
permission_schema_df['ADMIN_ROLES']                 = """USE ROLE SECURITYADMIN;CREATE OR REPLACE ROLE PROD_ADMIN;CREATE or REPLACE ROLE DEV_ADMIN;GRANT ROLE PROD_ADMIN      TO ROLE SYSADMIN;GRANT ROLE DEV_ADMIN      TO ROLE SYSADMIN;GRANT USAGE ON WAREHOUSE PROD_ANALYTICS_WH to ROLE PROD_ADMIN;GRANT USAGE ON WAREHOUSE PROD_ELT_WH to ROLE PROD_ADMIN;GRANT USAGE ON WAREHOUSE DEV_ELT_WH to ROLE DEV_ADMIN;"""
permission_schema_df['Role_Name']                   = permission_schema_df.apply(lambda x: f'{x["Database"]}_{x["Schema"]}_{x["role_level"]}',axis = 1 )
permission_schema_df['ADMIN_GRANTS']                = permission_schema_df.apply(lambda x : f'Grant {x["privilege"]} DATABASE {x["Database"]} to role DEV_ADMIN COPY CURRENT GRANTS;' if "DEV" in x["Database"] and "ADMIN" not in x["Database"] and "OWNERSHIP" in x["privilege"] else f'Grant {x["privilege"]} DATABASE {x["Database"]} to role PROD_ADMIN COPY CURRENT GRANTS;' if "OWNERSHIP" in x["privilege"] and "ADMIN" not in x["Database"] else '', axis =1 )
permission_schema_df['Parent_Role_Name']            = permission_schema_df.apply(lambda x: f'{x["Database"]}_{x["Schema"]}_{x["PARENT_HIERARCHY"]}',axis = 1 )
permission_schema_df['Role_Groups']                 = permission_schema_df.apply(lambda x: f'{x["Database"]}_{x["role_level"]}',axis = 1 )
permission_schema_df['Parent_Role_Groups']          = permission_schema_df.apply(lambda x: f'{x["Database"]}_{x["PARENT_HIERARCHY"]}' if x['PARENT_HIERARCHY']!= "ADMIN" else x["Environment_Admin"],axis = 1 )
permission_schema_df['Create Permission Roles']     = permission_schema_df.apply(lambda x: f'Create or Replace role {x["Role_Name"]};',axis = 1 )
permission_schema_df['Create Permission Groups']    = permission_schema_df.apply(lambda x: f'Create or Replace role {x["Role_Groups"]};',axis = 1 )
permission_schema_df['Grant Roles to Groups']       = permission_schema_df.apply(lambda x: f'Grant role {x["Role_Name"]} to role {x["Role_Groups"]};'if "SYSADMIN" not in x['PARENT_HIERARCHY'] else f'Grant role {x["Role_Name"]} to role SYSADMIN;',axis = 1 )
permission_schema_df['Cascade Role Grants']         = permission_schema_df.apply(lambda x: f'Grant role {x["Role_Name"]} to role {x["Parent_Role_Name"]};'if "ADMIN" not in x['PARENT_HIERARCHY'] and "ADMIN" not in x['role_level'] else (f'Grant role {x["Role_Name"]} to role {"DEV_ADMIN;"if "DEV" in x["Database"] else "PROD_ADMIN;"}'),axis = 1 )
permission_schema_df['Cascade Group Grants']        = permission_schema_df.apply(lambda x: f'Grant role {x["Role_Groups"]} to role {x["Parent_Role_Groups"]};'if "ADMIN" not in  x['PARENT_HIERARCHY'] and "ADMIN" not in x['role_level']  else (f'Grant role {x["Role_Groups"]} to role {"DEV_ADMIN;"if "DEV" in x["Database"] else "PROD_ADMIN;"}'),axis = 1 )
permission_schema_df['Build Group Tree']            = permission_schema_df.apply(lambda x: f'Grant role {x["Role_Name"]} to role {x["Role_Groups"]};'if "ADMIN" not in  x['PARENT_HIERARCHY'] and "ADMIN" not in x['role_level'] else (f'Grant role {x["Role_Groups"]} to role {"DEV_ADMIN;"if "DEV" in x["Database"] else "PROD_ADMIN;"}'),axis = 1 )
permission_schema_df['Grant Warehouse Usage']       = permission_schema_df.apply(lambda x: f'Grant Usage on WAREHOUSE {default_warehouse} to role {x["Role_Name"]};', axis = 1 )
permission_schema_df['Grant Database Usage']        = permission_schema_df.apply(lambda x: f'Grant Usage on Database {x["Database"]} to role {x["Role_Name"]};', axis = 1 )
permission_schema_df['Grant Usage']                 = permission_schema_df.apply(lambda x: f'Grant Usage on SCHEMA {x["Database"]}.{x["Schema"]} to role {x["Role_Name"]};', axis = 1 )
permission_schema_df['Issue Grants']                = permission_schema_df.apply(lambda x : f'Grant {x["privilege"]} SCHEMA {x["Database"]}.{x["Schema"]} to role {x["Role_Name"]} COPY CURRENT GRANTS;' if "OWNERSHIP" in x["privilege"] else f'Grant {x["privilege"]} SCHEMA {x["Database"]}.{x["Schema"]} to role {x["Role_Name"]};', axis =1 )
'''

permission_schema_df['Environment']                         = permission_schema_df.apply(lambda x: f'{"DEV" if "DEV" in x["Database"] else "PROD" if "PROD" in x["Database"] or "ADMIN" in x["Database"] else "SANDBOX"}',axis = 1 )
permission_schema_df['Environment_Admin']                   = permission_schema_df.apply(lambda x: f'{x["Environment"]}_ADMIN',axis = 1 )
permission_schema_df['source_role']                         = permission_schema_df.apply(lambda x : x["Database"]+'_'+x["Schema"]+'_'+x["role_level"] if "SYSADMIN" not in x["PARENT_HIERARCHY"] else x["Environment_Admin"], axis = 1 )
permission_schema_df['target_role']                         = permission_schema_df.apply(lambda x : x["Database"]+'_'+x["Schema"]+'_'+x["PARENT_HIERARCHY"] if "ADMIN" not in x["PARENT_HIERARCHY"]  else x["PARENT_HIERARCHY"] if "SYSADMIN" in x["PARENT_HIERARCHY"] else x["Environment_Admin"], axis = 1 )
permission_schema_df['Create Permission Roles']             = permission_schema_df.apply(lambda x: f'Create or Replace role {x["source_role"]};',axis = 1 )
permission_schema_df['Grant Warehouse Usage']               = permission_schema_df.apply(lambda x: f'Grant Usage on WAREHOUSE {default_warehouse} to role {x["source_role"]};', axis = 1 )
permission_schema_df['Grant Database Usage']                = permission_schema_df.apply(lambda x: f'Grant Usage on Database {x["Database"]} to role {x["source_role"]};', axis = 1 )
permission_schema_df['Grant Schema Usage']                  = permission_schema_df.apply(lambda x: f'Grant Usage on SCHEMA {x["Database"]}.{x["Schema"]} to role {x["source_role"]};', axis = 1 )
permission_schema_df['Issue Grants']                        = permission_schema_df.apply(lambda x : f'Grant {x["privilege"]} {x["object_level"]} {x["Database"]}.{x["Schema"]} to role {x["source_role"]} COPY CURRENT GRANTS;' if "OWNERSHIP" in x["privilege"] else f'Grant {x["privilege"]} {x["object_level"]} {x["Database"]} to role {x["source_role"]};' if "DATABASE" in x["object_level"] else f'Grant {x["privilege"]} {x["object_level"]} {x["Database"]}.{x["Schema"]} to role {x["source_role"]};', axis =1 )
permission_schema_df['Cascade Role Grants']                 = permission_schema_df.apply(lambda x : f'Grant role {x["source_role"]} to role {x["target_role"]};',axis =1)
permission_schema_df['source_role_group']                   = permission_schema_df.apply(lambda x : f'{x["Database"]}_{x["role_level"]}' if "SYSADMIN" not in x["PARENT_HIERARCHY"]  else x["Environment_Admin"], axis = 1 )
permission_schema_df['target_role_group']                   = permission_schema_df.apply(lambda x : f'{x["Database"]}_{x["PARENT_HIERARCHY"]}' if "ADMIN" not in x["PARENT_HIERARCHY"]  else x["PARENT_HIERARCHY"] if "SYSADMIN" in x["PARENT_HIERARCHY"] else x["Environment_Admin"], axis = 1 )
permission_schema_df['Create Permission Groups']            = permission_schema_df.apply(lambda x:  f'Create or Replace role {x["source_role_group"]};',axis = 1 )
permission_schema_df['Grant Roles to Groups']               = permission_schema_df.apply(lambda x: f'Grant role {x["source_role"]} to role {x["source_role_group"]};' if "SYSADMIN" not in x["PARENT_HIERARCHY"] else "",axis = 1 )
permission_schema_df['Cascade Group Grants']                = permission_schema_df.apply(lambda x : f'Grant role {x["source_role_group"]} to role {x["target_role_group"]};',axis =1)

### generate sql executabel ###
listofdf = []
# create sql elements #
sql_create_roles                    = permission_schema_df['Create Permission Roles'].drop_duplicates()
sql_create_groups                   = permission_schema_df['Create Permission Groups'].drop_duplicates()
sql_grant_warehouse_usage           = permission_schema_df['Grant Warehouse Usage'].drop_duplicates()
sql_grant_database_usage            = permission_schema_df['Grant Database Usage'].drop_duplicates()
sql_grant_schema_usage              = permission_schema_df['Grant Schema Usage'].drop_duplicates()
sql_issue_grants                    = permission_schema_df['Issue Grants'].drop_duplicates()
sql_cascade_roles                   = permission_schema_df['Cascade Role Grants'].drop_duplicates()
sql_roles_to_groups                 = permission_schema_df['Grant Roles to Groups'].drop_duplicates()
sql_cascade_groups                  = permission_schema_df['Cascade Group Grants'].drop_duplicates()
# combine sql elements into a single sql list #
listofdf.append(sql_create_roles)
listofdf.append(sql_create_groups)
listofdf.append(sql_grant_warehouse_usage)
listofdf.append(sql_grant_database_usage)
listofdf.append(sql_grant_schema_usage)
listofdf.append(sql_issue_grants)
listofdf.append(sql_cascade_roles)
listofdf.append(sql_roles_to_groups)
listofdf.append(sql_cascade_groups)




build_all_permissions   = pd.concat(listofdf)
#print(permission_schema_df[['privilege','role_level','Role_Name','Parent_Role_Name','Role_Groups','Parent_Role_Groups','Create Permission Roles','Create Permission Groups','Grant Roles to Groups','Cascade Role Grants','Cascade Group Grants']])


build_all_permissions= build_all_permissions.to_string(index=False)
print(build_all_permissions)
exe_permission_matrix=  ctx.execute_string(f'USE ROLE ACCOUNTADMIN;{build_all_permissions}',remove_comments=True)
for c in exe_permission_matrix:
    for row in c :
        print(row)
