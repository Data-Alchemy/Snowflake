create or replace database ADMIN
    comment = 'The admin database contains schemas that support the platform administration and automation in the account, e.g. RBAC access role automation';
create schema  SECADMIN
    comment = 'The secadmin schema contains objects that support SecOps in the account, e.g. RBAC access role automation';
grant usage on database admin to useradmin;
grant usage on schema secadmin to useradmin;

//Create metadata table to store information used to generate access roles for a given database
use ADMIN.SECADMIN;
    
DROP TABLE IF EXISTS rbac_grants ;

CREATE TABLE rbac_grants (
--
  id               VARCHAR(40)   DEFAULT UUID_STRING()          NOT NULL,
  future_grant     BOOLEAN                                      NOT NULL,
  privilege        VARCHAR(255)                                 NOT NULL,
  object_level     VARCHAR(255)                                 NOT NULL,
  role_level       VARCHAR(255)                                 NOT NULL,
  ordinal          INTEGER                                      NOT NULL,
  created_role     VARCHAR(255)  DEFAULT CURRENT_ROLE()         NOT NULL,
  created_by       VARCHAR(100)  DEFAULT CURRENT_USER()         NOT NULL,
  created_on       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP()    NOT NULL,
  updated_role     VARCHAR(255)  DEFAULT CURRENT_ROLE()         NOT NULL,
  updated_by       VARCHAR(100)  DEFAULT CURRENT_USER()         NOT NULL,
  updated_on       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP()    NOT NULL
--
) 
  COMMENT = 'Contains the grants required by RBAC access role best practices' ;

ALTER TABLE rbac_grants ADD CONSTRAINT pk_rbac_grants PRIMARY KEY (id) ;

// The index counter at the end must NOT have any gaps
// .. and must be sequential starting with 1
// .. Please make sure when updating the script below to adhere to this
//
INSERT INTO rbac_grants (privilege,  object_level, role_level, future_grant, ordinal)
VALUES
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
--   ,('CREATE MATERIALIZED VIEW',                            'SCHEMA', 'SFULL',     FALSE, 34)
--   ,('CREATE MASKING POLICY',                               'SCHEMA', 'SFULL',     FALSE, 35)
--   ,('CREATE ROW ACCESS POLICY',                            'SCHEMA', 'SFULL',     FALSE, 36)

   
;

SELECT * FROM admin.secadmin.rbac_grants;

// Create procedure that will read the metadata and generate the scripts
//
CREATE OR REPLACE PROCEDURE admin.secadmin.sp_rbac_create_access_role (
--
   database_arr    ARRAY,    -- pass the list of databases for the schema-level access roles
   warehouse_arr   ARRAY,    -- pass the list of warehouses for the warehouse-level access roles
   execute_grants  BOOLEAN 
--
)
RETURNS VARIANT NOT NULL     -- will return a JSON string containg the DDL to create roles and grants, will also contain a log of any grants if in_EXECUTE_GRANTS specified
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$

//
//  Assign variables
// This variable will hold a JSON data structure that holds ONE row.
//

var json_row_ddl = {};

// This array will contain all the rows.
var array_of_ddl_rows = [];

// This variable will hold a JSON data structure that we can return as a VARIANT.
// This will contain ALL the rows in a single "value".

var json_tbl_ddl = {};
   
var exec_grants_bool      = false;
var create_tech_role_bool = false;
   
if (EXECUTE_GRANTS != undefined) {
    exec_grants_bool = EXECUTE_GRANTS;
}

//
//  Access roles - Schema level
//

var base_access_role_ddl = [
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
];

// Get schema grants
select_sql = `SELECT privilege, object_level, role_level, future_grant FROM rbac_grants WHERE object_level = 'SCHEMA' ORDER BY ordinal`;
select_exec = {sqlText: select_sql};
stmt = snowflake.createStatement(select_exec);
rs = stmt.execute();

