--------------------------------------------------------------------------------
--ashtoph_by_username.sql
--@ash/ashtoph_by_username.sql <fromtime> <totime>
--@ash/ashtoph_by_username.sql trunc(sysdate-1) sysdate
--@ash/ashtoph_by_username.sql sysdate+(1/1440*-60) sysdate
--@ash/ashtoph_by_username.sql to_date('06-08-20:09:00','DD-MM-YY:HH24:MI') to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
--@ash/ashtoph_by_username.sql to_date('19-08-20:09:00','DD-MM-YY:HH24:MI') to_date('19-08-20:15:00','DD-MM-YY:HH24:MI')
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

with ashtop as (
SELECT * FROM (
SELECT
    h.*
FROM (
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)                                                     totalseconds
      , ROUND(COUNT(*) / ((CAST(sysdate AS DATE) - CAST(sysdate+(1/1440*-60) AS DATE)) * 86400), 1) AAS
	  , ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100) PCT
	  , ROUND(RATIO_TO_REPORT(COUNT(*)) OVER (Partition by username) * 100) "%User"
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , session_state,username
      , TO_CHAR(MIN(sample_time), 'YYYY-MM-DD HH24:MI:SS') first_seen
      , TO_CHAR(MAX(sample_time), 'YYYY-MM-DD HH24:MI:SS') last_seen
      , COUNT(DISTINCT sql_exec_start||':'||sql_exec_id) dist_sqlexec_seen
    FROM
        (SELECT
             a.*
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a) a
      , dba_users u
    WHERE
        a.user_id = u.user_id (+)
    AND sample_time BETWEEN &1 and &2
    GROUP BY
        username,session_state
    ORDER BY
        TotalSeconds DESC
       , session_state,username
) h
WHERE
    ROWNUM <= 15
    ORDER BY
        TotalSeconds DESC
       , session_state,username
)
)
select distinct a.username, (select PCT from ashtop where session_state='WAITING' and username=a.username) Pct_of_This, (select "%User" from ashtop where session_state='WAITING' and username=a.username) WAITING_PCT, (select "%User" from ashtop where session_state='ON CPU' and username=a.username) CPU_PCT
from ashtop a order by Pct_of_This desc nulls last,WAITING_PCT 
;