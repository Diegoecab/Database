--
-- Script to see active sessions history based on ASH view
--Author: Diego Cabrera <diego.cabrera@oracle.com>
--@sessions_db_active_hist "username not in ('SYS','SYSTEM','DTVDBSNMP') and tot_mins>600" sysdate-30 sysdate
--@sessions_db_active_hist "username is not null " to_date('03-08-21:19:00','DD-MM-YY:HH24:MI') to_date('03-08-21:21:00','DD-MM-YY:HH24:MI')
/*Note that
In v$active_session_history each ASH sample
represents 1 second.
In DBA_HIST_ACTIVE_SESS_HISTORY each ASH
sample represents 10 second.
*/

set verify off
set lines 300
col max_tot_mins for 9999
col module for a45 truncate
col program for a45 truncate
col username for a20 truncate



SELECT
   --instance_number, 
   ddhh,
   username, program, module, count(dist_sqlexec_seen) dist_sqlexec_seen, round(max(tot_mins)) max_tot_mins, count(*) cnt
FROM (
    SELECT /*+ LEADING(a) USE_HASH(u) */
        (COUNT(*)*10)/60   tot_mins,
      --instance_number,
	  TO_CHAR(sample_time,'YYYY-MM-DD HH24') ddhh,
   u.username,
   sid,
   serial,
   program,
   module--,
      , COUNT(DISTINCT sql_exec_start||':'||sql_exec_id) dist_sqlexec_seen
    FROM
        (SELECT
             a.*
           , session_id sid
           , session_serial# serial
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a) a
      , dba_users u
    WHERE
        a.user_id = u.user_id (+)
    AND sample_time BETWEEN &2 AND &3
    GROUP BY
   -- instance_number,
   TO_CHAR(sample_time,'YYYY-MM-DD HH24'),
   u.username,
   sid,
   serial,
   program,
   module
    ORDER BY
        tot_mins
) h
    where &1
group by -- instance_number, 
ddhh,
username, program, module
order by max(tot_mins)
/