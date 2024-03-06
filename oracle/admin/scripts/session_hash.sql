col rownum for 99
col event for a40
set linesize 180
accept HASH prompt 'Ingrese HASH: '
SELECT username,machine,program,status
  FROM v$session
 WHERE sql_hash_value = '&HASH'
 ORDER BY 1,2,3,4
 /