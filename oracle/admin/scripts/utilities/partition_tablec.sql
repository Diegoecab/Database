-- ------------------------------------------------------------------------------
-- File       : partition_tablec.sql
-- Purpose    : Oracle administration helper: partition tablec.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @partition_tablec.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
/* Ejemplo */
CREATE TABLE prueba_part
PARTITION BY RANGE (created)
(PARTITION enero2008
VALUES LESS THAN (TO_DATE('01-02-2008', 'DD-MM-YYYY')) COMPRESS,
PARTITION enero2009
VALUES LESS THAN (TO_DATE('01-02-2009', 'DD-MM-YYYY')),
PARTITION mesactual VALUES LESS THAN (MAXVALUE))
AS SELECT * FROM dba_objects;