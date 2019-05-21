PROMPT While executing the script command line make sure to create Database Links or edit the script
---In order to create Database Links, un-comment following lines
---Database Link create begin
--- ACCEPT strm_pwd_src PROMPT 'Enter Password of Streams Admin "streams" at Source : ' HIDE  
--- ACCEPT strm_pwd_dest PROMPT 'Enter Password of Streams Admin "streams" at Destination : ' HIDE  
---connect streams/&strm_pwd_src;
---DROP DATABASE LINK SARGPDE.GARBA.COM.AR;
---CREATE DATABASE LINK SARGPDE.GARBA.COM.AR connect to  streams identified by &strm_pwd_dest using '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=srvorad1.garba.com.ar)(PORT=1626)))(CONNECT_DATA=(SID=SARGPDE)(server=DEDICATED)))';
---COMMIT;
---connect streams/&strm_pwd_dest@'(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=srvorad1.garba.com.ar)(PORT=1626)))(CONNECT_DATA=(SID=SARGPDE)(server=DEDICATED)))';
;

---DROP DATABASE LINK EXTTRDE.GARBA.COM.AR;
---CREATE DATABASE LINK EXTTRDE.GARBA.COM.AR connect to streams identified by &strm_pwd_src using '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=srvorad2.garba.com.ar)(PORT=1627)))(CONNECT_DATA=(SID=EXTTRDE)(server=DEDICATED)))';
---COMMIT;
---Database Link create end
SET ECHO ON 
SET VERIFY OFF 
WHENEVER SQLERROR EXIT SQL.SQLCODE; 



-------------------------------------------------------------------
-- get TNSNAME and streams admin user details for both the databases
--------------------------------------------------------------------
PROMPT 
PROMPT 'Enter TNS Name of site 1 as parameter 1:'
DEFINE db1                 = &1
PROMPT 
PROMPT 'Enter streams admin username for site 1 as parameter 2:'
DEFINE strm_adm_db1        = &2
PROMPT 
PROMPT 'Enter streams admin password for site 1 as parameter 3:'
DEFINE strm_adm_pwd_db1    = &3
PROMPT 
PROMPT 'Enter TNS Name of site 2 as parameter 4:'
DEFINE db2                 = &4
PROMPT 
PROMPT 'Enter streams admin username for site 2 as parameter 5:'
DEFINE strm_adm_db2        = &5
PROMPT 
PROMPT 'Enter streams admin password for site 2 as parameter 6:'
DEFINE strm_adm_pwd_db2    = &6

-- connect as streams administrator to site 1 
PROMPT Connecting as streams administrator to site 1 
CONNECT &strm_adm_db1/&strm_adm_pwd_db1@&db1 
-- 
-- Add supplemental log group for table "DC_PRUEBA"."PEPE"
-- 
BEGIN 
  EXECUTE IMMEDIATE 'ALTER TABLE "DC_PRUEBA"."PEPE" ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY, FOREIGN KEY, UNIQUE INDEX) COLUMNS';
EXCEPTION WHEN OTHERS THEN
  IF sqlcode = -32588 THEN NULL;  -- Logging attribute exists
  ELSE RAISE;
  END IF;
END;
/
-- 
-- Add supplemental log group for table "DC_PRUEBA"."STREAMS_TABLE"
-- 
BEGIN 
  EXECUTE IMMEDIATE 'ALTER TABLE "DC_PRUEBA"."STREAMS_TABLE" ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY, FOREIGN KEY, UNIQUE INDEX) COLUMNS';
EXCEPTION WHEN OTHERS THEN
  IF sqlcode = -32588 THEN NULL;  -- Logging attribute exists
  ELSE RAISE;
  END IF;
END;
/
-- 
-- Add supplemental log group for table "DC_PRUEBA"."STRM_TBL2"
-- 
BEGIN 
  EXECUTE IMMEDIATE 'ALTER TABLE "DC_PRUEBA"."STRM_TBL2" ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY, FOREIGN KEY, UNIQUE INDEX) COLUMNS';
