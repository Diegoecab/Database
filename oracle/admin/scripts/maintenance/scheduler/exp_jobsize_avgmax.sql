-- ------------------------------------------------------------------------------
-- File       : exp_jobsize_avgmax.sql
-- Purpose    : Oracle database maintenance helper: exp jobsize avgmax.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_jobsize_avgmax.sql
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

SELECT round(s.jobsize/1024/1024) jobsize_mb, 
       round(a.avg_max_size/1024/1024) avg_max_mb,
       round((a.avg_max_size-s.jobsize)/1024/1024) growth_mb, 'update exp_schema set jobsize='||avg_max_size||' where schema_name='''||a.schema_name||''' and servername='''||a.servername||''' and db_sid='''||a.db_sid||''';' SQL
  FROM (
          SELECT servername, db_sid, schema_name, Round(Avg(job_max_size)) avg_max_size
            FROM (
                    select j.servername, j.db_sid, j.schema_name, j.book_date, max(j.jobsize) job_max_size
                      from exp_job_size j,
                           exp_queue q
                     where j.servername  = q.servername
                       and j.db_sid      = q.db_sid
                       and j.schema_name = q.schema_name
                       and j.book_date   = q.book_date
                       and j.run         = q.run
                       and q.status      = 'DONE'          
                    group by  j.servername, j.db_sid, j.schema_name, j.book_date
                    order by j.servername, j.db_sid, j.schema_name, j.book_date
                  )
          GROUP BY servername, db_sid, schema_name
          ORDER BY servername, db_sid, schema_name
       ) A,
       exp_schema s 
 WHERE s.servername  = a.servername
   and s.db_sid      = a.db_sid
   and s.schema_name = a.schema_name
   and abs(round((a.avg_max_size-s.jobsize)/1024/1024)) > 5
order by 3
/
