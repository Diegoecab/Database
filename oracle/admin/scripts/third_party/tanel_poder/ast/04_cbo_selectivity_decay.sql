-- ------------------------------------------------------------------------------
-- File       : 04_cbo_selectivity_decay.sql
-- Purpose    : oracle/admin third_party helper: 04 cbo selectivity decay.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: 04_cbo_selectivity_decay.sql
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

DROP TABLE selectivity_test;

CREATE TABLE selectivity_test AS
SELECT sysdate - rownum d
FROM dual connect by level <= 365;

@gts selectivity_test

@minmax d selectivity_test

@descxx selectivity_test

