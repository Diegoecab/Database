-- ------------------------------------------------------------------------------
-- File       : DBA_HIST_ACTIVE_SESS_HISTORY_temp_avg_hour.sql
-- Purpose    : Oracle diagnostic query/report helper: DBA HIST ACTIVE SESS HISTORY temp avg hour.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @DBA_HIST_ACTIVE_SESS_HISTORY_temp_avg_hour.sql
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
--DBA_HIST_ACTIVE_SESS_HISTORY_temp_avg_hour.sql
--action es el nombre de un job de dbms sched
col username for a20 truncate
col program for a30 truncate
col sql_text for a80 truncate
set lines 600
set pages 50
@nls_date

select TO_CHAR(sample_time,'YYYY-MM-DD HH24'),
--round(avg(temp_space_allocated/1024/1024/1024)) avg_gb_temp_space_all,
round(max(temp_space_allocated/1024/1024/1024)) max_gb_temp_space_all
--,count(distinct sql_id) dsqlid
from DBA_HIST_ACTIVE_SESS_HISTORY 
where sample_time > sysdate-30 and  user_id = (select user_id from dba_users where username='CAM_01')
and action='SCHJOB_ACI_OBP'
group by TO_CHAR(sample_time,'YYYY-MM-DD HH24') order by TO_CHAR(sample_time,'YYYY-MM-DD HH24')