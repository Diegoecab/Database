REM	Cambiar atributos de tarea programada de ventana de mantenimiento
REM ======================================================================
REM change_window_maintenance.sql		Version 1.1	15 Abril 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	Ejemplos
REM
REM Dependencias:
REM	
REM
REM Notas:
REM
REM Precauciones:
REM	
REM ======================================================================
REM
REM Ejemplo
BEGIN
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SYS.WEEKNIGHT_WINDOW'
     ,attribute => 'REPEAT_INTERVAL'
     ,value     => 'FREQ=WEEKLY;BYDAY=MON,TUE,WED,THU,FRI;BYHOUR=18;BYMINUTE=0;BYSECOND=0');
END;
/
