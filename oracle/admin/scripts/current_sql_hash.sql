col sid for 999
col sql_text for a70
col osuser for a10
col username for a15
col program for a15
col machine for a20
set linesize 180
accept HASH prompt 'Ingrese HASH:  '
SELECT s.SID,s.username,s.machine,s.process, s.osuser, p.program,a.sql_text
  FROM v$session s, v$sqlarea a
WHERE s.sql_hash_value = a.hash_value
   AND s.sql_address = a.address
   AND s.paddr = p.addr
   AND s.SQL_HASH_VALUE='&HASH'
/
