SET LINESIZE 500
SET PAGESIZE 1000
SET FEEDBACK OFF
SET VERIFY OFF
col sql_text for a64
set long 900

SELECT a.sql_text
FROM   v$sqltext_with_newlines a
WHERE  a.sql_id = '&sqlid' --a.address = UPPER('&&1')
ORDER BY a.piece;


select sql_fulltext from v$sql where sql_id='&sqlid';

PROMPT
SET PAGESIZE 14
SET FEEDBACK ON