EXCEPTION WHEN OTHERS THEN
  IF sqlcode = -32588 THEN NULL;  -- Logging attribute exists
  ELSE RAISE;
  END IF;
END;
/
-- 
-- Set up queue "STREAMS"."EXTTRDE$CAPQ"
-- 
BEGIN 
  dbms_streams_adm.set_up_queue(
    queue_table => '"STREAMS"."EXTTRDE$CAPQT"', 
    storage_clause => NULL,
    queue_name => '"STREAMS"."EXTTRDE$CAPQ"', 
    queue_user => '"STREAMS"');
END;
/
-- 
-- PROPAGATE changes for schema DC_PRUEBA
-- 
DECLARE 
  version_num            NUMBER := 0; 
  release_num            NUMBER := 0; 
  pos                    NUMBER; 
  initpos                NUMBER; 
  q2q                    BOOLEAN; 
  stmt                   VARCHAR2(100); 
  ver                    VARCHAR2(30); 
  compat                 VARCHAR2(30);  

BEGIN 
  BEGIN 
    stmt := 'BEGIN dbms_utility.db_version@SARGPDE.GARBA.COM.AR(:ver, :compat); END;';
    EXECUTE IMMEDIATE stmt USING OUT ver, OUT compat; 
    -- Extract version number
    initpos := 1; 
    pos := INSTR(compat, '.', initpos, 1); 
    IF pos > 0 THEN 
      version_num := TO_NUMBER(SUBSTR(compat, initpos, pos - initpos));
      initpos := pos + 1;

      -- Extract release number
      pos := INSTR(compat, '.', initpos, 1);
      IF pos > 0 THEN 
        release_num := TO_NUMBER(SUBSTR(compat, initpos, 
                                   pos - initpos)); 
        initpos := pos + 1; 
      ELSE 
        release_num := TO_NUMBER(SUBSTR(compat, initpos)); 
      END IF; 
    ELSE 
      version_num := TO_NUMBER(SUBSTR(compat, initpos)); 
    END IF;

    -- use q2q propagation if compatibility >= 10.2 
    IF version_num > 10 OR 
       (version_num = 10 AND release_num >=2) THEN 
      q2q := TRUE; 
    ELSE 
      q2q := FALSE; 
    END IF; 

  EXCEPTION WHEN OTHERS THEN 
    q2q := FALSE; 
  END; 


  dbms_streams_adm.add_schema_propagation_rules(
    schema_name => '"DC_PRUEBA"', 
    streams_name => '', 
    source_queue_name => '"STREAMS"."EXTTRDE$CAPQ"', 
    destination_queue_name => '"STREAMS"."EXTTRDE$APPQ"@SARGPDE.GARBA.COM.AR', 
    include_dml => TRUE,
    include_ddl => FALSE,
    include_tagged_lcr => TRUE,
    source_database => 'EXTTRDE.GARBA.COM.AR', 
    inclusion_rule => TRUE, 
    and_condition => NULL, 
    queue_to_queue => q2q);
END;
/
-- 
-- Disable propagation. Enable after destination has been setup
-- 
DECLARE 
  q2q       VARCHAR2(10); 
  destn_q   VARCHAR2(65); 
BEGIN 
  SELECT queue_to_queue INTO q2q 
  FROM dba_propagation 
  WHERE source_queue_owner = 'STREAMS' AND 
        source_queue_name = 'EXTTRDE$CAPQ' AND 
        destination_queue_owner = 'STREAMS' AND 
        destination_queue_name = 'EXTTRDE$APPQ' AND 
        destination_dblink = 'SARGPDE.GARBA.COM.AR';

  IF q2q = 'TRUE' THEN 
    destn_q := '"STREAMS"."EXTTRDE$APPQ"';
  ELSE 
    destn_q := NULL; 
  END IF; 

  dbms_aqadm.disable_propagation_schedule(
    queue_name => '"STREAMS"."EXTTRDE$CAPQ"', 
    destination => 'SARGPDE.GARBA.COM.AR', 
    destination_queue => destn_q);
