-- ------------------------------------------------------------------------------
-- File       : optimizer_index_cost_adj.sql
-- Purpose    : Oracle administration helper: optimizer index cost adj.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @optimizer_index_cost_adj.sql
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
col c1 heading 'Average Waits|forFull| Scan Read I/O'        format 9999.999
col c2 heading 'Average Waits|for Index|Read I/O'            format 9999.999
col c3 heading 'Percent of| I/O Waits|for Full Scans'        format 9.99
col c4 heading 'Percent of| I/O Waits|for Index Scans'       format 9.99
col c5 heading 'Starting|Value|for|optimizer|index|cost|adj' format 999

select
   a.average_wait                                 c1,
   b.average_wait                                 c2,
   a.total_waits /(a.total_waits + b.total_waits) c3,
   b.total_waits /(a.total_waits + b.total_waits) c4,
  (b.average_wait / a.average_wait)*100           c5
from
   v$system_event a,
   v$system_event b
where
   a.event = 'db file scattered read'
and
   b.event = 'db file sequential read'
;