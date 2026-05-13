-- ------------------------------------------------------------------------------
-- File       : 03_index_skip_scan.sql
-- Purpose    : oracle/admin third_party helper: 03 index skip scan.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: 03_index_skip_scan.sql
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

DROP TABLE t;
CREATE TABLE t AS SELECT * FROM dba_objects;
CREATE INDEX i1 ON t(MOD(object_id,4), object_id);
@gts t

SELECT /*+ INDEX_SS(t) */ * FROM t WHERE object_id = 12345;
@x

CREATE INDEX i2 ON t(MOD(SYS_CONTEXT('USERENV','SID'),4), object_id);
SELECT /*+ INDEX_SS(t) */ * FROM t WHERE object_id = 12345;
@x

ALTER TABLE t ADD x NUMBER NULL;
ALTER TABLE t MODIFY x DEFAULT MOD(SYS_CONTEXT('USERENV','SID'),16);

CREATE INDEX i3 ON t(x,object_id);
SELECT * FROM t WHERE object_id = 12345;
@x

