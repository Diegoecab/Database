alter session set sql_trace=true;
alter session set events '39001 trace name ERRORSTACK level 12';

/*This PL SQL block returns the error *
ERROR at line 1:
ORA-39001: invalid argument value
ORA-06512: at "SYS.DBMS_SYS_ERROR", line 79
ORA-06512: at "SYS.DBMS_DATAPUMP", line 4929
ORA-06512: at "SYS.DBMS_DATAPUMP", line 5180
ORA-06512: at line 8
*/

DECLARE 
v_hdnl NUMBER; 
BEGIN 
v_hdnl := DBMS_DATAPUMP.OPEN( 
operation => 'IMPORT', 
job_mode => 'SCHEMA', 
job_name => null); 
 DBMS_DATAPUMP.ADD_FILE( 
handle=> v_hdnl, 
filename => 'ORAADMIN2.dmp', 
directory => 'DATA_PUMP_DIR', 
filetype => dbms_datapump.ku$_file_type_dump_file); 
DBMS_DATAPUMP.ADD_FILE( 
handle=> v_hdnl, 
filename => 'USTGITMOD_001.log', 
directory => 'DATA_PUMP_DIR', 
filetype => dbms_datapump.ku$_file_type_log_file); 
DBMS_DATAPUMP.METADATA_FILTER(v_hdnl,'SCHEMA_EXPR','IN (''ORAADMIN'')'); 
DBMS_DATAPUMP.START_JOB(v_hdnl); 
END; 
/



alter session set sql_trace=false;
alter session set events '39001 trace name errorstack off';

