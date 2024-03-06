--v$advisor_progress
set verify off
col info1_desc for a20
col info2_desc for a20
col info3_desc for a20
col info4_desc for a20
accept TASKID prompt 'Ingrese Task Id (Para ver un listado ejecutar dba_advisor_tasks): '
SELECT sofar, totalwork, info1_desc, info1, info2_desc, info2, info3_desc,
       info3, info4_desc, info4
  FROM v$advisor_progress
 WHERE task_id = &taskid;
