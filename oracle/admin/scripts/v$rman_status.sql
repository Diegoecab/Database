--v$rman_status

select * from v$rman_status
where operation like upper('%&operation%')
and status like upper('%&status%')
order by start_time
/

prompt Para ver detalles, ver v$rman_output where session_stamp=....