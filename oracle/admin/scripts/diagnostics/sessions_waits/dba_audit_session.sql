-- ------------------------------------------------------------------------------
-- File       : dba_audit_session.sql
-- Purpose    : Oracle diagnostic query/report helper: dba audit session.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_audit_session.sql
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
--dba_audit_session.sql
@nls_date
set pages 1000
set verify off
set lines 700
set feedback off
set trims on
col os_username for a20
col action_name for a7
col username for a20
col userhost for a25
col terminal for a30
col obj_name for a20
col new_name for a20
col comment_text for a20
col sql_bind for a20
col sql_text for a20
col extended_timestamp for a20
col pass_fail for a40
select action_name,os_username,username,userhost,terminal,timestamp,logoff_time,
decode(returncode,'0','Ok','1005','Null','1017','wrong username or password','28000','locked account','28001','expired account',returncode) pass_fail
from dba_audit_session
where upper(os_username) like '%&os_username%'
and username like '%&username%'
and returncode like '%&returncode%'
and timestamp > sysdate - nvl(to_char('&days'),0)
order by timestamp
/