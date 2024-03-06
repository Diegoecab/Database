--v$sess_io
col os_user for a15
set pagesize 50

select	nvl(ses.USERNAME,'ORACLE PROC') username,
	OSUSER os_user,
	PROCESS pid,
	ses.SID sid,
	SERIAL#,
	PHYSICAL_READS,
	BLOCK_GETS,
	CONSISTENT_GETS,
	BLOCK_CHANGES--,
--	CONSISTENT_CHANGES
from	v$session ses, 
	v$sess_io sio
where 	ses.SID = sio.SID
order 	by PHYSICAL_READS, ses.USERNAME;