-- ------------------------------------------------------------------------------
-- File       : bloom_minmax_storage_index3.sql
-- Purpose    : oracle/admin third_party helper: bloom minmax storage index3.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: bloom_minmax_storage_index3.sql
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

SET ECHO ON
-- ALTER SESSION SET "_serial_direct_read"=ALWAYS;
-- ALTER SESSION SET "_cell_storidx_mode"=EVA; 

SELECT
    /*+ LEADING(c)
        NO_SWAP_JOIN_INPUTS(o)
        FULL(c)
        FULL(o)
        MONITOR
    */
    *
FROM
    soe.customers c
  , soe.orders o
WHERE
    o.customer_id = c.customer_id
--AND c.cust_email = 'florencio@ivtboge.com'
AND c.cust_email = 'anthony.pena@bellsouth.com'
/
SET ECHO OFF



-- 11.2.0.4 estrella@socxankh.com
