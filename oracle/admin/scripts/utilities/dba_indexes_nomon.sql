-- ------------------------------------------------------------------------------
-- File       : dba_indexes_nomon.sql
-- Purpose    : Oracle administration helper: dba indexes nomon.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_indexes_nomon.sql
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
--dba_indexes_nomon.sql

set pagesize 100
col index_name for a30
ttitle left 'No Monitoring Indexes'

prompt

select distinct owner,index_name,gb from (
select owner,segment_name index_name, segment_type,ROUND (SUM (bytes) / 1024 / 1024 / 1024) Gb
 from dba_segments h 
where (segment_type='INDEX' or segment_type='INDEX PARTITION') and 
not exists
(
SELECT  1  FROM   v$all_object_usage a, dba_users p
 WHERE   a.owner = p.user_id
AND p.username=h.owner and a.index_name=h.segment_name)
and owner <> 'SYS'
group by owner,segment_name,segment_type
order by owner,gb
)
where Gb > 1
/