EXCEPTION WHEN OTHERS THEN
  IF sqlcode = -24065 THEN NULL;  -- propagation already disabled
  ELSE RAISE;
  END IF;
END;
/
-- 
-- CAPTURE changes for schema DC_PRUEBA
-- 
DECLARE 
  compat         VARCHAR2(512); 
  initpos        NUMBER; 
  pos            NUMBER; 
  version_num    NUMBER; 
  release_num    NUMBER; 
  compat_func    VARCHAR2(65); 
  get_compatible VARCHAR2(4000); 
BEGIN 
  SELECT value INTO compat 
  FROM v$parameter 
  WHERE name = 'compatible'; 

  -- Extract version number 
  initpos := 1; 
  pos := INSTR(compat, '.', initpos, 1); 
  IF pos > 0 THEN 
    version_num := TO_NUMBER(SUBSTR(compat, initpos, pos - initpos)); 
    initpos := pos + 1; 

    -- Extract release number 
    pos := INSTR(compat, '.', initpos, 1); 
    IF pos > 0 THEN 
      release_num := TO_NUMBER(SUBSTR(compat, initpos, pos - initpos));
      initpos := pos + 1; 
    ELSE 
      release_num := TO_NUMBER(SUBSTR(compat, initpos)); 
    END IF; 
  END IF; 

  IF version_num < 10 THEN 
    compat_func := 'dbms_streams.compatible_9_2';
  ELSIF version_num = 10 THEN 
    IF release_num < 2 THEN 
      compat_func := 'dbms_streams.compatible_10_1';
    ELSE 
      compat_func := 'dbms_streams.compatible_10_2';
    END IF; 
  ELSE 
    compat_func := 'dbms_streams.compatible_10_2';
  END IF; 

  get_compatible := ':lcr.get_compatible() <= '||compat_func;


  dbms_streams_adm.add_schema_rules(
    schema_name => '"DC_PRUEBA"', 
    streams_type => 'CAPTURE', 
    streams_name => '"EXTTRDE$CAP"', 
    queue_name => '"STREAMS"."EXTTRDE$CAPQ"', 
    include_dml => TRUE,
    include_ddl => FALSE,
    include_tagged_lcr => TRUE,
    source_database => 'EXTTRDE.GARBA.COM.AR', 
    inclusion_rule => TRUE,
    and_condition => get_compatible);
END;
/
-- 
-- Datapump SCHEMA MODE EXPORT
-- 
DECLARE
  h1                NUMBER;       -- data pump job handle
  schema_expr_list  VARCHAR2(32767); -- for metadata_filter
  cnt               NUMBER; -- temp variable
  object_owner      dbms_utility.uncl_array; -- obj owners
  job_state         VARCHAR2(30); -- job state
  status            ku$_Status; -- data pump status
  job_not_exist     exception;
  pragma            exception_init(job_not_exist, -31626);
