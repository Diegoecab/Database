--dba_hist_active_sess_history.sql
select a.sample_time,   
       a.sql_opname,   
       a.sql_exec_start,   
       a.program,   
       a.client_id,   
       b.sql_text,   
  (case when c.executions_delta > 0 then c.elapsed_time_delta/ c.executions_delta/ 1000000 else 0 end) seconds_per_exe,  
 e.username  
  from dba_hist_active_sess_history a  
      join dba_hist_sqltext b on (a.sql_id = b.sql_id)  
 join dba_users e on (a.user_id = e.user_id)  
       left outer join dba_hist_sqlstat c on (a.sql_id = c.sql_id)  
       left outer join dba_hist_snapshot d on (c.snap_id = d.snap_id and   
                                                               c.dbid = d.dbid and   
                                                               c.instance_number = d.instance_number and  
 a.sample_time between d.begin_interval_time and d.end_interval_time)
and upper(b.sql_text) like  ()
/