--------------------------------------------------------------------------------
-- 
-- File name:   aash.sql v1.0
-- Purpose:     Display Average active session (historyc view) for an specific interval time and it status based on  cpu_count
--              
-- Author:      Diego Cabrera
-- Copyright:   
--              
-- Usage:       
--     @ash/aash <grouping_cols> <filters> <fromtime> <totime>
--
-- Example:
--	
--     @ash/aash "TO_CHAR(sample_time,'DD-MM-YY,HH24')" "wait_class like '%I/O'" trunc(sysdate) sysdate
-- @ash/aash "TO_CHAR(sample_time,'DD-MM-YY,HH24')" 1=1 trunc(sysdate-30) sysdate
--		@ash/aash "TO_CHAR(sample_time,'YY-MM-DD')" "wait_class like '%I/O' and username='EDW_PROD_LOADER'" sysdate-15 sysdate
--		@ash/aash "TO_CHAR(sample_time,'DD-MM-YY,HH24')" "wait_class like '%I/O'" sysdate-30 sysdate
--		@ash/aash "TO_CHAR(sample_time,'DD-MM-YY,HH24')" "TO_CHAR(sample_time,'HH24') between 9 and 16" sysdate-30 sysdate
--		@ash/aash "TO_CHAR(sample_time,'DD-MM-YY,HH24')" 1=1 trunc(sysdate-1) sysdate
--     @ash/aash TO_CHAR(sample_time,'DD-MM-YY') 1=1 to_date('06-08-20:09:00','DD-MM-YY:HH24:MI') to_date('06-08-20:15:00','DD-MM-YY:HH24:MI')
--	   @ash/aash inst_id,"TO_CHAR(sample_time,'DD-MM-YY HH')" inst_id=1 to_date('20-08-20:09:00','DD-MM-YY:HH24:MI') to_date('20-08-20:15:00','DD-MM-YY:HH24:MI')
--	 @ash/aash "TO_CHAR(sample_time,'DD-MM-YY')" "TO_CHAR(sample_time, 'DAY') = TO_CHAR(sysdate, 'DAY') and TO_CHAR(sample_time, 'HH24') between TO_CHAR(sysdate, 'HH24')-2 and TO_CHAR(sysdate, 'HH24')" sysdate-30 sysdate
--
--

col cpu_count			FOR 999
set lines 350
set pages 10000
set verify off
col begin_interval_time for a25
col end_interval_time for a25
col min_sample_time for a30
col WAIT_CLASS_1 for a20 truncate
col WAIT_CLASS_2 for a20 truncate
col event_1 for a30 truncate
col event_2 for a30 truncate
col BEGIN_INTERVAL_TIME2 for a15 truncate
col END_INTERVAL_TIME2 for a15 truncate


select * from (
select b.*, (
SELECT decode(wait_class,null,'CPU',wait_class)||':'||"%This" FROM (
SELECT
    h.*,DENSE_RANK ()  OVER (ORDER BY TotalSeconds DESC) rw ,ROWNUM rn
FROM (
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)*10                                                     totalseconds
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , wait_class
    FROM
        (SELECT
             a.*
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a) a
    WHERE
    sample_time BETWEEN b.begin_interval_time AND b.end_interval_time
    GROUP BY
         wait_class
    ORDER BY
        TotalSeconds DESC
) h
WHERE
    ROWNUM <= 15
    ORDER BY
        TotalSeconds DESC
)
WHERE rw=1 and rn=1
) wait_class_1,
(
SELECT decode(event,null,'CPU',event)||':'||"%This" FROM (
SELECT
    h.*,DENSE_RANK ()  OVER (ORDER BY TotalSeconds DESC) rw ,ROWNUM rn
FROM (
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)*10                                                     totalseconds
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , event
    FROM
        (SELECT
             a.*
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a) a
    WHERE
    sample_time BETWEEN b.begin_interval_time AND b.end_interval_time
    GROUP BY
         event
    ORDER BY
        TotalSeconds DESC
) h
WHERE
    ROWNUM <= 15
    ORDER BY
        TotalSeconds DESC
)
WHERE rw=1 and rn=1
) event_1,
(
SELECT decode(wait_class,null,'CPU',wait_class)||':'||"%This" FROM (
SELECT
    h.*,DENSE_RANK ()  OVER (ORDER BY TotalSeconds DESC) rw ,ROWNUM rn
FROM (
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)*10                                                     totalseconds
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , wait_class
    FROM
        (SELECT
             a.*
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a) a
    WHERE
    sample_time BETWEEN b.begin_interval_time AND b.end_interval_time
    GROUP BY
         wait_class
    ORDER BY
        TotalSeconds DESC
) h
WHERE
    ROWNUM <= 15
    ORDER BY
        TotalSeconds DESC
)
WHERE rw=2 and rn=2
) wait_class_2,
(
SELECT decode(event,null,'CPU',event)||':'||"%This" FROM (
SELECT
    h.*,DENSE_RANK ()  OVER (ORDER BY TotalSeconds DESC) rw ,ROWNUM rn
FROM (
    SELECT /*+ LEADING(a) USE_HASH(u) */
        COUNT(*)*10                                                     totalseconds
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , event
    FROM
        (SELECT
             a.*
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a) a
    WHERE
    sample_time BETWEEN b.begin_interval_time AND b.end_interval_time
    GROUP BY
         event
    ORDER BY
        TotalSeconds DESC
) h
WHERE
    ROWNUM <= 15
    ORDER BY
        TotalSeconds DESC
)
WHERE rw=2 and rn=2
) event_2,
round(AAS*100/cpu_count,1) aas_pct, case when (AAS*100/cpu_count) < 80 then 'OK' when (AAS*100/cpu_count) between 80 and 100 then 'WARNING' else 'CRITICAL' end status
from (
with cpu_count as (
( select to_number(value) cpu_count from v$parameter where name='cpu_count')
)
select a.*, cpu_count.cpu_count as cpu_count,
( CNT / ((CAST(end_interval_time AS DATE) - CAST(begin_interval_time AS DATE)) * 86400)) as AAS,
TO_CHAR(begin_interval_time, 'YYYY-MM-DD HH24:MI:SS') as begin_interval_time2, TO_CHAR(end_interval_time, 'YYYY-MM-DD HH24:MI:SS') as end_interval_time2
from (
select  &1, MIN(sample_time) min_sample_time, MIN(sample_time) as begin_interval_time,  MAX(sample_time) as end_interval_time,
 ( 10 * (COUNT(*))) as CNT
 from 
 (SELECT
             a.*
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a)
 a, dba_users u
where  a.user_id = u.user_id (+) and sample_time BETWEEN &3 AND &4
AND &2
group by &1
order by min_sample_time) a, 
cpu_count where
 ((CAST(end_interval_time AS DATE) - CAST(begin_interval_time AS DATE)) * 86400) <> 0 order by a.min_sample_time) b
);