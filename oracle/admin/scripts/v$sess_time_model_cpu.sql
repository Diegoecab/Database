--estad_v$sess_time_model.sql
/*
Insert 2
Select 3
Update 6
Delete 7
Lock Table 26
Alter Database 35
Alter Session 42
Commit 44
Rollback 45
Savepoint 46
Begin/Declare 47
*/
col sql_text for a60
select  a.sid,
		b.osuser,
        b.username,
        a.total_waits,
		decode(c.command_type,2,'INSERT',3,'SELECT',6,'UPDATE',7,'DELETE',26,'LOCK TABLE',35,'ALTER DATABASE',42,'ALTER SESSION',
		44,'COMMIT',45,'ROLLBACK',46,'SAVEPOINT',47,'BEGIN/DECLARE',189,'MERGE') command_type,
        round((a.time_waited / 100)/60,1) time_waited_min
from    sys.v_$session_wait_class a,
        sys.v_$session b,
		sys.v_$sqlarea c
where   b.sid = a.sid and
        b.username is not null and
        a.wait_class = 'User I/O' and
		c.sql_id=b.sql_id
order by 6;