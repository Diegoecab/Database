REM	Ejemplos de explain de sqls
REM ======================================================================
REM explain_sqls.sql		Version 1.1	18 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	Ejemplos
REM Dependencias:
REM	
REM
REM Notas:
REM
REM Precauciones:
REM	
REM ======================================================================
REM

SQL> set autotrace traceonly explain
SQL> select ename from emp where empno = 12;

Execution Plan
----------------------------------------------------------
0 SELECT STATEMENT Optimizer=CHOOSE
1 0 TABLE ACCESS (BY INDEX ROWID) OF 'EMP'
2 1 INDEX (UNIQUE SCAN) OF 'PK_EMP' (UNIQUE)

sqlplus > @utlxplan
Table created.

sqlplus > create public synonym plan_table for sys.plan_table;
Synonym created.


EXPLAIN PLAN SET STATEMENT_ID = 'test1' FOR
SET STATEMENT_ID = 'RUN1'
INTO plan_table
FOR
SELECT 


select 
  substr (lpad(' ', level-1) || operation || ' (' || options || ')',1,30 ) "Operation", 
  object_name                                                              "Object"
from 
  plan_table 
start with id = 0 
connect by prior id=parent_id;
