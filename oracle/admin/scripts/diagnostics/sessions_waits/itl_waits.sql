-- ------------------------------------------------------------------------------
-- File       : itl_waits.sql
-- Purpose    : Oracle diagnostic query/report helper: itl waits.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @itl_waits.sql
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
Select
   s.sid SID,
   s.serial# Serial#,
   l.type type,
   ' ' object_name,
   lmode held,
   request request
from
   v$lock l,
   v$session s,
   v$process p
where
   s.sid = l.sid and
   s.username <> ' ' and
   s.paddr = p.addr and
   l.type <> 'TM' and
   (l.type <> 'TX' or l.type = 'TX' and l.lmode <> 6)
union
select
   s.sid SID,
   s.serial# Serial#,
   l.type type,
   object_name object_name,
   lmode held,
   request request
from
   v$lock l,
   v$session s,
   v$process p,
   sys.dba_objects o
where
   s.sid = l.sid and
   o.object_id = l.id1 and
   l.type = 'TM' and
   s.username <> ' ' and
   s.paddr = p.addr
union
select
   s.sid SID,
   s.serial# Serial#,
   l.type type,
   '(Rollback='||rtrim(r.name)||')' object_name,
   lmode held,
   request request
from
   v$lock l,
   v$session s,
   v$process p,
   v$rollname r
where
   s.sid = l.sid and
   l.type = 'TX' and
   l.lmode = 6 and
   trunc(l.id1/65536) = r.usn and
   s.username <> ' ' and
   s.paddr = p.addr
order by 5, 6;