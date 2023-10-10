set trimspool on
set trim on
set pagesize 0
set linesize 32767
set long 1000000
set longchunksize 1000000
spool &spool
SELECT dbms_sql_monitor.report_sql_monitor(type=>'ACTIVE')
FROM dual;
spool off