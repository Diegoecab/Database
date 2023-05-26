--explain_plan
set pages 1000
set verify off
set lines 132
set feedback off
set trims on

/*
Starts: is displayed by ‘basic +rowstats’, ‘basic +allstats’
A-Rows: is displayed by ‘basic +rowstats’, ‘basic +allstats’
A-Time: is displayed by ‘typical +rowstats’, ‘basic +allstats’
Buffers, Reads, Writes: is displayed by ‘basic +buffstats’, ‘basic +iostats’, ‘basic +allstats’
OMem, 1Mem, Used-Mem, O/1/M, Used-Mem: is displayed by ‘basic +memstats’, ‘basic +allstats’
Max-Tmp,Used-Tmp is displayed by ‘basic +memstats’, ‘typical +allstats’
*/

accept SQL prompt 'Ingrese SQL: '

explain plan for &SQL
/

--SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

SELECT PLAN_TABLE_OUTPUT 
  FROM TABLE(DBMS_XPLAN.DISPLAY(null, null,'ALL'));