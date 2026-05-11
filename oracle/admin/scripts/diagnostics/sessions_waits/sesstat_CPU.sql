-- ------------------------------------------------------------------------------
-- File       : sesstat_CPU.sql
-- Purpose    : oracle/admin diagnostics/sessions_waits helper: sesstat CPU.
-- Engine     : oracle/admin
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: sesstat_CPU.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM  Estadistica de sesion. Para la sesion actual
REM ======================================================================
REM v$sesstat_CPU.sql        Version 1.1    07 Julio 2011
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
set define off
set feedback off
set pagesize 400
set lines 900

clear col
SELECT --a.SID,
       DECODE (b.CLASS,
               1, 'User',
               2, 'Redo',
               4, 'Enqueue',
               8, 'Cache',
               16, 'OS',
               32, 'ParallelServer',
               64, 'SQL',
               128, 'Debug',
               72, 'SQL & Cache',
               40, 'ParallelServer & Cache'
              ) CLASS,
       b.NAME, a.VALUE
  FROM v$sesstat a, v$statname b , v$session c
 WHERE (a.statistic# = b.statistic#) AND 
 c.audsid=sys_context('userenv','SESSIONID')
 and b.name LIKE  '%CPU used by this session%'
 AND a.SID = c.SID
 AND value <> 0
 ORDER BY value
 /
 set define on
 set feedback on