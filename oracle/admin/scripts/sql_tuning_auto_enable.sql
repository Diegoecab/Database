prompt Enable Automatic SQL Tuning
BEGIN
  DBMS_AUTO_TASK_ADMIN.ENABLE(
    client_name => 'sql tuning advisor', 
    operation => NULL, 
    window_name => NULL);
END;
/
prompt Window Name Null
Prompt Operation Null