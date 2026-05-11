-- ------------------------------------------------------------------------------
-- File       : segments_by_datafile.sql
-- Purpose    : Oracle administration helper: segments by datafile.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @segments_by_datafile.sql
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
--segments_by_datafile
set lines 900
col file_name for a50
col segment_name for a50
SELECT distinct a.owner, a.segment_name,
 a.SEGMENT_TYPE,
 a.TABLESPACE_NAME,partition_name,
 a.file_id
 --, b.file_name Datafile_name
 FROM dba_extents a, dba_data_files b
 WHERE a.file_id = b.file_id
 AND b.file_id = &file_id
/
