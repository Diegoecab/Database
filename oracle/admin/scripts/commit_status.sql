SELECT SYSDATE FROM DUAL;

select value,sid from v$sesstat
where sid in (select sid
from v$session where username = upper('&1'))
and statistic# in (select statistic#
from v$statname where name like '%user%commit%')
/

select used_ublk, used_urec 
from v$transaction where ADDR in ( select taddr from v$session where username = upper('&1'))
/

--@active_session_waits (o waits)

@session_undo (o undo)
@iduser datastage

-- select count(*) from schema.table;