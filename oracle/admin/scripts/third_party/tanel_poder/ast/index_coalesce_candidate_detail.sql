-- ------------------------------------------------------------------------------
-- File       : index_coalesce_candidate_detail.sql
-- Purpose    : oracle/admin third_party helper: index coalesce candidate detail.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: index_coalesce_candidate_detail.sql
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

COL owner FOR A15
COL object_name FOR A30

SELECT
    o.owner
  , o.object_name
  , o.object_type
  , ROUND(ih.rowcnt / NULLIF(ih.leafcnt,0)) avg_rows_per_block
  , ih.rowcnt
  , ih.leafcnt
  , ih.lblkkey
  , ih.dblkkey
  , ih.blevel
FROM
    dba_objects o
  , sys.wri$_optstat_ind_history ih
WHERE
    o.object_id = ih.obj#
AND o.object_type LIKE 'INDEX%'
AND o.object_name LIKE '&1'
ORDER BY
    ih.savtime
/ 
