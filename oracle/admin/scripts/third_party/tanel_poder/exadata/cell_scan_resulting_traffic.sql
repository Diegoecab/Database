-- ------------------------------------------------------------------------------
-- File       : cell_scan_resulting_traffic.sql
-- Purpose    : oracle/admin third_party helper: cell scan resulting traffic.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: cell_scan_resulting_traffic.sql
-- Parameters : Review script body before running.
-- Risk       : DESTRUCTIVE
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

DROP TABLE cell_traffic_test;
CREATE TABLE cell_traffic_test
PARALLEL 8
AS
SELECT 'TANEL_TEST' col, a.*, b.* FROM
    (SELECT ROWNUM r FROM dual CONNECT BY LEVEL <= 100) a
  , dba_objects b
ORDER BY
   DBMS_RANDOM.VALUE
-- b.owner, b.object_type
/
@gts cell_traffic_test

ALTER TABLE cell_traffic_test NOPARALLEL;

CREATE TABLE
