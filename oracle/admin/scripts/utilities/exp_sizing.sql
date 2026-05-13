-- ------------------------------------------------------------------------------
-- File       : exp_sizing.sql
-- Purpose    : Oracle administration helper: exp sizing.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_sizing.sql
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
select sum(size_g)*2*2 from (
select s.servername,
       s.db_sid,
       s.schema_name,
       round(sum(f.zipsize)/1024/1024/1024) size_g
  from exp_schema   s,
       exp_queue    q,
       exp_log_file f
  where s.db_sid in ('cdwpro','dbarepo','cygdwpro','amlpro') and enable >=1
    and s.servername = q.servername
    and s.db_sid     = q.db_sid
    and s.schema_name = q.schema_name
    and q.job_id = (select max(i.job_id) 
                      from exp_queue    i, 
                           exp_log_file h 
                     where q.schema_name=i.schema_name 
                       and q.servername =i.servername 
                       and q.db_sid     =i.db_sid
                       and i.job_id       =h.job_id
                       and h.zipsize is not null)
    and q.job_id = f.job_id
group by s.servername, s.db_sid, s.schema_name
order by 4 desc)


