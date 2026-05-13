-- ------------------------------------------------------------------------------
-- File       : dba_hist_active_sess_history_pga2.sql
-- Purpose    : Oracle diagnostic query/report helper: dba hist active sess history pga2.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_hist_active_sess_history_pga2.sql
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
select
    trunc(TEMP_SPACE_ALLOCATED/1024/1024) temp_mb,
    trunc(PGA_ALLOCATED/1024/1024) pga_mb, cnt,
    SQL_EXEC_START, SQL_EXEC_ID, TOP_LEVEL_SQL_ID, SQL_ID, IS_SQLID_CURRENT, SQL_PLAN_LINE_ID plan_line,
    instance_number, session_id, session_serial#,
    to_char(cast(SAMPLE_TIME as date), 'YYYY/MM/DD HH24:MI:SS')  sample_time
from (
    select ash.*,
    count(*) over (partition by instance_number, session_id, session_serial#) cnt,
    row_number() over (partition by instance_number, session_id, session_serial# order by TEMP_SPACE_ALLOCATED desc) rn_temp,
	row_number() over (partition by instance_number, session_id, session_serial# order by PGA_ALLOCATED desc) rn_pga
    from dba_hist_active_sess_history ash
    where ((TEMP_SPACE_ALLOCATED > (1024 * 1024 * 1024 * 10)   ) or (PGA_ALLOCATED  > (1024 * 1024 * 1024 * 1) )) --10gb - 1 gb
    and cast(SAMPLE_TIME as date) > trunc(sysdate - 15)   -- last 5 days
)
where rn_pga = 1
order by 2
/
