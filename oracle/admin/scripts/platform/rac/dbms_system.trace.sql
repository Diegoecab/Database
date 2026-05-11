-- ------------------------------------------------------------------------------
-- File       : dbms_system.trace.sql
-- Purpose    : oracle/admin platform/rac helper: dbms system.trace.
-- Engine     : oracle/admin
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: dbms_system.trace.sql
-- Parameters : SSERIAL, SSID
-- Risk       : REVIEW
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM	Script habilitar trace de otra sesion
REM ======================================================================
REM dbms_system.trace.sql		Version 1.1	16 Agosto 2011
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
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
set serveroutput on
set verify off
set feedback off
PROMPT Sesiones en la base de datos
@sessions_db
PROMPT 
PROMPT Script habilitar trace de otra sesion con dbms_system. Ejecutar con SYS.
PROMPT Habilita el evento 10046 nivel 12 (Se puede activar cualquier evento)
PROMPT

ACCEPT SSID prompt 'Ingrese SID: '
ACCEPT SSERIAL prompt 'Ingrese SERIAL: '

BEGIN
dbms_system.set_ev (&SSID,&SSERIAL,10046,12,'');
dbms_output.put_line ('Trace activado');
dbms_output.put_line ('Para deshabilitar el trace ejecute dbms_system.set_ev (&SSID,&SSERIAL,10046,0,'''');');
exception when others then
dbms_output.put_line ('Error al ejecutar trace:'||SQLERRM);
END;
/