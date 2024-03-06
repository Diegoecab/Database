--v$rsrcmgrmetric_history
prompt Monitor CPU Usage and Waits by Consumer Group
prompt
prompt The query below shows, for each consumer group, the average number of sessions running (avg_running) and waiting for CPU (avg_waiting) per minute 
prompt for the past hour. The resource allocation specified in the resource plan (allocation) is expressed as the average number of sessions that the consumer group
prompt  can be guaranteed to run. In this example, the server has 16 CPUs which means that a maximum of 16 sessions can run at any time. Since Interactive has a 
prompt  resource allocation of 35% (mgmt_p1 = 35), its allocation is 35% of 16 = 5.6, which means that 5.6 of its sessions are guaranteed to run at any time.
prompt 
prompt Note that the "allocation" data is only valid for single-level plans.  For multi-level plans, calculating the allocation is more complicated so it 
prompt is not included here.  We strongly recommend using single-level plans.
select to_char(m.begin_time, 'HH:MI') time, m.consumer_group_name, m.cpu_consumed_time / 60000 avg_running_sessions, m.cpu_wait_time / 60000 avg_waiting_sessions, d.mgmt_p1*(select value from v$parameter where name = 'cpu_count')/100 allocation from v$rsrcmgrmetric_history m, dba_rsrc_plan_directives d, v$rsrc_plan p where m.consumer_group_name = d.group_or_subplan and p.name = d.plan order by m.begin_time, m.consumer_group_name;