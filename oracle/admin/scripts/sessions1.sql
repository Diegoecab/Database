set pagesize 500
set linesize 120
col sid for 999
column piece noprint
column username format a16
column osuser format a10
break on sid 
--,serial#
-- or username
select s.sid, s.serial#, p.spid, s.username, t.piece, t.sql_text
from v$session s, v$sqltext t, v$process p
where s.username is not null
and p.addr=s.paddr
and s.status='ACTIVE'
and s.sql_address=t.address
and s.username like upper('&&1%')
order by 1,5
/
