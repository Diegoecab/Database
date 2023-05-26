--------------------------------------------------------------------------------
--ashtop_peaks.sql
--ash/ashtop_peaks.sql 10
--ashtop_peaks.sql <pct>
-- AAS = load on the database = DB Time/elapsed ~ = count(*)/elapsed
--------------------------------------------------------------------------------
COL "%This" FOR A7
COL PCT FOR 999

COL AAS                 FOR 9999.9
COL totalseconds HEAD "Tot|Sec" FOR 999999
COL dist_sqlexec_seen HEAD "Dis|tin|ct|Execs|Seen" FOR 999999
COL event               FOR A30 TRUNCATE
COL username            FOR A25 TRUNCATE
COL wait_class          FOR A15
set lines 350
set pages 10000
col FIRST_SEEN for a20
col LAST_SEEN for a20
set verify off


SELECT * FROM (
SELECT
    h.*
FROM (
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)                                                     totalseconds
      , ROUND(COUNT(*) / ((CAST(sysdate AS DATE) - CAST(sysdate+(1/1440*-60) AS DATE)) * 86400), 1) AAS
	  , ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100) PCT
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , session_type,session_state,wait_class,event,username
      , TO_CHAR(MIN(sample_time), 'YYYY-MM-DD HH24:MI:SS') first_seen
      , TO_CHAR(MAX(sample_time), 'YYYY-MM-DD HH24:MI:SS') last_seen
      , COUNT(DISTINCT sql_exec_start||':'||sql_exec_id) dist_sqlexec_seen
    FROM
        (SELECT
             a.*
        FROM gv$active_session_history a) a
      , dba_users u
    WHERE
        a.user_id = u.user_id (+)
    AND sample_time BETWEEN sysdate+(1/1440*-60) AND sysdate
    GROUP BY
        session_type,session_state,wait_class,event,username
    ORDER BY
        TotalSeconds DESC
       , session_type,session_state,wait_class,event,username
) h
WHERE
    ROWNUM <= 15
    ORDER BY
        TotalSeconds DESC
       , session_type,session_state,wait_class,event,username
)
	where --session_state='WAITING'
	--and 
	wait_class not in ('User I/O')
	and event not in ('SQL*Net message from dblink','SQL*Net more data from dblink','SQL*Net more data to client')
	and session_type ='FOREGROUND'
	and (username <> 'SYS' and username not like 'OGG%')
	--and pct > &1
	;