--------------------------------------------------------------------------------
--ashtoph_by_hour_username.sql
--@ash/ashtoph_by_hour_username.sql <fromtime> <totime>
--@ash/ashtoph_by_hour_username.sql trunc(sysdate-1) sysdate
--@ash/ashtoph_by_hour_username.sql to_date('06-08-20:13:00','DD-MM-YY:HH24:MI') to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
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
set colsep ,
set headsep off
set pagesize 0
set trimspool on


with ashtop as (
SELECT * FROM (
SELECT
    h.*
FROM (
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)                                                     totalseconds
      , ROUND(COUNT(*) / ((CAST(sysdate AS DATE) - CAST(sysdate+(1/1440*-60) AS DATE)) * 86400), 1) AAS
	  , ROUND(RATIO_TO_REPORT(COUNT(*)) OVER (Partition by TO_CHAR(sample_time, 'DD-MM-YY HH24')) * 100) PCT
	  , ROUND(RATIO_TO_REPORT(COUNT(*)) OVER (Partition by TO_CHAR(sample_time, 'DD-MM-YY HH24'), username) * 100) "%User"
      , session_state,username
      , TO_CHAR(sample_time, 'DD-MM-YY HH24') as sample_time
    FROM
        (SELECT
             a.*
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a) a
      , dba_users u
    WHERE
        a.user_id = u.user_id (+)
    AND sample_time BETWEEN &1 and &2
    GROUP BY
        TO_CHAR(sample_time, 'DD-MM-YY HH24'),username,session_state
    ORDER BY
       sample_time,username
) h
)
)
select * from ashtop
pivot (
 sum("%User") 
  for session_state in ('ON CPU','WAITING')
)