BEGIN

  object_owner(1) := 'DC_PRUEBA';
  FOR idx IN 1..1 LOOP
    -- schema does not exist locally, need instantiation
    IF schema_expr_list IS NULL THEN
      schema_expr_list := '(';
    ELSE
      schema_expr_list := schema_expr_list ||',';
    END IF;
    schema_expr_list := schema_expr_list||''''||object_owner(idx)||'''';
  END LOOP;
  IF schema_expr_list IS NOT NULL THEN
    schema_expr_list := schema_expr_list || ')';
  ELSE
    COMMIT;
    RETURN;
  END IF;

  h1 := dbms_datapump.open(operation=>'EXPORT',job_mode=>'SCHEMA',
    remote_link=>'',
    job_name=>NULL, version=>'COMPATIBLE');

  dbms_datapump.metadata_filter(
    handle=>h1,
    name=>'SCHEMA_EXPR',
    value=>'IN'||schema_expr_list);

  dbms_datapump.add_file(
    handle=>h1,
    filename=>'streams_setup_2011_4_19_11_35_2_241.dmp',
    directory=>'ORA_EM_STRM_DPUMP_10205',
    filetype=>dbms_datapump.ku$_file_type_dump_file);
  dbms_datapump.add_file(
    handle=>h1,
    filename=>'streams_setup_2011_4_19_11_35_2_241.log',
    directory=>'ORA_EM_STRM_DPUMP_10205',
    filetype=>dbms_datapump.ku$_file_type_log_file);

  dbms_datapump.start_job(h1);

  job_state := 'UNDEFINED';
  BEGIN
    WHILE (job_state != 'COMPLETED') AND (job_state != 'STOPPED') LOOP
      status := dbms_datapump.get_status(
        handle => h1,
        mask => dbms_datapump.ku$_status_job_error +
                dbms_datapump.ku$_status_job_status +
                dbms_datapump.ku$_status_wip,
        timeout => -1);
      job_state := status.job_status.state;
      dbms_lock.sleep(10);
    END LOOP;
  EXCEPTION WHEN job_not_exist THEN
    dbms_output.put_line('job finished');
  END;

  -- Transfer dump file to the destination directory
  dbms_file_transfer.put_file(
    source_directory_object => '"ORA_EM_STRM_DPUMP_10205"', 
    source_file_name => 'streams_setup_2011_4_19_11_35_2_241.dmp', 
    destination_directory_object => '"ORA_EM_STRM_DPUMP_10205"', 
    destination_file_name => 'streams_setup_2011_4_19_11_35_2_241.dmp', 
    destination_database => 'SARGPDE.GARBA.COM.AR');

  COMMIT;
EXCEPTION WHEN OTHERS THEN
  ROLLBACK;
  RAISE;
END;
/
-- 
-- Start capture process EXTTRDE$CAP
-- 
BEGIN 
  dbms_capture_adm.start_capture(
    capture_name => '"EXTTRDE$CAP"');
EXCEPTION WHEN OTHERS THEN
  IF sqlcode = -26666 THEN NULL;  -- CAPTURE process already running
  ELSE RAISE;
  END IF;
END;
/
-- connect as streams administrator to site 2 
PROMPT Connecting as streams administrator to site 2 
CONNECT &strm_adm_db2/&strm_adm_pwd_db2@&db2 
-- 
-- Datapump SCHEMA MODE IMPORT
-- 
DECLARE
  h1                NUMBER;       -- data pump job handle
  schema_expr_list  VARCHAR2(32767); -- for metadata_filter
  cnt               NUMBER; -- temp variable
  object_owner      dbms_utility.uncl_array; -- obj owners
  job_state         VARCHAR2(30); -- job state
  status            ku$_Status; -- data pump status
  job_not_exist     exception;
  pragma            exception_init(job_not_exist, -31626);
