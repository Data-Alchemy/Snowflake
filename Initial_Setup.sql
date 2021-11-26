  ----------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------
                        --------- CREATE DB & Schemas DEV ---------
  USE ROLE SYSADMIN;
  -- create dev databases for each data source: source1, source2 etc.,
  CREATE DATABASE dev_bronze_db COMMENT = 'Bronze database is organized by source system';
    USE DATABASE dev_bronze_db;
    Create or Replace Schema LDW COMMENT = 'Schema for Legacy DW related data';
 ----------------------------------------------------------------------------------------
 CREATE DATABASE dev_silver_db COMMENT = 'Silver database is organized by source system';
  USE DATABASE dev_silver_db;
  Create or Replace Schema LDW COMMENT = 'Schema for Legacy DW related data';
----------------------------------------------------------------------------------------
 CREATE DATABASE dev_gold_db COMMENT = 'Gold database is organized by use case';
  USE DATABASE dev_gold_db;
  Create or Replace Schema LDW COMMENT = 'Schema for Legacy DW related data';
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
                      --------- CREATE DB & Schemas Prod ---------             
  USE ROLE SYSADMIN;
  -- create dev databases for each data source: source1, source2 etc.,
  CREATE DATABASE prod_bronze_db COMMENT = 'Bronze database is organized by source system';
    USE DATABASE prod_bronze_db;
    Create or Replace Schema LDW COMMENT = 'Schema for Legacy DW related data';
 ----------------------------------------------------------------------------------------
 CREATE DATABASE prod_silver_db COMMENT = 'Silver database is organized by source system';
  USE DATABASE prod_silver_db;
  Create or Replace Schema LDW COMMENT = 'Schema for Legacy DW related data';
 ---------------------------------------------------------------------------------------- 
 CREATE DATABASE prod_gold_db COMMENT = 'Gold database is organized by business case';
  USE DATABASE prod_gold_db;
  Create or Replace Schema LDW COMMENT = 'Schema for Legacy DW related data';
 ----------------------------------------------------------------------------------------
                       --------- CREATE WH ENV ----------
CREATE OR REPLACE WAREHOUSE PROD_DATA_ENG_WH 
WITH WAREHOUSE_SIZE = 'XSMALL' 
    WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 300
    STATEMENT_TIMEOUT_IN_SECONDS = 3600
    INITIALLY_SUSPENDED = TRUE
    AUTO_RESUME = TRUE 
    MIN_CLUSTER_COUNT = 1 
    MAX_CLUSTER_COUNT = 1 
    SCALING_POLICY = 'STANDARD' 
COMMENT = 'Ipaas application and data transformation';
----------------------------------------------------------------------------------------
CREATE OR REPLACE WAREHOUSE PROD_DATASCIENCE_WH
WITH WAREHOUSE_SIZE = 'XSMALL' 
    WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 300
    STATEMENT_TIMEOUT_IN_SECONDS = 3600
    INITIALLY_SUSPENDED = TRUE
    AUTO_RESUME = TRUE 
    MIN_CLUSTER_COUNT = 1 
    MAX_CLUSTER_COUNT = 2 
    SCALING_POLICY = 'STANDARD' 
COMMENT = 'Compute heavy workloads';
----------------------------------------------------------------------------------------
CREATE OR REPLACE WAREHOUSE PROD_ANALYTICS_WH
WITH WAREHOUSE_SIZE = 'XSMALL' 
    WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 600
    STATEMENT_TIMEOUT_IN_SECONDS = 3600
    INITIALLY_SUSPENDED = TRUE
    AUTO_RESUME = TRUE 
    MIN_CLUSTER_COUNT = 1 
    MAX_CLUSTER_COUNT = 2
    SCALING_POLICY = 'STANDARD' 
COMMENT = 'data exploration';
----------------------------------------------------------------------------------------
