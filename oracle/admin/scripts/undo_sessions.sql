--undo_sessions.sql

clear col

PROMPT
PROMPT DOC> Script para ver los segmentos, el estado y usuarios usando de un tablespace de UNDO 
PROMPT DOC> por default de la base de datos
PROMPT

column username format a15
col mb for 999999
col sql_text for a50
col sid for 9999

set feedback off

SELECT a.name,b.status , b.extents,d.username , d.sid , d.serial#, d.inst_id,( SELECT round(sum(bytes)/1024/1024)
		  FROM dba_segments 
		  WHERE tablespace_name = upper((select value from v$parameter where name ='undo_tablespace')) and segment_name=a.name) MB
FROM   v$rollname a,v$rollstat b, v$transaction c , gv$session d
WHERE  a.usn = b.usn
AND    a.usn = c.xidusn
AND    c.ses_addr = d.saddr
AND    a.name IN (
		  SELECT segment_name
		  FROM dba_segments 
		  WHERE tablespace_name = upper((select value from v$parameter where name ='undo_tablespace'))
		 ) order by mb;

PROMPT
PROMPT Sesiones actuales con uso de undo + sql
PROMPT

SELECT DISTINCT h.session_id SID, s2.username,
                (SELECT MAX (b.used_urec)
                   FROM v$session a, v$transaction b
                  WHERE a.saddr = b.ses_addr) used_undo, s1.last_load_time,
                s1.sql_text, s1.rows_processed,
                ROUND (s1.elapsed_time / 1000000) seconds
           FROM v$active_session_history h, v$sqlarea s1, v$session s2
          WHERE h.sql_id = s1.sql_id
            AND h.session_id = s2.SID
            AND h.session_id in
                   (SELECT   a.SID
                        FROM v$session a, v$transaction b
                       WHERE a.saddr = b.ses_addr
                         AND b.used_urec = (SELECT MAX (used_urec)
                                              FROM v$transaction)
                    GROUP BY a.SID)
            AND UPPER (s1.sql_text) NOT LIKE 'SELECT%'
       ORDER BY s1.last_load_time;
	   
@dba_undo_extents

set feedback on