-- ------------------------------------------------------------------------------
-- File       : sql_profile_hints.sql
-- Purpose    : Oracle SQL performance and tuning helper: sql profile hints.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sql_profile_hints.sql
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
--sql_profile_hints.sql
set lines 155
set serverout on format wrapped
set sqlblanklines on
set feedback off
col hint for a150
select hint from (
select p.name, p.signature, p.category,
       row_number()
         over (partition by sd.signature, sd.category order by sd.signature) row_num,
       extractValue(value(t), '/hint') hint
from sys.sqlobj$data sd, dba_sql_profiles p,
     table(xmlsequence(extract(xmltype(sd.comp_data),
                               '/outline_data/hint'))) t
where sd.obj_type = 1
and p.signature = sd.signature
and p.name like nvl('&sqlprofilename',name)
)
order by row_num
/