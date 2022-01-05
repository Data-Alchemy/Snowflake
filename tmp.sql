USE ROLE USERADMIN;
CREATE ROLE IF NOT EXISTS dev_bronze_db_bamboo_sr;
CREATE ROLE IF NOT EXISTS dev_bronze_db_bamboo_srw;
CREATE ROLE IF NOT EXISTS dev_bronze_db_bamboo_sfull;
GRANT ROLE dev_bronze_db_bamboo_sr TO ROLE dev_bronze_db_bamboo_srw;
GRANT ROLE dev_bronze_db_bamboo_srw TO ROLE dev_bronze_db_bamboo_sfull;
GRANT ROLE dev_bronze_db_bamboo_sfull TO ROLE SYSADMIN;
USE ROLE SECURITYADMIN;
GRANT USAGE ON DATABASE dev_bronze_db TO ROLE dev_bronze_db_bamboo_sr;
GRANT USAGE ON SCHEMA dev_bronze_db.bamboo TO ROLE dev_bronze_db_bamboo_sr;
GRANT SELECT ON ALL TABLES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT SELECT ON FUTURE TABLES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT SELECT ON ALL VIEWS  in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT SELECT ON FUTURE VIEWS  in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT USAGE, READ ON ALL STAGES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT USAGE, READ ON FUTURE STAGES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT USAGE ON ALL FILE FORMATS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT USAGE ON FUTURE FILE FORMATS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT SELECT ON ALL STREAMS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT SELECT ON FUTURE STREAMS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT USAGE ON ALL FUNCTIONS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT USAGE ON FUTURE FUNCTIONS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sr;
GRANT INSERT, UPDATE, DELETE, REFERENCES ON ALL TABLES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT INSERT, UPDATE, DELETE, REFERENCES ON FUTURE TABLES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT READ, WRITE ON ALL STAGES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT READ, WRITE ON FUTURE STAGES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT USAGE ON ALL SEQUENCES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT USAGE ON FUTURE SEQUENCES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT USAGE ON ALL PROCEDURES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT USAGE ON FUTURE PROCEDURES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT MONITOR, OPERATE ON ALL TASKS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT MONITOR, OPERATE ON FUTURE TASKS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_srw;
GRANT OWNERSHIP ON ALL TABLES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE TABLES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL EXTERNAL TABLES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE EXTERNAL TABLES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL VIEWS  in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE VIEWS  in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL MATERIALIZED VIEWS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE MATERIALIZED VIEWS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL STAGES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE STAGES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL FILE FORMATS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE FILE FORMATS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL STREAMS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE STREAMS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL PROCEDURES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE PROCEDURES in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL FUNCTIONS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE FUNCTIONS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL SEQUENCES  in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE SEQUENCES  in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON ALL TASKS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT OWNERSHIP ON FUTURE TASKS in SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull COPY CURRENT GRANTS;
GRANT CREATE TABLE on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE VIEW on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE FILE FORMAT on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE SEQUENCE on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE FUNCTION on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE STREAM on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE TASK on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE PROCEDURE on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE EXTERNAL TABLE on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE STAGE on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;
GRANT CREATE PIPE on SCHEMA dev_bronze_db.bamboo to ROLE dev_bronze_db_bamboo_sfull;