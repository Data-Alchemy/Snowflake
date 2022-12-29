from snowflake.snowpark.functions import when_matched, when_not_matched
from snowflake.connector.pandas_tools import write_pandas
from snowflake.connector.pandas_tools import pd_writer
from snowflake.snowpark import *

import snowflake.connector
import pandas as pd
from ast import Str
import datetime
import json
import sys
import os
import re

import subprocess

###########################################################################


pd.set_option('display.max_rows'        , None)
pd.set_option('display.max_columns'     , None)
pd.set_option('display.width'           , None)
pd.set_option('display.max_colwidth'    , None)

###########################################################################

ts = str(datetime.datetime.now()).replace(' ','_').replace('.','').replace(':','').replace('-','')
conn_file = open('./src/adf_resource_manager/Main/credentials/snowflake.json')
_connection_parameters = json.load(conn_file)

class Snowpipe():

    '''
    This class enables communication with Snowflake using the Snowpark connector. Credentials need to be added to Snowflake.json in format seen below

    {
    "account"   : ""   ,
    "user"      : ""   ,
    "password"  : ""   ,
    "database"  : ""   ,
    "warehouse" : ""   ,
    "schema"    : ""   ,
    "role"      : ""
    }
    '''

    def __init__(self,connection_parameters):
        self.conntection_parameters = _connection_parameters

    @property
    def snowpark_session(self):
        self.session = Session.builder.configs(self.conntection_parameters).create()
        return self.session

    @property
    def validate_conn(self):
        self.current_db = self.snowpark_session.get_current_database()
        return self.current_db


    def execute_query(self,query):
        self.query = query
        self.query_results = self.snowpark_session.sql(f"""{self.query}""")
        return self.query_results

    def get_pdf(self,pdf_query)->pd.DataFrame:
        self.pdf_query = pdf_query
        self.pdf_results = pd.DataFrame(self.execute_query(self.pdf_query).collect())
        return self.pdf_results

    def merge_into(self,source_df:pd.DataFrame,target_table:str,source_key:str,target_key:str):

        '''
        Used to merge a dataframe into Snowflake table
        '''
        update_def = {"RESOURCE_NAME" : source_df["RESOURCE_NAME"], "LOCATION" : source_df["LOCATION"], "ENVIRONMENT" : source_df["ENVIRONMENT"], "TAGS" : source_df["TAGS"], "RESOURCE_CREATION_TS" : source_df["RESOURCE_CREATION_TS"], "TYPE" : source_df["TYPE"], "DESCRIPTION" : source_df["DESCRIPTION"], "RESOURCE_ID" : source_df["RESOURCE_ID"], "CLOUD_PROVIDER" : source_df["CLOUD_PROVIDER"], "ETL_MODIFIED_TS":source_df["ETL_MODIFIED_TS"]}
        insert_def = {"RESOURCE_NAME" : source_df["RESOURCE_NAME"], "LOCATION" : source_df["LOCATION"], "ENVIRONMENT" : source_df["ENVIRONMENT"], "TAGS" : source_df["TAGS"], "RESOURCE_CREATION_TS" : source_df["RESOURCE_CREATION_TS"], "TYPE" : source_df["TYPE"], "DESCRIPTION" : source_df["DESCRIPTION"], "RESOURCE_ID" : source_df["RESOURCE_ID"], "CLOUD_PROVIDER" : source_df["CLOUD_PROVIDER"], "ETL_MODIFIED_TS": source_df["ETL_MODIFIED_TS"]}

        self.target_table= self.snowpark_session.table(target_table)
        self.target_table.merge(source_df,(self.target_table[target_key] == source_df[source_key]), [when_matched().update(update_def), when_not_matched().insert(insert_def)])

    def to_Snowpark_DF(self, tmptable_name : str ,pdf:pd.DataFrame ):
        snowpark_df = self.snowpark_session.write_pandas(pdf,f'TMP_SNOWPARK_{tmptable_name}_{ts}',auto_create_table=True, table_type="transient")
        return snowpark_df

    @property
    def end_session(self):
        self.snowpark_session.close()
