-- ------------------------------------------------------------------------------
-- File       : multi_block_read_count_full_scan.sql
-- Purpose    : Oracle administration helper: multi block read count full scan.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @multi_block_read_count_full_scan.sql
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

set pages 80
set lines 130
col c1 heading 'Average Waits for|Full Scan Read I/O' format 999999.999
col c2 heading 'Average Waits for|Index Read I/O' format 999999.999
col c3 heading 'Percent of| I/O Waits|for scattered|Full Scans' format 999.99
col c4 heading 'Percent of| I/O Waits|for sequential|Index Scans' format 999.99
col c5 heading 'Starting|Value|for|optimizer|index|cost|adj' format 99999
select a.snap_id "Snap",
       sum(a.time_waited_micro)/sum(a.total_waits)/10000 c1,
       sum(b.time_waited_micro)/sum(b.total_waits)/10000 c2,
       (sum(a.total_waits) / sum(a.total_waits + b.total_waits)) * 100 c3,
       (sum(b.total_waits) / sum(a.total_waits + b.total_waits)) * 100 c4,
       (sum(b.time_waited_micro)/sum(b.total_waits)) /
(sum(a.time_waited_micro)/sum(a.total_waits)) * 100 c5
from
   dba_hist_system_event a,
   dba_hist_system_event b
where a.snap_id = b.snap_id
and a.event_name = 'db file scattered read'
and b.event_name = 'db file sequential read'
group by a.snap_id
order by 1
/
