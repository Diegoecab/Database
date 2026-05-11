-- ------------------------------------------------------------------------------
-- File       : exp_eom.sql
-- Purpose    : Oracle administration helper: exp eom.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_eom.sql
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
col exported for a9
col schema_name for a20

 select distinct 
        s.schema_name, 
        NVL2(q.schema_name,'TRUE','FALSE') exported
   from exp_schema   s,
        (select q.servername, 
                q.db_sid, 
                q.schema_name
           from exp_queue q
          where trunc(q.submitted)>=trunc(sysdate-10) 
            and exists (select 1 
                         from exp_eom_file f
                         where q.job_id=f.job_id)
         )    q
where s.servername  = q.servername   (+) 
  and s.db_sid      = q.db_sid       (+) 
  and s.schema_name = q.schema_name  (+) 
  and s.db_sid='&db_sid'
  and s.enable>0
order by 2 desc,1
/
