-- ------------------------------------------------------------------------------
-- File       : eventmetric_io.sql
-- Purpose    : Oracle administration helper: eventmetric io.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @eventmetric_io.sql
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
set lines 600
set pages 100
select
       m.inst_id,
	   n.name event,
       m.wait_count  cnt,
       10*m.time_waited ms,
       nvl(round(10*m.time_waited/nullif(m.wait_count,0),3) ,0) avg_ms
  from gv$eventmetric m,
       gv$event_name n
  where m.event_id=n.event_id
	and m.inst_id=n.inst_id
        and (
              wait_class_id= 1740759767 --  User I/O 
                   or
              wait_class_id= 4108307767 --  System I/O  
             )
        and m.wait_count > 0 
		order by m.wait_count;