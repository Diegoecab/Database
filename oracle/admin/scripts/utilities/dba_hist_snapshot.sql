-- ------------------------------------------------------------------------------
-- File       : dba_hist_snapshot.sql
-- Purpose    : Oracle administration helper: dba hist snapshot.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_hist_snapshot.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--dba_hist_snapshot


alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';

col begin_interval_time for a25
col end_interval_time for a25
set pages 1000
set lines 300

prompt 'Registros de snapshots AWR'
accept days prompt 'Days: '

select snap_id, dbid, begin_interval_time,end_interval_time,error_count from dba_hist_snapshot 
where begin_interval_time > sysdate - &days
order by snap_id, dbid;

ttitle off