-- ------------------------------------------------------------------------------
-- File       : tbs_df.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: tbs df.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tbs_df.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
select a.tablespace_name, round(sum(bytes)/1024/1024/1024,2) "Occupied GB",
round(sum(decode(maxbytes,0,bytes,maxbytes))/1024/1024/1024,2) "MAX GB",
round(sum(decode(maxbytes,0,bytes,maxbytes))/1024/1024/1024,2) - round(sum(bytes)/1024/1024/1024,2)
as "Free GB",
round(100-((((((sum(decode(maxbytes,0,bytes,maxbytes))) -
(sum(bytes)))*100) /
((sum(decode(maxbytes,0,bytes,maxbytes))))))))
 as "Current percent Used" from dba_data_files a
group by tablespace_name order by 5
/