// Add schema-level grants
while (rs.next())  {
    var privilege    = rs.getColumnValue('PRIVILEGE');
    var object_level = rs.getColumnValue('OBJECT_LEVEL');
    var role_level   = rs.getColumnValue('ROLE_LEVEL').toLowerCase();
    var future_grant = rs.getColumnValue('FUTURE_GRANT');
    
    // Added below to handle granting CREATE <objecttype> privileges on a schema
    var prep = (privilege.toUpperCase().includes("CREATE")) ? "on" : "in";
    
    // Added below to handle transferring ownership of objects with existing outbound grants
    var copy_grants = (privilege.toUpperCase().includes("OWNERSHIP")) ? " COPY CURRENT GRANTS" : "";
    
    var base_grant = `GRANT ${privilege} ${prep} ${object_level} <database_name>.<schema_name> to ROLE <database_name>_<schema_name>_${role_level}${copy_grants};`;
    
    var base_future_grant = base_grant.replace(/ ALL /g, " FUTURE " );
    base_access_role_ddl.push(`${base_grant}`);
    if (future_grant) { 
       base_access_role_ddl.push(`${base_future_grant}`); 
    }
}

// Step 1 - loop through databases, get schemas

for (var database_cnt = 0; database_cnt < DATABASE_ARR.length; database_cnt++) {
     var database_name = DATABASE_ARR[database_cnt];
     var show_schema_sql = "show schemas  in database " + database_name;
     var select_schema_sql = "select schema_name from " + database_name + ".information_schema.schemata where schema_name not in ('PUBLIC', 'INFORMATION_SCHEMA')";
     

      var select_schema_exec = {sqlText: select_schema_sql};
      var stmt = snowflake.createStatement(select_schema_exec);
      var rs = stmt.execute();
      
      // Read each row and add it to the array we will return.      
      while (rs.next())  {      
         
         for (var ddl_stmt_cnt = 0; ddl_stmt_cnt < base_access_role_ddl.length; ddl_stmt_cnt++) {
             json_row_ddl = {};
             var schema_name = rs.getColumnValue('SCHEMA_NAME').toLowerCase();
             json_row_ddl["database"] = database_name;
             json_row_ddl["schema"] = schema_name;
             
             var ddl = base_access_role_ddl[ddl_stmt_cnt];
             json_row_ddl["ddl_ordinal"] = ddl_stmt_cnt + 1;
             var create_access_ddl = ddl.replace(/<database_name>/g, database_name.toLowerCase()).replace(/<schema_name>/g, schema_name);
             json_row_ddl["create_access_ddl"] = create_access_ddl;
             json_row_ddl["ddl_executed"] = exec_grants_bool;
             var execution_result = "";
             var error_message = "";
             if (exec_grants_bool) {
                 var ddl_rbac = {sqlText: create_access_ddl};
                 try {
                      var ddl_stmt = snowflake.createStatement(ddl_rbac);
                      //var ddl_rs = snowflake.execute( {sqlText: "use role sysadmin;"} );
                      var ddl_rs = ddl_stmt.execute();
                      execution_result = "Success";
                 }  catch (err)  {
                      execution_result = "Failure";
                      error_message = err;  
                 }
             }
             json_row_ddl["ddl_execution_status"] = execution_result;
             json_row_ddl["ddl_execution_message"] = error_message;
             array_of_ddl_rows.push(json_row_ddl);
         }
      }
}


//
//  Access roles - Warehouse level
//


