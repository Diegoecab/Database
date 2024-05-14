===================
Generate SQL file
===================
DECLARE
  v_hdnl NUMBER;
BEGIN
  v_hdnl := DBMS_DATAPUMP.OPEN(
    operation => 'SQL_FILE',
    job_mode => 'TABLE',
    job_name => null
  );

  DBMS_DATAPUMP.ADD_FILE(
    handle => v_hdnl,
    filename => 'export_ADMIN_Schema.dmp',
    directory => 'DATA_PUMP_DIR',
    filetype => dbms_datapump.ku$_file_type_dump_file
  );
  DBMS_DATAPUMP.ADD_FILE(
    handle => v_hdnl,
    filename => 'sample_sqlfile_api_metadataonly.sql',
    directory => 'DATA_PUMP_DIR',
    filetype => dbms_datapump.ku$_file_type_sql_file
  );
  DBMS_DATAPUMP.ADD_FILE(
    handle => v_hdnl,
    filename => 'export_ADMIN_Schema_sqlfile.log',
    directory => 'DATA_PUMP_DIR',
    filetype => dbms_datapump.ku$_file_type_log_file
  );
  DBMS_DATAPUMP.START_JOB(v_hdnl);
END;
/

Importing the table TEST in parallel mode, with the "TRUNCATE" option

	DECLARE
	  v_hdnl NUMBER;
	BEGIN
	  v_hdnl := DBMS_DATAPUMP.OPEN(
		operation => 'IMPORT',
		job_mode  => 'TABLE',
		job_name  => null);
	  DBMS_DATAPUMP.SET_PARALLEL(handle => v_hdnl, degree => 4);
	  DBMS_DATAPUMP.ADD_FILE(
		handle    => v_hdnl,
		filename  => 'oraadminexp_%u.dmp',
		directory => 'DATA_PUMP_DIR',
		filetype  => dbms_datapump.ku$_file_type_dump_file);
	  DBMS_DATAPUMP.ADD_FILE(
		handle    => v_hdnl,
		filename  => 'oraadminimptable2.log',
		directory => 'DATA_PUMP_DIR',
		filetype  => dbms_datapump.ku$_file_type_log_file);
	  DBMS_DATAPUMP.METADATA_FILTER(v_hdnl,'NAME_EXPR','= ''TEST''','TABLE');
	  DBMS_DATAPUMP.SET_PARAMETER (v_hdnl, 'TABLE_EXISTS_ACTION', 'TRUNCATE');
	  DBMS_DATAPUMP.START_JOB(v_hdnl);
	END;
	/



1) Exporting the schema "ORAADMIN" in parallel degree 4

	DECLARE
	hdnl NUMBER;
	BEGIN
	hdnl := DBMS_DATAPUMP.OPEN( operation => 'EXPORT', job_mode => 'SCHEMA', job_name=>null);
	DBMS_DATAPUMP.SET_PARALLEL(handle => hdnl, degree => 4);
	DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'oraadminexp_%u.dmp', directory => 'DATA_PUMP_DIR', filetype => dbms_datapump.ku$_file_type_dump_file);
	DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'oraadminexp.log', directory => 'DATA_PUMP_DIR', filetype => dbms_datapump.ku$_file_type_log_file);
	DBMS_DATAPUMP.METADATA_FILTER(hdnl,'SCHEMA_EXPR',value  => '= ''ORAADMIN''');
	DBMS_DATAPUMP.START_JOB(hdnl);
	END;
	/



Index:
----------
DECLARE
wcuserimp NUMBER;
BEGIN

wcuserimp := DBMS_DATAPUMP.OPEN(
operation => 'IMPORT',
job_mode => 'SCHEMA',
job_name => null);

DBMS_DATAPUMP.ADD_FILE(wcuserimp,'EXP_PROD_WCUSER_03152024_01.dmp','DATA_PUMP_DIR_EFS_PROD',dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE(wcuserimp,'EXP_PROD_WCUSER_03152024_02.dmp','DATA_PUMP_DIR_EFS_PROD',dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE(wcuserimp,'EXP_PROD_WCUSER_03152024_03.dmp','DATA_PUMP_DIR_EFS_PROD',dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE(wcuserimp,'EXP_PROD_WCUSER_03152024_04.dmp','DATA_PUMP_DIR_EFS_PROD',dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE(wcuserimp,'EXP_PROD_WCUSER_03152024_05.dmp','DATA_PUMP_DIR_EFS_PROD',dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE(wcuserimp,'EXP_PROD_WCUSER_03152024_06.dmp','DATA_PUMP_DIR_EFS_PROD',dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE(wcuserimp,'EXP_PROD_WCUSER_03152024_15.dmp','DATA_PUMP_DIR_EFS_PROD',dbms_datapump.ku$_file_type_dump_file);

DBMS_DATAPUMP.ADD_FILE(
handle => wcuserimp,
filename => 'IMP_PROD_WCUSER_03162024_INDEX.log',
directory => 'DATA_PUMP_DIR_EFS_PROD',
filetype => dbms_datapump.ku$_file_type_log_file);

DBMS_DATAPUMP.SET_PARALLEL(handle=> wcuserimp,degree=>16);

DBMS_DATAPUMP.METADATA_FILTER(wcuserimp,'INCLUDE_PATH_EXPR','IN (''INDEX'')');

DBMS_DATAPUMP.START_JOB(wcuserimp);
END;
/

References:

[1] https://docs.oracle.com/en/database/oracle/oracle-database/19/arpls/DBMS_DATAPUMP.html#GUID-62324358-2F26-4A94-B69F-1075D53FA96D
