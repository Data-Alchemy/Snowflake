
With Meta_Table_Size as 
(
Select 
TABLE_ID                                                         as TABLE_ID,
TABLE_CATALOG                                                    as TABLE_CATALOG, 
TABLE_SCHEMA                                                     as TABLE_SCHEMA, 
TABLE_NAME                                                       as TABLE_NAME, 
TABLE_TYPE                                                       as TABLE_TYPE, 
to_varchar(row_count, '999,999,999,999.00')                      as row_number,
to_varchar(BYTES / (1024 * 1024 * 1024), '999,999,999,999.0000') as GB
from   snowflake.account_usage.tables a
where TABLE_CATALOG     = 'PROD_BRONZE_DB'
AND deleted IS NULL
and TABLE_SCHEMA        != 'STAGING'
order by  TABLE_SCHEMA asc,
    TABLE_TYPE asc,
    TABLE_NAME ASC
),
  
Meta_Columns as 
(
Select 
  table_id                                                      as TABLE_ID,
  count(1)                                                      as COUNT_OF_COLUMNS
  from snowflake.account_usage.COLUMNS
  where TABLE_ID in (Select distinct TABLE_ID from Meta_Table_Size)
  group by TABLE_ID
)
Select tbl.*,
col.COUNT_OF_COLUMNS                                            as Count_Of_Columns
from Meta_Table_Size tbl
join Meta_Columns       as col      on tbl.TABLE_ID = col.TABLE_ID 
