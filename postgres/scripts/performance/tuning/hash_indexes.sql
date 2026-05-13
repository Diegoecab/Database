-- ------------------------------------------------------------------------------
-- File       : hash_indexes.sql
-- Purpose    : postgres performance/tuning helper: hash indexes.
-- Engine     : postgres
-- Category   : performance/tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: hash_indexes.sql
-- Parameters : regclass
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--Hash indexes were changed in version 10 and must be rebuilt. To locate invalid hash indexes, run the following SQL for each database that contains hash indexes.

SELECT idx.indrelid::regclass AS table_name, 
   idx.indexrelid::regclass AS index_name 
FROM pg_catalog.pg_index idx
   JOIN pg_catalog.pg_class cls ON cls.oid = idx.indexrelid 
   JOIN pg_catalog.pg_am am ON am.oid = cls.relam 
WHERE am.amname = 'hash' 
AND NOT idx.indisvalid;
