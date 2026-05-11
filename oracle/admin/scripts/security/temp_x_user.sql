-- ------------------------------------------------------------------------------
-- File       : temp_x_user.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: temp x user.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @temp_x_user.sql
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
clear col
undefine all
break on tablespace on report
compute sum of mb on report

select  tmp.tablespace,s.sid, --s.osuser, s. process, 
        s.sql_id, tmp.segtype, 
       ((tmp.blocks*8)/1024)MB
from  
       v$tempseg_usage tmp,
       v$session s
where tmp.session_num=s.serial#
--and segtype in ('HASH','SORT')
order by blocks desc
/