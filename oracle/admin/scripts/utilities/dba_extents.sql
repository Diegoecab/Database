-- ------------------------------------------------------------------------------
-- File       : dba_extents.sql
-- Purpose    : Oracle administration helper: dba extents.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_extents.sql
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
select owner, segment_name, partition_name,segment_type, tablespace_name from
dba_extents where file_id= &file_id
and &block_id between block_id and block_id+blocks-1;
