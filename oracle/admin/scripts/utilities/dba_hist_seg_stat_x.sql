-- ------------------------------------------------------------------------------
-- File       : dba_hist_seg_stat_x.sql
-- Purpose    : Oracle administration helper: dba hist seg stat x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_hist_seg_stat_x.sql
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
col c1 format a15 heading 'snapshot|date'
col c2 format a25 heading 'table|name'
col c3 format 999,999,999 heading 'space|used|total'
 
select
   to_char(begin_interval_time,'yy/mm/dd hh24:mm')     c1,
   object_name      c2,
   space_used_total c3
from
   dba_hist_seg_stat       s,
   dba_hist_seg_stat_obj   o,
   dba_hist_snapshot       sn
where
   o.owner = '&OWNER'
and
   s.obj# = o.obj#
and
   sn.snap_id = s.snap_id
order by
   begin_interval_time; 