--dbms.sqltune.execute_tuning_task.sql
accept TTASK prompt 'Ingrese Nombre Tuning Task: '

exec DBMS_SQLTUNE.interrupt_tuning_task(task_name => '&TTASK');