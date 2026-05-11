-- ------------------------------------------------------------------------------
-- File       : sql_bind_capture_x.sql
-- Purpose    : oracle/admin utilities helper: sql bind capture x.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: sql_bind_capture_x.sql
-- Parameters : SQLID
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM    Bind Capture. Ver valor real de variables bind de un sql
REM ======================================================================
REM v$sql_bind_capture_x.sql        Version 1.1    03 Agosto 2011
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
REM     Ejecutar con usuario dba
REM
REM Precauciones:
REM
REM ======================================================================
REM
SET feedback off
SET verify off
SET serveroutput on
SET heading on
SET feedback off
SET pagesize 1000
col sql_text for a50
col value_string for a20
col name for a5
PROMPT
ACCEPT SQLID prompt 'Ingrese SQLID: '
PROMPT 

SELECT a.sql_text, b.NAME, b.POSITION, b.datatype_string, b.value_string
  FROM v$sql_bind_capture b, v$sqlarea a
 WHERE b.sql_id = '&SQLID' AND b.sql_id = a.sql_id;