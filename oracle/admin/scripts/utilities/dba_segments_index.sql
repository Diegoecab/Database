-- ------------------------------------------------------------------------------
-- File       : dba_segments_index.sql
-- Purpose    : Oracle administration helper: dba segments index.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_segments_index.sql
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
set pages 1000
set verify off
set lines 132
set feedback off
set trims on
col owner for a20
col segment_type heading "Segment|Type" for a20
col segment_name heading "Segment|Name" for a40
col tablespace_name heading "Tablespace|Name" for a20

Break on segment_name on report 
compute sum of mb on report 

select segment_type,segment_name,tablespace_name,bytes/1024/1024 MB, count(*) num_parts from dba_Segments
where owner=upper('&OWNER') and segment_name='&segment_name'
group by segment_type,segment_name,tablespace_name

clear break
ttitle off
