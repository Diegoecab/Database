-- ------------------------------------------------------------------------------
-- File       : change_window_maitenance.sql
-- Purpose    : oracle/admin utilities helper: change window maitenance.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: change_window_maitenance.sql
-- Parameters : BYDAY, BYHOUR, BYMINUTE, BYSECOND, FREQ
-- Risk       : REVIEW
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
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
