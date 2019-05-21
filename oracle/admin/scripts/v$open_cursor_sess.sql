--v$open_cursor_sess
col statement for a65
col module for a10
set pagesize 50
col username for a10
SELECT username,
SUBSTR(machine,1,10) "Machine",
sharable_mem, persistent_mem,
runtime_mem, executions, v$sql.module,
SUBSTR(v$sql.sql_text,1,60) "Statement"
FROM   v$session, v$sql, v$open_cursor
WHERE  v$open_cursor.saddr   = v$session.saddr
AND    v$open_cursor.address = v$sql.address
and rownum < 50
ORDER BY SUBSTR(USERNAME,1,10), SUBSTR(machine,1,10);