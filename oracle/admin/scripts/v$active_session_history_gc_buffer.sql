set lines 900
col event for a30
set pages 100
select sample_time,  sql_id, event, current_obj#,count (*)  from  gv$active_session_history
   where sample_time between  sysdate -1 and
     sysdate
and event like '%gc buffer%'
    group by  sample_time,  sql_id, event, current_obj#
   order by sample_time
/