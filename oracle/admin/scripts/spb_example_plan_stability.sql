CREATE TABLE test2 (id number, name varchar2(1000));

set timing on
insert into test2 select level id, 'nom_'||level nombre
FROM dual
CONNECT BY level <= 300000;

commit;

create index idx1 on test2 (id);

explain plan for
select sum(id) from test2;
SELECT PLAN_TABLE_OUTPUT 
  FROM TABLE(DBMS_XPLAN.DISPLAY(null, null,'ALL'));
  
SELECT *
    FROM table(DBMS_XPLAN.DISPLAY_CURSOR(FORMAT=>'LAST'));
  
  PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 325870156

------------------------------------------------------------------------------
| Id  | Operation             | Name | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT      |      |     1 |    13 |   184   (1)| 00:00:01 |
|   1 |  SORT AGGREGATE       |      |     1 |    13 |            |          |
|   2 |   INDEX FAST FULL SCAN| IDX1 |   267K|  3400K|   184   (1)| 00:00:01 |
------------------------------------------------------------------------------


select sql_id, address from v$sql_plan where plan_hash_value=325870156;
SQL_ID        ADDRESS
------------- ----------------
5ka8tjttn64dq 000000006F673AB0
5ka8tjttn64dq 000000006F673AB0
5ka8tjttn64dq 000000006F673AB0






explain plan for 
select /*+ FULL(test2) */ sum(id) from test2;

SELECT PLAN_TABLE_OUTPUT 
  FROM TABLE(DBMS_XPLAN.DISPLAY(null, null,'ALL'));

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 634289536

----------------------------------------------------------------------------
| Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |       |     1 |    13 |   234   (1)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |    13 |            |          |
|   2 |   TABLE ACCESS FULL| TEST2 |   267K|  3400K|   234   (1)| 00:00:01 |
----------------------------------------------



select sql_id, address from v$sql_plan where plan_hash_value=634289536;


SQL_ID        ADDRESS
------------- ----------------
gh2zwagbw7dtf 000000006D873130
gh2zwagbw7dtf 000000006D873130
gh2zwagbw7dtf 000000006D873130


(spb.set_my_plan.sql)
set serveroutput on
--applicationsqlid, hintedsqlid, hinted sql plan hash value
exec set_my_plan('5ka8tjttn64dq','gh2zwagbw7dtf',634289536)

(Para hacerlo manualmente:)


declare
num   pls_integer;
for_sqlid varchar2(100) := '4hk462ng4rvm4';

begin
num:= DBMS_SPM.load_plans_from_cursor_cache(sql_id=>'4hk462ng4rvm4', ENABLED=>'NO');

dbms_output.put_line('Created '||num||' disabled SPBs for SQLID '||for_sqlid);

num:= DBMS_SPM.load_plans_from_cursor_cache(sql_id=>'4hk462ng4rvm4', plan_hash_value=> 634289536, sql_handle=>'new_sql_handle' ENABLED=>'YES');

end;
/



https://blogs.oracle.com/optimizer/using-sql-plan-management-to-control-sql-execution-plans




set autotrace traceonly
select sum(id) from test2;




SQL> select sum(id) from test2;

Elapsed: 00:00:00.02

Execution Plan
----------------------------------------------------------
Plan hash value: 634289536

----------------------------------------------------------------------------
| Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |       |     1 |    13 |   234   (1)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |    13 |            |          |
|   2 |   TABLE ACCESS FULL| TEST2 |   267K|  3400K|   234   (1)| 00:00:01 |
----------------------------------------------------------------------------

Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
   - SQL plan baseline "SQL_PLAN_99z8t5aqrwyy8106fc7d8" used for this statement







Manually Evolving SQL Plan Baselines


SQL> l
  1  SELECT created, sql_handle, plan_name, enabled, accepted
  2  FROM   dba_sql_plan_baselines
  3* WHERE  sql_text LIKE '%&1%'
SQL> /
old   3: WHERE  sql_text LIKE '%&1%'
new   3: WHERE  sql_text LIKE '%%%'

CREATED                                                                     SQL_HANDLE           PLAN_NAME                      ENA ACC
--------------------------------------------------------------------------- -------------------- ------------------------------ --- ---
14-APR-20 05.26.44.000000 AM                                                SQL_94fd192aad7e7bc8 SQL_PLAN_99z8t5aqrwyy809678c0f NO  YES
14-APR-20 05.26.44.000000 AM                                                SQL_94fd192aad7e7bc8 SQL_PLAN_99z8t5aqrwyy8106fc7d8 YES YES

Elapsed: 00:00:00.01
SQL>




