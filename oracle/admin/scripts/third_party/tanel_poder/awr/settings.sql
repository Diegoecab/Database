-- ------------------------------------------------------------------------------
-- File       : settings.sql
-- Purpose    : oracle/admin third_party helper: settings.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: settings.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at https://blog.tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms and conditions.

PROMPT AWR Data Retention (Includes DBA_HIST ASH):
PROMPT
SELECT * FROM dba_hist_wr_control
@pr

PROMPT Optimizer Statistics History retention:
SELECT dbms_stats.get_stats_history_retention retention_days FROM dual;

PROMPT Use syntax like this to change AWR settings:
PROMPT -- EXEC SYS.DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(interval=>15, retention=>60*24*375);
PROMPT Statistics retention (days):
PROMPT -- EXEC DBMS_STATS.ALTER_STATS_HISTORY_RETENTION(90);
PROMPT
