-- ------------------------------------------------------------------------------
-- File       : dba_hist_mem_dynamic_comp_pga_sga.sql
-- Purpose    : Oracle administration helper: dba hist mem dynamic comp pga sga.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_hist_mem_dynamic_comp_pga_sga.sql
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
--dba_hist_mem_dynamic_comp_pga_sga.sql

--alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';

set lines 400
set pages 999
set trimout on
set trimspool on
set feed on
col bytes heading 'mbytes'
col component for a15

col n format a30


select to_char(begin_interval_time,'DD-MON-YY HH24:MI:SS') begin_interval_time, 
component, current_Size/1024/1024, min_size/1024/1024, max_size/1024/1024
from dba_hist_mem_dynamic_comp a, dba_hist_snapshot b
where component in ('SGA Target' ,'PGA Target') 
and a.snap_id=b.snap_id and 
begin_interval_time between TRUNC(sysdate) and sysdate
order by begin_interval_time,component;
