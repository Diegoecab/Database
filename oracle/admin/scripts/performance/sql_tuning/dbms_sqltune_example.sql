REM	Ejemplo de utilizacion de DBMS_SQLTUNE en Oracle 10g
REM ======================================================================
REM dbms_sqltune_example.sql		Version 1.1	18 Marzo 2010
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
REM In order to access the SQL tuning advisor API a user must be granted the ADVISOR privilege:
CONN sys/password AS SYSDBA
GRANT ADVISOR TO scott;
CONN scott/tiger
REM The first step when using the SQL tuning advisor is to create a new tuning task using the CREATE_TUNING_TASK function. 
REM The statements to be analyzed can be retrieved from the Automatic Workload Repository (AWR), the cursor cache, an SQL tuning set or specified manually:
SET SERVEROUTPUT ON

-- Tuning task created for specific a statement from the AWR.
DECLARE
  l_sql_tune_task_id  VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
                          begin_snap  => 764,
                          end_snap    => 938,
                          sql_id      => '19v5guvsgcd1v',
                          scope       => DBMS_SQLTUNE.scope_comprehensive,
                          time_limit  => 60,
                          task_name   => '19v5guvsgcd1v_AWR_tuning_task',
                          description => 'Tuning task for statement 19v5guvsgcd1v in AWR.');
  DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

-- Tuning task created for specific a statement from the cursor cache.
DECLARE
  l_sql_tune_task_id  VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
                          sql_id      => '19v5guvsgcd1v',
                          scope       => DBMS_SQLTUNE.scope_comprehensive,
                          time_limit  => 60,
                          task_name   => '19v5guvsgcd1v_tuning_task',
                          description => 'Tuning task for statement 19v5guvsgcd1v.');
  DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

-- Tuning task created from an SQL tuning set.
DECLARE
  l_sql_tune_task_id  VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
                          sqlset_name => 'test_sql_tuning_set',
                          scope       => DBMS_SQLTUNE.scope_comprehensive,
                          time_limit  => 60,
                          task_name   => 'sqlset_tuning_task',
                          description => 'Tuning task for an SQL tuning set.');
  DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

-- Tuning task created for a manually specified statement.
DECLARE
  l_sql               VARCHAR2(500);
  l_sql_tune_task_id  VARCHAR2(100);
BEGIN
  l_sql := 'SELECT e.*, d.* ' ||
           'FROM   emp e JOIN dept d ON e.deptno = d.deptno ' ||
           'WHERE  NVL(empno, ''0'') = :empno';

  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
                          sql_text    => l_sql,
                          bind_list   => sql_binds(anydata.ConvertNumber(100)),
                          user_name   => 'scott',
                          scope       => DBMS_SQLTUNE.scope_comprehensive,
                          time_limit  => 60,
                          task_name   => 'emp_dept_tuning_task',
                          description => 'Tuning task for an EMP to DEPT join query.');
  DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/
REM If the TASK_NAME parameter is specified it's value is returned as the SQL tune task identifier. 
REM If ommitted a system generated name like "TASK_1478" is returned. If the SCOPE parameter is set to scope_limited
REM the SQL profiling analysis is omitted. The TIME_LIMIT parameter simply restricts the time the optimizer can spend compiling the recommendations.
REM The following examples will reference the last tuning set as it has no external dependancies other than the SCOTT schema. 
REM The NVL in the SQL statement was put in to provoke a reaction from the optimizer. In 
REM addition we can delete the statistics from one of the tables to provoke it even more:
EXEC DBMS_STATS.delete_table_stats('SCOTT','EMP');
REM With the tuning task defined the next step is to execute it using the EXECUTE_TUNING_TASK  procedure:
EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => 'emp_dept_tuning_task');
REM During the execution phase you may wish to pause and restart the task, cancel it or reset the task to allow it to be re-executed:
-- Interrupt and resume a tuning task.
EXEC DBMS_SQLTUNE.interrupt_tuning_task (task_name => 'emp_dept_tuning_task');
EXEC DBMS_SQLTUNE.resume_tuning_task (task_name => 'emp_dept_tuning_task');

-- Cancel a tuning task.
EXEC DBMS_SQLTUNE.cancel_tuning_task (task_name => 'emp_dept_tuning_task');

-- Reset a tuning task allowing it to be re-executed.
EXEC DBMS_SQLTUNE.reset_tuning_task (task_name => 'emp_dept_tuning_task');
REM The status of the tuning task can be monitored using the DBA_ADVISOR_LOG  view:
SELECT task_name, status FROM dba_advisor_log WHERE owner = 'SCOTT';
REM Once the tuning task has executed successfully the recommendations can be displayed using the REPORT_TUNING_TASK function:
SET LONG 10000;
SET PAGESIZE 1000
SET LINESIZE 200
SELECT DBMS_SQLTUNE.report_tuning_task('emp_dept_tuning_task') AS recommendations FROM dual;
SET PAGESIZE 24
REM In this case the output looks like this .... (No lo muestro en este caso)
REM Once the tuning session is over the tuning task can be dropped using the DROP_TUNING_TASK procedure:
BEGIN
  DBMS_SQLTUNE.drop_tuning_task (task_name => '19v5guvsgcd1v_AWR_tuning_task');
  DBMS_SQLTUNE.drop_tuning_task (task_name => '19v5guvsgcd1v_tuning_task');
  DBMS_SQLTUNE.drop_tuning_task (task_name => 'sqlset_tuning_task');
  DBMS_SQLTUNE.drop_tuning_task (task_name => 'emp_dept_tuning_task');
END;
/
REM Fuente : http://www.oracle-base.com/articles/10g/AutomaticSQLTuning10g.php