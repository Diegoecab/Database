-- ------------------------------------------------------------------------------
-- File       : segment.sql
-- Purpose    : Oracle administration helper: segment.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @segment.sql
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
set linesize 150
col segment_name format a25
select owner, tablespace_name, segment_name, segment_type, round(sum(bytes)/1024/1024,2) MB
from dba_segments
where segment_name like upper('&1')
group by owner, tablespace_name, segment_name, segment_type
union
select s.owner, s.tablespace_name, s.segment_name||'-LOB', s.segment_type, round(sum(bytes)/1024/1024,2) MB
from dba_lobs l, dba_segments s
where s.segment_type = 'LOBSEGMENT'
and l.table_name like upper('&1')
and s.segment_name = l.segment_name
group by s.owner, s.tablespace_name, s.segment_name, segment_type
/