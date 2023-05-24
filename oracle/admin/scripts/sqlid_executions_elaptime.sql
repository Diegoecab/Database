--sqlid_executions_elaptime.sql
set lines 400
set pages 10000
col username for a20 truncate
col program for a20 truncate
col duration_sec for 999999
col duration_hrs for 999999

select query_runs.*,
                round ( (end_time - start_time) * 24, 2) as duration_hrs,
				round ( (end_time - start_time) * 24 * 60 * 60, 2) as duration_sec
           from (  select u.username,
                          ash.program,
                          ash.sql_id,
                          ash.sql_plan_hash_value as plan_hash_value,
                          ash.session_id as sess#,
                          ash.session_serial# as sess_ser,
                          cast (min (ash.sample_time) as date) as start_time,
                          cast (max (ash.sample_time) as date) as end_time
                     from dba_hist_active_sess_history ash, dba_users u
                    where u.user_id = ash.user_id and (ash.sql_id = lower(trim('&sql_id'))) or upper(u.username) like upper('%&username%')
                 group by u.username,
                          ash.program,
                          ash.sql_id,
                          ash.sql_plan_hash_value,
                          ash.session_id,
                          ash.session_serial#) query_runs
						  where start_time > sysdate- &sysdaten
						  and ((end_time - start_time) * 24 * 60 * 60) > &duration_sec_min
order by ((end_time - start_time) * 24 * 60 * 60);