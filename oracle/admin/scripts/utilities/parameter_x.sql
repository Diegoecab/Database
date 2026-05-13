-- ------------------------------------------------------------------------------
-- File       : parameter_x.sql
-- Purpose    : oracle/admin utilities helper: parameter x.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: parameter_x.sql
-- Parameters : parametro
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM Parametros de la base
REM ======================================================================
REM v$parameter_x.sql		Version 1.1	30 Agosto 2010
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
set verify off
col name heading 'Parametro' for a50
col display_value heading 'Valor' for a40
accept parametro prompt 'Ingrese %parametro%:  '
select name,display_value from v$parameter where upper(name) like upper('%&parametro%')
/