/* Setting Enabled=YES for SYS_SQL_PLAN_7118fc3f642e4a26 */
declare
myplan pls_integer;
begin
myplan:=DBMS_SPM.ALTER_SQL_PLAN_BASELINE (sql_handle => 'SQL_c8bb3e7fbd61e830',plan_name  => 'SQL_PLAN_99z8t5aqrwyy809678c0f',attribute_name => 'ENABLED',   attribute_value => 'FALSE');
end;
/



SET SERVEROUTPUT ON
DECLARE
  l_return VARCHAR2(32767);
BEGIN
  l_return := DBMS_SPM.create_evolve_task(sql_handle => 'SQL_c8bb3e7fbd61e830');
  DBMS_OUTPUT.put_line('Task Name: ' || l_return);
END;
/





Task Name: TASK_110056


SET SERVEROUTPUT ON
DECLARE
  l_return VARCHAR2(32767);
BEGIN
  l_return := DBMS_SPM.execute_evolve_task(task_name => 'TASK_110056');
  DBMS_OUTPUT.put_line('Execution Name: ' || l_return);
END;
/

Execution Name: EXEC_169


SET LONG 1000000 PAGESIZE 1000 LONGCHUNKSIZE 100 LINESIZE 100

SELECT DBMS_SPM.report_evolve_task(task_name => 'TASK_158', execution_name => 'EXEC_169') AS output
FROM   dual;


drop index idx1;

set autotrace on
select sum(id) from test2;

Execution Plan
----------------------------------------------------------
Plan hash value: 634289536

----------------------------------------------------------------------------
| Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |       |     1 |     5 |   234   (1)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |     5 |            |          |
|   2 |   TABLE ACCESS FULL| TEST2 |   300K|  1464K|   234   (1)| 00:00:01 |
----------------------------------------------------------------------------

Note
-----
   - SQL plan baseline "SQL_PLAN_99z8t5aqrwyy8106fc7d8" used for this statement
@dba_sql_plan_baselines %



CREATED                                                                     SQL_HANDLE           PLAN_NAME                      ENA ACC FIX ORIGIN
--------------------------------------------------------------------------- -------------------- ------------------------------ --- --- --- -----------------------------
14-APR-20 05.26.44.000000 AM                                                SQL_94fd192aad7e7bc8 SQL_PLAN_99z8t5aqrwyy809678c0f YES YES NO  MANUAL-LOAD-FROM-CURSOR-CACHE
14-APR-20 05.26.44.000000 AM                                                SQL_94fd192aad7e7bc8 SQL_PLAN_99z8t5aqrwyy8106fc7d8 YES YES NO  MANUAL-LOAD-FROM-CURSOR-CACHE

Elapsed: 00:00:00.01



declare
myplan pls_integer;
begin
myplan:=DBMS_SPM.DROP_SQL_PLAN_BASELINE (sql_handle => 'SQL_c8bb3e7fbd61e830',plan_name  => 'SQL_PLAN_99z8t5aqrwyy809678c0f');
end;
/




create index idx1 on test2 (id);
exec dbms_stats.gather_table_stats('SYS','TEST2', CASCADE=>TRUE);



SQL> select sum(id) from test2;

   SUM(ID)
----------
4.5000E+10

Elapsed: 00:00:00.05

Execution Plan
----------------------------------------------------------
Plan hash value: 634289536

----------------------------------------------------------------------------
| Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |       |     1 |     5 |   234   (1)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |     5 |            |          |
|   2 |   TABLE ACCESS FULL| TEST2 |   300K|  1464K|   234   (1)| 00:00:01 |
----------------------------------------------------------------------------

Note
-----
   - SQL plan baseline "SQL_PLAN_99z8t5aqrwyy8106fc7d8" used for this statement
   
   
   
  


SQL> @dba_sql_plan_baselines %
old   3: WHERE  sql_text LIKE '%&1%'
new   3: WHERE  sql_text LIKE '%%%'

CREATED                                                                     SQL_HANDLE           PLAN_NAME                      ENA ACC FIX ORIGIN
--------------------------------------------------------------------------- -------------------- ------------------------------ --- --- --- -----------------------------
14-APR-20 05.52.39.000000 AM                                                SQL_94fd192aad7e7bc8 SQL_PLAN_99z8t5aqrwyy809678c0f YES NO  NO  AUTO-CAPTURE
14-APR-20 05.26.44.000000 AM                                                SQL_94fd192aad7e7bc8 SQL_PLAN_99z8t5aqrwyy8106fc7d8 YES YES NO  MANUAL-LOAD-FROM-CURSOR-CACHE

Elapsed: 00:00:00.01
SQL>







SET SERVEROUTPUT ON
DECLARE
  l_return VARCHAR2(32767);
