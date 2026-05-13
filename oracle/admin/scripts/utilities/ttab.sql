-- ------------------------------------------------------------------------------
-- File       : ttab.sql
-- Purpose    : Oracle administration helper: ttab.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @ttab.sql
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
set pagesize 100
set linesize 200
col segment_name format a30
col segment_type format a20
col sizeM format 99999.99
select owner, tablespace_name, segment_type, segment_name, trunc(sum(bytes)/1024/1024) 
from dba_segments where tablespace_name=upper('&1')  
group by owner, tablespace_name, segment_type, segment_name 
having  trunc(sum(bytes)/1024/1024) > &2 
order by  trunc(sum(bytes)/1024/1024) desc
/
