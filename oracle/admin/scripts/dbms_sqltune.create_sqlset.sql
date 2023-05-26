--dbms_sqltune.create_sqlset.sql

set verify off
set long 100000
set serveroutput on


ttitle off

accept Username prompt 'SQLSet Owner: '
accept SqlSNAME prompt 'SQLSet Name: '
accept descr prompt 'Description: '


BEGIN 
dbms_sqltune.create_sqlset(sqlset_name => '&SqlSNAME', sqlset_owner =>'&Username', description => '&descr'); 
END;
/

col description for a30

select * from DBA_SQLSET where name='&SqlSNAME'
/


col begin_interval_time for a25
col end_interval_time for a25
set pages 1000
set lines 300

accept days prompt 'Days: '

ttitle 'Registros de snapshots AWR'
select snap_id,begin_interval_time,end_interval_time,error_count 
from dba_hist_snapshot
where begin_interval_time > sysdate - &days
order by snap_id
/


ttitle off


accept bsnap prompt 'Begin Snap: '
accept endsnap prompt 'End Snap: '

accept pschema prompt 'Parsing Schema Name (Eg != SYSTEM) : '
accept psqlid prompt 'SQL id (Eg IN ('sdfse1drg','sadsefac')): '
accept petime prompt 'Elapsed Time (sec) (Eg >= 100) : '
accept psql prompt 'SQL Text (Eg like 'Select * from dual&') : '


DECLARE

taskname varchar2(100);

BEGIN
   DBMS_SCHEDULER.CREATE_JOB (
      job_name     => 'JOB_&SqlSNAME',
      job_type     => 'PLSQL_BLOCK',
      job_action   => 'DECLARE sqlset_cur 
dbms_sqltune.sqlset_cursor;
bf VARCHAR2(78); 
BEGIN
bf := ''UPPER(PARSING_SCHEMA_NAME) = ''''&pschema'''' '';
OPEN sqlset_cur FOR 
SELECT VALUE(P) FROM TABLE( dbms_sqltune.select_workload_repository( ''&bsnap'', ''&endsnap'', bf, NULL, NULL, NULL, NULL, 1, NULL, NULL)) P; 
dbms_sqltune.load_sqlset( sqlset_name=>''&SqlSNAME'', populate_cursor=>sqlset_cur, load_option => ''MERGE'', 
update_option => ''ACCUMULATE'', sqlset_owner=>''&Username''); END;',
      enabled      => TRUE
   );
 taskname:= dbms_output.put_line(taskname);
END;
/


clear breaks buff col comp sql timing