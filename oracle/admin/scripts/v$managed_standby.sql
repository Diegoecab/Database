ttitle off
select process,status, delay_mins, active_agents from
v$managed_standby
where process='LGWR'
/