col sid for 999
col sql_text for a40
col osuser for a15
col username for a15
col program for a20
set pagesize 1000
SELECT s.SID,s.username,s.process, s.osuser, a.sql_text, p.program
  FROM v$session s, v$sqlarea a, v$process p
WHERE s.sql_hash_value = a.hash_value
   AND s.sql_address = a.address
   AND s.paddr = p.addr
   AND s.status = 'ACTIVE'
/

col sql_text for a80
select sql_hash_value, sql_text, count(*) from v$session a, v$sql b
where b.hash_value=a.sql_hash_value and status = 'ACTIVE' group by sql_hash_value,sql_text order by 3;