--dbms_scheduler.open_window
SELECT window_name, resource_plan, enabled, active 
FROM   dba_scheduler_windows;
accept WIN_NAME prompt 'Ingrese Nombre de ventana: '
accept MINS prompt 'Ingrese Cantidad de minutos: '
BEGIN
  -- Open window.
  DBMS_SCHEDULER.open_window (
   window_name => '&WIN_NAME',
   duration    => INTERVAL '&MINS' MINUTE,
   force       => TRUE);
END;
/
commit;