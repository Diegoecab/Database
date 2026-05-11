-- ------------------------------------------------------------------------------
-- File       : dbms_space_recommendations.sql
-- Purpose    : Oracle administration helper: dbms space recommendations (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_space_recommendations (1).sql
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
col c1 for a40
col segment_name for a20
col segment_type for a15
col partition_name for a10
col segment_owner for a15
col tablespace_name for a15
col allocated_space for 99999
col reclaimable_space for 99999
set linesize 300
set pagesize 1000
select  round(allocated_space/1024/1024) allocated_space,
round(reclaimable_space/1024/1024) reclaimable_space,
c1,tablespace_name,segment_owner, segment_name, segment_type
 from
table(dbms_space.asa_recommendations('FALSE', 'FALSE', 'FALSE'))
order by 2,4,5;