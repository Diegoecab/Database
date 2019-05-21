--explain_plan
set pages 1000
set verify off
set lines 132
set feedback off
set trims on

accept SQL prompt 'Ingrese SQL: '

explain plan for &SQL
/

--SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

SELECT PLAN_TABLE_OUTPUT 
  FROM TABLE(DBMS_XPLAN.DISPLAY(null, null,'ALL'));