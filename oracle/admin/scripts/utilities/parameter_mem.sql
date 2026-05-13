-- ------------------------------------------------------------------------------
-- File       : parameter_mem.sql
-- Purpose    : oracle/admin utilities helper: parameter mem.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: parameter_mem.sql
-- Parameters : Review script body before running.
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
REM v$parameter.sql		Version 1.1	16 Mayo 2011
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
col display_value heading 'Valor' for a50
select name,display_value from v$parameter
where name like '%cache%' or name like '%pool%' or name like '%sga%' 
or name like '%pga%';