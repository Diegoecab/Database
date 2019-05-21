--similar_sql.sql
col sql for a85
SET lines 140 pages 55 verify off feedback off
COL num_of_times heading 'Number|Of|Repeats'
--COL SQL heading 'SubString - &&chars Characters'
COL username format a15 heading 'User'
ttitle 'Similar SQL'
--SPOOL rep_out\&db\similar_sql&&chars
SELECT   b.username, a.sql_text SQL,
         COUNT (a.sql_text) num_of_times
    FROM v$sqlarea a, dba_users b
   WHERE a.parsing_user_id = b.user_id
GROUP BY b.username, a.sql_text
  HAVING COUNT (a.sql_text) > &&num_repeats
ORDER BY COUNT (a.sql_text) DESC
/
--SPOOL off
UNDEF chars
UNDEF num_repeats
CLEAR columns
SET lines 80 pages 22 verify on feedback on
TTITLE off