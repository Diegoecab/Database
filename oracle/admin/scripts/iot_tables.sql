SELECT owner,table_name, iot_type, iot_name,tablespace_name FROM DBA_TABLES
     WHERE iot_type IS NOT NULL;