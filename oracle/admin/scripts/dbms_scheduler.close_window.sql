--dbms_scheduler.open_window
SELECT window_name, resource_plan, enabled, active 
FROM   dba_scheduler_windows;
accept WIN_NAME prompt 'Ingrese Nombre de ventana: '
BEGIN
  DBMS_SCHEDULER.close_window (
   window_name => '&WIN_NAME');
END;
/
commit;