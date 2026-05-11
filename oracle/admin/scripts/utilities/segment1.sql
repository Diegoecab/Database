-- ------------------------------------------------------------------------------
-- File       : segment1.sql
-- Purpose    : Oracle administration helper: segment1.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @segment1.sql
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
col segment_name format a25
break   on report 
compute sum of MB on report 
select tablespace_name, segment_type, count(*), round(sum(bytes)/1024/1024,2) MB
from dba_segments
where owner like upper('&1')
group by tablespace_name, segment_type
/