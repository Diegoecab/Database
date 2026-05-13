-- ------------------------------------------------------------------------------
-- File       : index_range_scan_rereads.sql
-- Purpose    : oracle/admin third_party helper: index range scan rereads.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: index_range_scan_rereads.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

-- enable physical IO tracing

@seg soe.orders
@ind soe.orders
@descxx soe.orders

ALTER SESSION SET EVENTS '10298 trace name context forever, level 1';
EXEC SYS.DBMS_MONITOR.SESSION_TRACE_ENABLE(waits=>TRUE);

SET TIMING ON
SET AUTOTRACE ON STAT

PAUSE Press enter to start...
SELECT /*+ MONITOR INDEX(o, o(warehouse_id)) */ SUM(order_total) FROM soe.orders o WHERE warehouse_id BETWEEN 400 AND 599;

SET AUTOTRACE OFF