//var base_access_role_wh_ddl = [
//"USE ROLE <database_name>_roleadmin;",
//"CREATE or REPLACE ROLE  <warehouse_name>_wu;",
//"CREATE or REPLACE ROLE  <warehouse_name>_wuo;",
//"CREATE or REPLACE ROLE  <warehouse_name>_wfull;",
//"GRANT ROLE <warehouse_name>_wu TO ROLE <warehouse_name>_wuo;",
//"GRANT ROLE <warehouse_name>_wuo TO ROLE <warehouse_name>_wfull;",
//"GRANT ROLE <warehouse_name>_wfull TO ROLE <database_name>_whadmin;",
//"USE ROLE <database_name>_whadmin;"
//];
//
//// Get warehouse grants
//select_sql = `select privilege,  object_level, role_level, future_grant
//                from bmc_rbac_grants
//               where object_level = 'warehouse'
//            order by ordinal`;
//select_exec = {sqlText: select_sql};
//stmt = snowflake.createStatement(select_exec);
//rs = stmt.execute();
//
// Add warehouse-level grants
//while (rs.next())  {
//    var privilege = rs.getColumnValue('PRIVILEGE');
//    var future_grant = rs.getColumnValue('FUTURE_GRANT');
//    var object_level = rs.getColumnValue('OBJECT_LEVEL');
//    var role_level = rs.getColumnValue('ROLE_LEVEL').toLowerCase();
//    var base_grant = `GRANT ${privilege} on ${object_level} <warehouse_name> to ROLE <warehouse_name>_${role_level};`;
//    base_access_role_wh_ddl.push(`${base_grant}`);
//}
//for (var warehouse_cnt = 0; warehouse_cnt < WAREHOUSE_ARR.length; warehouse_cnt++) {
//     var warehouse_name = WAREHOUSE_ARR[warehouse_cnt].toLowerCase();
//         for (var ddl_stmt_cnt = 0; ddl_stmt_cnt < base_access_role_wh_ddl.length; ddl_stmt_cnt++) {
//             json_row_ddl = {};
//             json_row_ddl["warehouse"] = warehouse_name;
//             
//             var ddl = base_access_role_wh_ddl[ddl_stmt_cnt];
//             json_row_ddl["ddl_ordinal"] = ddl_stmt_cnt + 1;
//             var create_access_ddl = ddl.replace(/<warehouse_name>/g, warehouse_name).replace(/<database_name>/g, database_name.toLowerCase());
//             json_row_ddl["create_access_ddl"] = create_access_ddl;
//             json_row_ddl["ddl_executed"] = exec_grants_bool;
//             var execution_result = "";
//             var error_message = "";
//             if (exec_grants_bool) {
//                 var ddl_rbac = {sqlText: create_access_ddl};
//                 try {
//                      var ddl_stmt = snowflake.createStatement(ddl_rbac);
//                      //var ddl_rs = snowflake.execute( {sqlText: "use role sysadmin;"} );
//                      var ddl_rs = ddl_stmt.execute();
//                      execution_result = "Success";
//                 }  catch (err)  {
//                      execution_result = "Failure";
//                      error_message = err;  
//                 }
//             }
//             json_row_ddl["ddl_execution_status"] = execution_result;
//             json_row_ddl["ddl_execution_message"] = error_message;
//             array_of_ddl_rows.push(json_row_ddl);
//         }
//}

// Return the rows, which expects a JSON-compatible VARIANT.
      
json_tbl_ddl = { "rbac_access_role_script" : array_of_ddl_rows };
return json_tbl_ddl;
$$
;

// generate the script in TWO steps: CALL the procedure, and then SELECT from the output using result_scan()
//
CALL admin.secadmin.sp_rbac_create_access_role(
--
    ARRAY_CONSTRUCT('DEV_BRONZE_DB','DEV_SILVER_DB','DEV_GOLD_DB','PROD_BRONZE_DB','PROD_SILVER_DB','PROD_GOLD_DB'), -- array of databases
    NULL, -- ignore warehouses for now
    FALSE  -- false means "don't actually execute the DDL with this procedure call, just output it as JSON"                        

) ; 

SELECT lf.value:create_access_ddl::string ddl
FROM TABLE(result_scan(last_query_id())) q , lateral flatten( input => q.sp_rbac_create_access_role:rbac_access_role_script ) lf ;  