BEGIN
  l_return := DBMS_SPM.create_evolve_task(sql_handle => 'SQL_94fd192aad7e7bc8');
  DBMS_OUTPUT.put_line('Task Name: ' || l_return);
END;
/





Task Name: TASK_159


SET SERVEROUTPUT ON
DECLARE
  l_return VARCHAR2(32767);
BEGIN
  l_return := DBMS_SPM.execute_evolve_task(task_name => 'TASK_159');
  DBMS_OUTPUT.put_line('Execution Name: ' || l_return);
END;
/

Execution Name: EXEC_170


SET LONG 1000000 PAGESIZE 1000 LONGCHUNKSIZE 100 LINESIZE 100

SELECT DBMS_SPM.report_evolve_task(task_name => 'TASK_159', execution_name => 'EXEC_170') AS output
FROM   dual;



SQL> SELECT DBMS_SPM.report_evolve_task(task_name => 'TASK_159', execution_name => 'EXEC_170') AS output
  2  FROM   dual;

OUTPUT
----------------------------------------------------------------------------------------------------
GENERAL INFORMATION SECTION
---------------------------------------------------------------------------------------------

 Task Information:
 ---------------------------------------------
 Task Name            : TASK_159
 Task Owner           : SYS
 Execution Name       : EXEC_170
 Execution Type       : SPM EVOLVE
 Scope                : COMPREHENSIVE
 Status               : COMPLETED
 Started              : 04/14/2020 05:55:45
 Finished             : 04/14/2020 05:55:47
 Last Updated         : 04/14/2020 05:55:47
 Global Time Limit    : 2147483646
 Per-Plan Time Limit  : UNUSED
 Number of Errors     : 0
---------------------------------------------------------------------------------------------

SUMMARY SECTION
---------------------------------------------------------------------------------------------
  Number of plans processed  : 1
  Number of findings         : 1
  Number of recommendations  : 0
  Number of errors           : 0
---------------------------------------------------------------------------------------------

DETAILS SECTION
---------------------------------------------------------------------------------------------
 Object ID          : 2
 Test Plan Name     : SQL_PLAN_99z8t5aqrwyy809678c0f
 Base Plan Name     : SQL_PLAN_99z8t5aqrwyy8106fc7d8
 SQL Handle         : SQL_94fd192aad7e7bc8
 Parsing Schema     : SYS
 Test Plan Creator  : SYS
 SQL Text           : select sum(id) from test2

Execution Statistics:
-----------------------------
                    Base Plan                     Test Plan
                    ----------------------------  ----------------------------
 Elapsed Time (s):  .001069                       .001121
 CPU Time (s):      .001077                       .001122
 Buffer Gets:       85                            67
 Optimizer Cost:    234                           183
 Disk Reads:        0                             0
 Direct Writes:     0                             0
 Rows Processed:    0                             0
 Executions:        10                            10


FINDINGS SECTION
---------------------------------------------------------------------------------------------

Findings (1):
-----------------------------
 1. The plan was verified in 0.23900 seconds. It failed the benefit criterion
    because its verified performance was 0.96006 times worse than that of the
    baseline plan.


EXPLAIN PLANS SECTION
---------------------------------------------------------------------------------------------

Baseline Plan
-----------------------------
 Plan Id          : 801
 Plan Hash Value  : 275761112

--------------------------------------------------------------------------
| Id | Operation            | Name  | Rows   | Bytes   | Cost | Time     |
--------------------------------------------------------------------------
|  0 | SELECT STATEMENT     |       |      1 |       5 |  234 | 00:00:01 |
|  1 |   SORT AGGREGATE     |       |      1 |       5 |      |          |
|  2 |    TABLE ACCESS FULL | TEST2 | 300000 | 1500000 |  234 | 00:00:01 |
--------------------------------------------------------------------------

Test Plan
-----------------------------
 Plan Id          : 802
 Plan Hash Value  : 157781007

----------------------------------------------------------------------------
| Id | Operation               | Name | Rows   | Bytes   | Cost | Time     |
----------------------------------------------------------------------------
|  0 | SELECT STATEMENT        |      |      1 |       5 |  183 | 00:00:01 |
|  1 |   SORT AGGREGATE        |      |      1 |       5 |      |          |
|  2 |    INDEX FAST FULL SCAN | IDX1 | 300000 | 1500000 |  183 | 00:00:01 |
----------------------------------------------------------------------------
---------------------------------------------------------------------------------------------




SET SERVEROUTPUT ON
DECLARE
  l_return NUMBER;
BEGIN
  l_return := DBMS_SPM.implement_evolve_task(task_name => 'TASK_159');
  DBMS_OUTPUT.put_line('Plans Accepted: ' || l_return);
END;
/



Elapsed: 00:00:00.17
SQL>


set autotrace on
select sum(id) from test2;


