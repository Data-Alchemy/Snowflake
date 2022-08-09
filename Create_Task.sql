--Create Procedure with logic first
CREATE OR REPLACE PROCEDURE PROD_BRONZE_DB.APPLICATION_DATA.COPY_INTO_PROCEDURE_LOG_QUERY_HISTORY_FAILURES()
RETURNS VARIANT
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
    var rows = [];
    var n = new Date();
    var year = String(n.getFullYear())
    var month = String(n.getMonth() + 1).padStart(2, '0')
    var day = String(n.getDate() -1).padStart(2, '0')
    // May need refinement to zero-pad some values or achieve a specific format
    var datetime = `${n.getFullYear()}${n.getMonth()+1}${n.getDate()}${n.getHours()}${n.getMinutes()}${n.getSeconds()}`;
    var datepath = `${year}/${month}/${day}`;
    var st = snowflake.createStatement({
        sqlText: `copy into @BRONZE_APPLICATION_DATA/general/Snowflake_Logs/QUERY_HISTORY_FAILURES/${datepath}/query_history_error_${datetime}_log.json.gz from
    (select object_construct(*) from (
        Select * from "SNOWFLAKE"."ACCOUNT_USAGE"."QUERY_HISTORY" where EXECUTION_STATUS = 'FAIL' 
        AND date(START_TIME) >= dateadd(day, -1,date(CURRENT_TIMESTAMP()))
        order by START_TIME asc))
       file_format = (type ='JSON' COMPRESSION = GZIP)
       SINGLE = TRUE
       OVERWRITE = TRUE 
       ;`
    });

    var result = st.execute();
    result.next();
    rows.push(result.getColumnValue(1))

    return rows;
$$;
--Create Task to run procedure
CREATE OR REPLACE TASK PROD_BRONZE_DB.APPLICATION_DATA.AZURE_LOG_QUERY_HISTORY_FAILURES warehouse=PROD_DATA_ENG_WH schedule= 'USING CRON 0 3 * * * UTC' as  CALL PROD_BRONZE_DB.APPLICATION_DATA.COPY_INTO_PROCEDURE_LOG_QUERY_HISTORY_FAILURES();
--Enable task to run
ALTER TASK PROD_BRONZE_DB.APPLICATION_DATA.AZURE_LOG_QUERY_HISTORY_FAILURES RESUME; 
