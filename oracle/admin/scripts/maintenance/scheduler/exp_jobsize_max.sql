-- ------------------------------------------------------------------------------
-- File       : exp_jobsize_max.sql
-- Purpose    : Oracle database maintenance helper: exp jobsize max.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_jobsize_max.sql
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
col sql for a121
col SCHEMA_NAME for a13 trunc
col MAX_SIZE for 99 heading 'SIZE|MAX'
col avg_size for 99 heading 'SIZE|AVG'
col snaps for 999 heading 'SNAP'
set linesize 253
col bd for a8

SELECT to_char(book_date,'DD-MM-YY') BD, servername, 
      db_sid, schema_name, 
      Round(Max(jobsize)/1024/1024/1024) max_size, 
      Round(Avg(jobsize)/1024/1024/1024) avg_size,
      Count(1) snaps,
      'update exp_schema set jobsize='||max(jobsize)||' where schema_name='''||schema_name||''' and servername='''||servername||''' and db_sid='''||db_sid||''';' sql
FROM exp_job_size
where book_date=(select max(book_date) from exp_job_size)
GROUP BY book_date,  servername, db_sid, schema_name
ORDER BY 6 desc
/