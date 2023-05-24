--active_session_history_wait 10
set verify off
set lines 260
set pages 1000
set feed off
col username for a12 TRUNCATE
col sql_text for a30 TRUNCATE
col wait_class for a15 TRUNCATE
col wait_name for a40 TRUNCATE
COL inst_id heading 'Inst|ID' for 9
col session_serial# heading 'ser|ial#' for 99999
col session_id heading 'sess|ID' for 99999
col TOT_WAIT_TIME for 99999999999
col sample_time for a30


select * 
 from (select  h.session_id,h.session_serial#,h.inst_id,
   u.username,
   sql.sql_id,
   sql.sql_text,
   e.wait_class,
   e.name wait_name,
   event,
   sum(h.wait_time + h.time_waited) "TOT_WAIT_TIME"
from gv$active_session_history h,
  v$sqlarea sql,
  dba_users u,
  v$event_name e 
WHERE
 h.sql_id = sql.sql_id
 and e.event_id=h.event_id
 AND h.user_id = u.user_id
         and h.session_state='WAITING'
           and sample_time >  sysdate - interval '&1' minute
		 group by h.session_id,h.session_serial#,h.inst_id,
   u.username,
   sql.sql_id,
   sql.sql_text,
   e.wait_class,
   e.name,
   event
         order by sum(h.wait_time + h.time_waited) desc
       )
where rownum <= 15;
/*

select * from (
select  h.inst_id,
   e.wait_class,
   e.name wait_name,
   sum(h.wait_time + h.time_waited) "TOT_WAIT_TIME"
from gv$active_session_history h,
  v$sqlarea sql,
  v$event_name e 
WHERE
 h.sql_id = sql.sql_id
 and e.event_id=h.event_id
         and h.session_state='WAITING'  
           and sample_time >  sysdate - interval '&1' minute
group by h.inst_id,
   e.wait_class,
   e.name
         order by sum(h.wait_time + h.time_waited) desc
)
where rownum <= 15;
*/