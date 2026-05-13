-- ------------------------------------------------------------------------------
-- File       : dba_hist_system_event_io.sql
-- Purpose    : Oracle administration helper: dba hist system event io.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_hist_system_event_io.sql
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
select
event_name,
total_waits,
end_interval_time,
TIME_WAITED_MICRO,
TOTAL_TIMEOUTS
from
dba_hist_system_event stat,
dba_hist_snapshot ss
   where       
ss.snap_id=stat.snap_id and
(event_name like 'db file %' or
event_name = 'free buffer waits' or
event_name = 'write complete waits' ) and
ss.end_interval_time > trunc (sysdate - 1)
	   and ss.instance_number = stat.instance_number
order by
TIME_WAITED_MICRO;