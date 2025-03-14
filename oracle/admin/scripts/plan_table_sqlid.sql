--SET ECHO OFF FEED OFF VER OFF SHOW OFF HEA OFF LIN 2000 NEWP NONE PAGES 0 LONG 2000000 LONGC 2000 SQLC MIX TAB ON TRIMS ON TI OFF TIMI OFF ARRAY 100 NUMF "" SQLP
SET FEED OFF VER OFF SHOW OFF 
set pages 10000
set lines 400
col plan_table_output for a300
COL inst_child FOR A21;
BREAK ON inst_child SKIP 2;


prompt ******************************************************************************************************************
prompt
prompt Execution Plans in Memory:
prompt
prompt ******************************************************************************************************************

--PRO Captured while still in memory. Metrics below are for the last execution of each child cursor.
--PRO If STATISTICS_LEVEL was set to ALL at the time of the hard-parse then A-Rows column is populated.
--PRO
SELECT RPAD('Inst: '||v.inst_id, 9)||' '||RPAD('Child: '||v.child_number, 11) inst_child, t.plan_table_output
 FROM gv$sql v,
 TABLE(DBMS_XPLAN.DISPLAY('gv$sql_plan_statistics_all', NULL, 'ADVANCED ALLSTATS LAST', 'inst_id = '||v.inst_id||' AND sql_id = '''||v.sql_id||''' AND child_number = '||v.child_number)) t
 WHERE v.sql_id = '&1'
 AND v.loaded_versions > 0;
--SET ECHO OFF FEED 6 VER ON SHOW OFF HEA ON LIN 80 NEWP 1 PAGES 14 LONG 80 LONGC 80 SQLC MIX TAB ON TRIMS OFF TI OFF TIMI OFF