BEGIN

  object_owner(1) := 'DC_PRUEBA';
  FOR idx IN 1..1 LOOP
    -- schema does not exist locally, need instantiation
    IF schema_expr_list IS NULL THEN
      schema_expr_list := '(';
    ELSE
      schema_expr_list := schema_expr_list ||',';
    END IF;
    schema_expr_list := schema_expr_list||''''||object_owner(idx)||'''';
  END LOOP;
  IF schema_expr_list IS NOT NULL THEN
    schema_expr_list := schema_expr_list || ')';
  ELSE
    COMMIT;
    RETURN;
  END IF;

  h1 := dbms_datapump.open(operation=>'IMPORT',job_mode=>'SCHEMA',
    remote_link=>'',
    job_name=>NULL, version=>'COMPATIBLE');



  dbms_datapump.add_file(
    handle=>h1,
    filename=>'streams_setup_2011_4_19_11_35_2_241.dmp',
    directory=>'ORA_EM_STRM_DPUMP_10205',
    filetype=>dbms_datapump.ku$_file_type_dump_file);
  dbms_datapump.add_file(
    handle=>h1,
    filename=>'streams_setup_2011_4_19_11_35_2_241.log',
    directory=>'ORA_EM_STRM_DPUMP_10205',
    filetype=>dbms_datapump.ku$_file_type_log_file);

  dbms_datapump.start_job(h1);

  job_state := 'UNDEFINED';
  BEGIN
    WHILE (job_state != 'COMPLETED') AND (job_state != 'STOPPED') LOOP
      status := dbms_datapump.get_status(
        handle => h1,
        mask => dbms_datapump.ku$_status_job_error +
                dbms_datapump.ku$_status_job_status +
                dbms_datapump.ku$_status_wip,
        timeout => -1);
      job_state := status.job_status.state;
      dbms_lock.sleep(10);
    END LOOP;
  EXCEPTION WHEN job_not_exist THEN
    dbms_output.put_line('job finished');
  END;
  COMMIT;
EXCEPTION WHEN OTHERS THEN
  ROLLBACK;
  RAISE;
END;
/
-- 
-- Set up queue "STREAMS"."EXTTRDE$APPQ"
-- 
BEGIN 
  dbms_streams_adm.set_up_queue(
    queue_table => '"STREAMS"."EXTTRDE$APPQT"', 
    storage_clause => NULL,
    queue_name => '"STREAMS"."EXTTRDE$APPQ"', 
    queue_user => '"STREAMS"');
END;
/
-- 
-- APPLY changes for schema DC_PRUEBA
-- 
DECLARE 
  compat         VARCHAR2(512); 
  initpos        NUMBER; 
  pos            NUMBER; 
  version_num    NUMBER; 
  release_num    NUMBER; 
  compat_func    VARCHAR2(65); 
  get_compatible VARCHAR2(4000); 
BEGIN 
  SELECT value INTO compat 
  FROM v$parameter 
  WHERE name = 'compatible'; 

  -- Extract version number 
  initpos := 1; 
  pos := INSTR(compat, '.', initpos, 1); 
  IF pos > 0 THEN 
    version_num := TO_NUMBER(SUBSTR(compat, initpos, pos - initpos)); 
    initpos := pos + 1; 

    -- Extract release number 
    pos := INSTR(compat, '.', initpos, 1); 
    IF pos > 0 THEN 
      release_num := TO_NUMBER(SUBSTR(compat, initpos, pos - initpos));
      initpos := pos + 1; 
    ELSE 
      release_num := TO_NUMBER(SUBSTR(compat, initpos)); 
    END IF; 
  END IF; 

  IF version_num < 10 THEN 
    compat_func := 'dbms_streams.compatible_9_2';
  ELSIF version_num = 10 THEN 
    IF release_num < 2 THEN 
      compat_func := 'dbms_streams.compatible_10_1';
    ELSE 
      compat_func := 'dbms_streams.compatible_10_2';
    END IF; 
  ELSE 
    compat_func := 'dbms_streams.compatible_10_2';
  END IF; 

  get_compatible := ':lcr.get_compatible() <= '||compat_func;


  dbms_streams_adm.add_schema_rules(
    schema_name => '"DC_PRUEBA"', 
    streams_type => 'APPLY', 
    streams_name => '', 
    queue_name => '"STREAMS"."EXTTRDE$APPQ"', 
    include_dml => TRUE,
    include_ddl => FALSE,
    include_tagged_lcr => TRUE,
    source_database => 'EXTTRDE.GARBA.COM.AR', 
    inclusion_rule => TRUE, 
    and_condition => get_compatible);
