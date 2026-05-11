-- ------------------------------------------------------------------------------
-- File       : awr_sysmetric_summary.sql
-- Purpose    : oracle/admin third_party helper: awr sysmetric summary.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: awr_sysmetric_summary.sql
-- Parameters : Review script body before running.
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

SELECT
    CAST(begin_interval_time AS DATE) begin_time
  , metric_name
  , metric_unit
  , average / 100
FROM
    dba_hist_snapshot
NATURAL JOIN
    dba_hist_sysmetric_summary
WHERE
    metric_name IN ('Physical Read IO Requests Per Sec', 'Physical Write IO Requests Per Sec')
--    metric_name IN ('Host CPU Utilization (%)')
--    metric_name IN ('Logons Per Sec')
AND begin_interval_time > SYSDATE - 15
ORDER BY
    metric_name
  , begin_time
/

