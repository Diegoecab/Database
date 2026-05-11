-- ------------------------------------------------------------------------------
-- File       : session_longops_rman.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: session longops rman.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @session_longops_rman.sql
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
--session_longops_rman
set lines 300
set pages 10000
col FILENAME for a80 truncate
col CLIENT_INFO for a50 truncate
COL event FORMAT A40 TRUNC
COL state FORMAT A10
COL wait FORMAT 999.90 HEAD "Min waiting"

TTITLE LEFT '% Completed. Aggregate is the overall progress:'
SELECT opname, round(sofar/totalwork*100) "% Complete"
  FROM gv$session_longops
 WHERE opname LIKE 'RMAN%'
   AND totalwork != 0
   AND sofar <> totalwork
 ORDER BY 1;
 
 
 
 TTITLE LEFT 'Channels waiting:'
SELECT s.sid, p.spid, s.client_info, status, event, state, seconds_in_wait/60 wait
  FROM gv$process p, gv$session s
 WHERE p.addr = s.paddr
   AND client_info LIKE 'rman%';
   


TTITLE LEFT 'Files currently being written to:'
SELECT filename, round(bytes/1024/1024) mbytes, io_count
  FROM v$backup_async_io
 WHERE status='IN PROGRESS'
 order by io_count
/