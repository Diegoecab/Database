ttitle off
prompt Verify that managed recovery is running
select process,status, delay_mins, active_agents,thread#, sequence# from
v$managed_standby
/