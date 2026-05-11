-- ------------------------------------------------------------------------------
-- File       : dba_hist_waitstat.sql
-- Purpose    : oracle/admin diagnostics/sessions_waits helper: dba hist waitstat.
-- Engine     : oracle/admin
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: dba_hist_waitstat.sql
-- Parameters : days, wait_class
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
REM	
REM ======================================================================
REM dba_hist_waitstat.sql		Version 1.1	22 May 2012
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
REM 	Ejecutar con usuario dba
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set head on
set feed off
set verify off

col begin_interval_time for a30
col class for a30

select a.snap_id,begin_interval_time,class, wait_count, time
from dba_hist_waitstat a, dba_hist_snapshot b
where a.snap_id=b.snap_id
and begin_interval_time > sysdate - &days
--group by snap_id
and upper(class) like upper('%&wait_class%')
and wait_count <> 0
order by snap_id
/