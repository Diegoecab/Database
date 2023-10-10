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
