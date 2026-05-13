-- ------------------------------------------------------------------------------
-- File       : exp_jobsize_avgavg.sql
-- Purpose    : Oracle database maintenance helper: exp jobsize avgavg.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_jobsize_avgavg.sql
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

SELECT a.*, 'update exp_schema set jobsize='||avg_avg_size||' where schema_name='''||schema_name||''' and servername='''||servername||''' and db_sid='''||db_sid||''';' SQL
  FROM (
          SELECT servername, db_sid, schema_name, Round(Avg(job_avg_size)) avg_avg_size
            FROM (
                    select servername, db_sid, schema_name, book_date, avg(jobsize) job_avg_size
                    from exp_job_size          
                    group by  servername, db_sid, schema_name, book_date
                    order by servername, db_sid, schema_name, book_date
                  )
          GROUP BY servername, db_sid, schema_name
          ORDER BY servername, db_sid, schema_name
       ) A
/
