-- ------------------------------------------------------------------------------
-- File       : topsql.sql
-- Purpose    : oracle/admin third_party helper: topsql.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: topsql.sql
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

SELECT * FROM (
    SELECT 
        sql_id, executions, physical_read_bytes --, sql_text 
    FROM 
        v$sqlstats
    WHERE io_cell_offload_eligible_bytes = 0
    ORDER BY physical_read_bytes DESC
) 
WHERE 
    ROWNUM <= 10
/
