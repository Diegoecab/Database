-- ------------------------------------------------------------------------------
-- File       : sessions_db_x.sql
-- Purpose    : oracle/admin diagnostics/sessions_waits helper: sessions db x.
-- Engine     : oracle/admin
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: sessions_db_x.sql
-- Parameters : username
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM	Script para ver las sesiones actuales en la base de datos
REM ======================================================================
REM sessions_db.sql		Version 1.1	29 Marzo 2010
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
set pagesize 10000
col machine heading 'Machine' for a50
accept username prompt 'Ingrese Usuario:  '
select sid,serial#,username,program,machine,status from v$session where username = upper('&username') order by machine,program;