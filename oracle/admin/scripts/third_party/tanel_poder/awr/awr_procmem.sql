-- ------------------------------------------------------------------------------
-- File       : awr_procmem.sql
-- Purpose    : oracle/admin third_party helper: awr procmem.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: awr_procmem.sql
-- Parameters : MI
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

BREAK ON snap_begin SKIP 1 ON snap_end ON event_name

COL event_name FOR A40

SELECT
    CAST(begin_interval_time AS DATE) snap_begin
  , TO_CHAR(CAST(end_interval_time AS DATE), 'HH24:MI') snap_end
  , category
  , num_processes
  , ROUND(allocated_max/1048576)     max_mb
  , ROUND(max_allocated_max/1048576) max_max_mb
FROM
    dba_hist_snapshot
  NATURAL JOIN
    dba_hist_process_mem_summary
WHERE
    begin_interval_time > SYSDATE - 3
--AND category = 'SQL'
ORDER BY
    snap_begin
  , category
/

