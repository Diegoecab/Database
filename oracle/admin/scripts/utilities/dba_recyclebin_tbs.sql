-- ------------------------------------------------------------------------------
-- File       : dba_recyclebin_tbs.sql
-- Purpose    : Oracle administration helper: dba recyclebin tbs.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_recyclebin_tbs.sql
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
col owner for a20
col object_name for a40
col ts_name for a20
Break on object_name on report 
compute sum of mb on report 
accept TBS prompt 'Ingrese Tablespace : '
select a.owner,a.object_name,a.original_name,a.ts_name,sum(b.bytes)/1024/1024 MB from dba_recyclebin a inner join dba_Segments b
on b.owner=a.owner and b.segment_name=a.object_name and ts_name=upper('&TBS') group by a.owner,a.object_name,a.original_name,a.ts_name,b.bytes order by b.bytes
/
