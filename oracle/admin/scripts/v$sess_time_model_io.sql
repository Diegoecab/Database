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
col wait_class heading "Clase|Espera" for a8
col program heading "Programa" for a40
col osuser heading "Usuario|SO" for a13
col min heading "Tiempo|en|Minutos" for 99
col command_type heading "Tipo|de|Comando"
col username heading "Usuario"
col total_waits heading "Total|Waits"
set linesize 180
set feedback off
select  a.sid,
		b.program,
		b.osuser "osuser",
        b.username,
		decode(a.wait_class,'User I/O','U I/O','System I/O','S I/O') wait_class,
        a.total_waits,
		decode(c.command_type,2,'INSERT',3,'SELECT',6,'UPDATE',7,'DELETE',26,'LOCK TABLE',35,'ALTER DATABASE',42,'ALTER SESSION',
		44,'COMMIT',45,'ROLLBACK',46,'SAVEPOINT',47,'BEGIN/DECLARE',189,'MERGE',85,'TRUNCATE') command_type,
        round((a.time_waited / 100)/60,1) min
from    sys.v_$session_wait_class a,
        sys.v_$session b,
		sys.v_$sqlarea c
where   b.sid = a.sid and
        b.username is not null and
        a.wait_class like '%I/O' and
		c.sql_id=b.sql_id
order by 8;