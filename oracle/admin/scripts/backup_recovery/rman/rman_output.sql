-- ------------------------------------------------------------------------------
-- File       : rman_output.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: rman output.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rman_output.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--v$rman_output 600
select
start_time,
end_time,
a.sid,
a.recid,
b.operation,
b.status,
a.output
from v$rman_output a,
v$rman_status b
where a.rman_status_recid = b.recid
 and a.rman_status_stamp = b.stamp
  and start_time >  sysdate - interval '&1' minute
 order by a.recid
 /