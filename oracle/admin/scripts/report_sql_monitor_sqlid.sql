--report_sql_monitor_sqlid sqlid phv type
--@report_sql_monitor_sqlid 4g47brj07vttz 455302343 text
SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 1000
SET PAGESIZE 0
SET TRIM ON
SET TRIMSPOOL ON
SET ECHO OFF
SET FEEDBACK OFF
SET VERIFY OFF
set head off

select DBMS_SQL_MONITOR.REPORT_SQL_MONITOR
        (sql_id       =>'&1',
		sql_plan_hash_value =>'&2',
         report_level =>'all', 
         type         =>'&3') report
from dual;