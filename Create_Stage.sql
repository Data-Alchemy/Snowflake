--- Will Create storage integration to adls bucket ----;
Use role ACCOUNTADMIN;

CREATE or Replace STORAGE INTEGRATION PNI_ADLS_DATALAKE_BRONZE_INT 
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = ADLS
  ENABLED = TRUE
  STORAGE_ADLS_ROLE_ARN = ''
  STORAGE_ADLS_OBJECT_ACL = '' 
  STORAGE_ALLOWED_LOCATIONS = ('');

GRANT USAGE ON INTEGRATION PNI_ADLS_DATALAKE_BRONZE_INT TO ROLE SYSADMIN

DESC INTEGRATION PNI_ADLS_DATALAKE_BRONZE_INT;


---------------- create file formats for stage ----------------
use role SYSADMIN;

  create or replace file format csv_format
  type = 'csv'
  field_delimiter = ','
  skip_header = 1
  empty_field_as_null = true
  compression = gzip
  ;

 create or replace file format json_format
  type = 'JSON'
  strip_outer_array = true;
  


---------------- create ADLS file formats ----------------
USE role SYSADMIN;

Use Database PROD_BRONZE_DB;
Use Schema STAGING;
  create or replace file format csv_format
  type = 'csv'
  field_delimiter = ','
  skip_header = 1
  empty_field_as_null = true
  compression = gzip
  ;
  
  create or replace file format json_format
  type = 'JSON'
  strip_outer_array = true;

---------------- create adls stage ----------------
USE role SYSADMIN;
Use Database PROD_BRONZE_DB;
Use Schema STAGING;

create or replace stage PNI_ADLS_BRONZE_STG_CSV
  storage_integration = PNI_ADLS_DATALAKE_BRONZE_INT
  url = ''
  file_format = csv_format;
  ;
DESCRIBE STAGE PNI_ADLS_BRONZE_STG_CSV;
 
create or replace stage PNI_ADLS_BRONZE_STG_Sample_CSV
  storage_integration = PNI_ADLS_DATALAKE_BRONZE_INT
  url = ''
  file_format = csv_format;
  ;
DESCRIBE STAGE PNI_ADLS_BRONZE_STG_Sample_CSV;
 ------------------------------------------------
