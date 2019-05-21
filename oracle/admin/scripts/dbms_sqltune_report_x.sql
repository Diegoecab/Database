--dbms_sqltune_report_x.sql
accept TTASK prompt 'Ingrese Tuning Task (Para ver un listado ejecutar dba_advisor_tasks): '
SET LONG 1000000
SET LONGCHUNKSIZE 1000
SET LINESIZE 100
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK( '&TTASK')
  FROM DUAL;