END;
/
-- 
-- Get tag value to be used for Apply 
-- 
DECLARE 
  found            BINARY_INTEGER := 0; 
  tag_num          NUMBER; 
  apply_nm         VARCHAR2(30); 
  apply_nm_dqt     VARCHAR2(32); 
BEGIN 
  SELECT apply_name INTO apply_nm 
  FROM dba_apply_progress 
  WHERE source_database = 'EXTTRDE.GARBA.COM.AR';

  apply_nm_dqt := '"' || apply_nm || '"';
  -- Use the apply object id as the tag 
  SELECT o.object_id INTO tag_num 
  FROM dba_objects o 
  WHERE o.object_name= apply_nm AND 
        o.object_type='APPLY';
  LOOP 
    BEGIN 
      found := 0; 
      SELECT 1 INTO found FROM dba_apply 
      WHERE apply_name != apply_nm AND 
            apply_tag = hextoraw(tag_num); 
    EXCEPTION WHEN no_data_found THEN 
      EXIT; 
    END; 
    EXIT WHEN (found = 0); 
    tag_num := tag_num + 1; 
  END LOOP; 
  -- alter apply 
  dbms_apply_adm.alter_apply( 
    apply_name => apply_nm_dqt, 
    apply_tag => hextoraw(tag_num)); 
END;
/
-- 
-- Start apply process applying changes from EXTTRDE.GARBA.COM.AR
-- 
DECLARE 
  apply_nm VARCHAR2(32); 
  apply_nm_dqt VARCHAR2(32); 
BEGIN 
  SELECT apply_name INTO apply_nm 
  FROM dba_apply_progress 
  WHERE source_database = 'EXTTRDE.GARBA.COM.AR';

  apply_nm_dqt := '"' || apply_nm || '"';
  dbms_apply_adm.start_apply(
    apply_name => apply_nm_dqt);
EXCEPTION WHEN OTHERS THEN
  IF sqlcode = -26666 THEN NULL;  -- APPLY process already running
  ELSE RAISE;
  END IF;
END;
/
-- connect as streams administrator to site 1 
PROMPT Connecting as streams administrator to site 1 
CONNECT &strm_adm_db1/&strm_adm_pwd_db1@&db1 
-- 
-- Enable propagation schedule for "STREAMS"."EXTTRDE$CAPQ"
-- to SARGPDE.GARBA.COM.AR
-- 
DECLARE 
  q2q       VARCHAR2(10); 
  destn_q   VARCHAR2(65); 
BEGIN 
  SELECT queue_to_queue INTO q2q 
  FROM dba_propagation 
  WHERE source_queue_owner = 'STREAMS' AND 
        source_queue_name = 'EXTTRDE$CAPQ' AND 
        destination_queue_owner = 'STREAMS' AND 
        destination_queue_name = 'EXTTRDE$APPQ' AND 
        destination_dblink = 'SARGPDE.GARBA.COM.AR';

  IF q2q = 'TRUE' THEN 
    destn_q := '"STREAMS"."EXTTRDE$APPQ"';
  ELSE 
    destn_q := NULL; 
  END IF; 

  dbms_aqadm.enable_propagation_schedule(
    queue_name => '"STREAMS"."EXTTRDE$CAPQ"', 
    destination => 'SARGPDE.GARBA.COM.AR', 
    destination_queue => destn_q);
EXCEPTION WHEN OTHERS THEN
  IF sqlcode = -24064 THEN NULL; -- propagation already enabled
  ELSE RAISE;
  END IF;
END;
/

connect &strm_adm_db1/&strm_adm_pwd_db1@&db1;
DROP DIRECTORY ORA_EM_STRM_DPUMP_10205;
COMMIT;
connect &strm_adm_db2/&strm_adm_pwd_db2@&db2;

DROP DIRECTORY ORA_EM_STRM_DPUMP_10205;
COMMIT;
