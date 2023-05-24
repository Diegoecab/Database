--sessions_locks_history
set lines 700

col sql_text for a50 TRUNCATE
col event for a50 TRUNCATE
col BLOCKED_USERNAME for a20 TRUNCATE
col lock_user for a20 TRUNCATE
col wait_user for a30 TRUNCATE
col Object for a30 TRUNCATE
col owner for a30 TRUNCATE
col sql_text_locked for a35 TRUNCATE
col blocked_sql_text for a35 TRUNCATE
col blocker_sql_text for a35 TRUNCATE
col blocked_user for a20 TRUNCATE
col machine for a10 TRUNCATE
col BLOCKER_PROGRAM for a10 TRUNCATE
col BLOCKED_TABLE_NAME for a10 TRUNCATE
col BLOCKED_MACHINE for a10 TRUNCATE
col BLOCKED_EVENT for a10 TRUNCATE
col BLOCKER_USERNAME for a20 TRUNCATE




select distinct
    to_char(
        min(blocked.sample_time),
        'YYYY-MM-DD HH24:MI:SS'
    )                         as first_sample_time,
    -- Session causing the block
    --blocker.instance_number   as blocker_instance_number,
    --blocker.machine           as blocker_machine,
    --blocker.program           as blocker_program,
    blocker.session_id        as blocker_sid,
	blocker.sql_id        as blocker_sql_id,
	    blocker_sql.sql_text      as blocker_sql_text,
    blocker_user.username     as blocker_username,
    ' -> '                    as is_blocking,
    -- Sesssion being blocked
    --blocked.instance_number   as blocked_instance_number,
    --blocked.machine           as blocked_machine,
    --blocked.program           as blocked_program,
    --blocked.session_id        as blocked_sid,
    blocked_user.username     as blocked_username,
    --blocked.session_state     as blocked_session_state,
    --blocked.event             as blocked_event,
    --blocked.blocking_session  as blocked_blocking_session,
    blocked.sql_id            as blocked_sql_id,
    --blocked.sql_child_number  as blocked_sql_child_number,
	blocked.time_waited/1000000 time_waited_sec,
    --sys_obj.name              as blocked_table_name,
   /* dbms_rowid.rowid_create(
        rowid_type    => 1,
        object_number => blocked.current_obj#,
        relative_fno  => blocked.current_file#,
        block_number  => blocked.current_block#,
        row_number    => blocked.current_row#
    )                         as blocked_rowid,*/
    blocked_sql.sql_text      as blocked_sql_text
from
    dba_hist_active_sess_history blocker
    inner join
    dba_hist_active_sess_history blocked
        on blocker.session_id = blocked.blocking_session
		and blocker.session_serial# = blocked.blocking_session_serial#
    inner join
    sys.obj$ sys_obj
        on sys_obj.obj# = blocked.current_obj#
    inner join
    dba_users blocker_user
        on blocker.user_id = blocker_user.user_id
    inner join
    dba_users blocked_user
        on blocked.user_id = blocked_user.user_id
    left outer join
    gv$sql blocked_sql
        on blocked_sql.sql_id = blocked.sql_id
        and blocked_sql.child_number = blocked.sql_child_number
    left outer join
    gv$sql blocker_sql
        on blocker_sql.sql_id = blocker.sql_id
        and blocker_sql.child_number = blocker.sql_child_number
where
	blocked.sample_time > sysdate -&days
and
    --blocked.event = 'enq: TX - row lock contention'
	blocked.event like 'enq: %'
	and blocked.TIME_WAITED > 0
group by
    --blocker.instance_number,
    --blocker.machine,
    --blocker.program,
    blocker.session_id,
	blocker.sql_id,
    blocker_user.username,
    ' -> ',
    --blocked.instance_number,
   -- blocked.machine,
   -- blocked.program,
    --blocked.session_id,
    blocked_user.username,
    --blocked.session_state,
    --blocked.event,
    --blocked.blocking_session,
    blocked.sql_id,
	blocked.time_waited,
    --blocked.sql_child_number,
    --sys_obj.name,
 /*   dbms_rowid.rowid_create(
        rowid_type    => 1,
        object_number => blocked.current_obj#,
        relative_fno  => blocked.current_file#,
        block_number  => blocked.current_block#,
        row_number    => blocked.current_row#
    ),*/
    blocker_sql.sql_text,
    blocked_sql.sql_text
order by
    first_sample_time,blocked.time_waited/1000000 ;