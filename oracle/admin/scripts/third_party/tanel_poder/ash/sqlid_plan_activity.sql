-- ------------------------------------------------------------------------------
-- File       : sqlid_plan_activity.sql
-- Purpose    : oracle/admin third_party helper: sqlid plan activity.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: sqlid_plan_activity.sql
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
    TRUNC(sample_time,'MI') minute
  , sql_plan_hash_value
  , COUNT(*)/60 avg_act_ses
FROM
    v$active_session_history
  -- dba_hist_active_sess_history
WHERE
    sql_id = '&1'
GROUP BY
    TRUNC(sample_time,'MI') 
  , sql_plan_hash_value
ORDER BY
    minute, sql_plan_hash_value
/
