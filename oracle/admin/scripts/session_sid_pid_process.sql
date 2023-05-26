--session_sid_pid_process
Set lines 200
col sid format 99999
col username format a15
col osuser format a15
col machine for a40 truncate
col program for a60 truncate
select a.username, a.machine, a.program, a.sid, a.serial#,a.username, a.osuser, b.spid
from gv$session a, gv$process b
where a.paddr= b.addr
and a.inst_id=b.inst_id
and a.sid='&sid'
and a.serial#='&serial'
order by a.sid;