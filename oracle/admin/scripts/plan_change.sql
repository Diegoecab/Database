--plan_change.sql

-- +----------------------------------------------------------------------------+
-- |                          Diego Cabrera	                                    |
-- |                      diego.ecab@gmail.com	                                |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 2020 Diego Cabrera	   . All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : plan_change.sql                           |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : This SQL script provides a list of sqlid which changed their execution plan |
-- | VERSION  : 1.2                        |
-- | USAGE    :                                                                 |
-- |                                                                            |
-- |@plan_change.sql 1 1 10080   			| (7 días)
--|	
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+



define DiffPerc=&1
define DiffSec=&2
define minutes=&3


REM  ******************************************************************************************************************
REM 
REM  ********************  SQL executed over last &minutes minutes which chanched their plans 
REM  ********************    and now takes more than &DiffPerc% and &DiffSec seconds of elapsed time and also the AVG Rows processed < (+&DiffPerc%)
REM 
REM  ******************************************************************************************************************

set lines 280
set verify off
col min_time_exec_plan for a25
col last_time_exec_plan for a25
col avg_et_secs heading 'Avg|Secs' for 999999.9999999
col diff_avg_et_secs_from_min heading 'Diff|Avg|ET Secs|From|Min'
col avg_et_secs_pct_from_min heading 'Pct|Avg|ET Secs|From|Min'
col avg_rows heading 'Avg|Rows'
col min_rows heading 'Min|Rows'
col max_rows heading 'Max|Rows'
col diff_avg_rows_from_min heading 'Diff|Avg|Rows|From|Min'
col avg_rows_pct_from_min heading 'Pct|Avg|Rows|From|Min'
col avg_rows_per_sec for 999999.999 heading 'Avg|Rows|per|Sec'
col sum_execs heading 'Sum|Execs' for 9999999
col sum_end_of_fetch_count heading 'Sum|Fetch|count' for 9999999
col Offload heading 'Off|Load'
col avg_pio heading 'Avg|Pio' for 9999999999
col avg_lio heading 'Avg|Lio' for 99999999
col avg_px heading 'Avg|Px' for 999
col avg_invalidations heading 'Avg|Inva|lida|tions' for 999
col sql_profile for a4 heading 'SQL|Prof|ile'



WITH
p AS ( --Distintos planes de ejecucion en MEM y AWR
SELECT sql_id, plan_hash_value
  FROM gv$sql_plan
 WHERE --sql_id = '&1'
   --AND 
   other_xml IS NOT NULL
 UNION
SELECT sql_id, plan_hash_value
  FROM dba_hist_sql_plan
 WHERE --sql_id = '&1'
   --AND 
   other_xml IS NOT NULL ),
m AS ( -- avg_et_secs y avg_rows por plan en MEM
SELECT sql_id, plan_hash_value,
	   SUM(elapsed_time)/SUM(executions) avg_et_secs,
	   SUM(rows_processed)/SUM(executions) avg_rows
  FROM gv$sql
 WHERE --sql_id = '&1'
   --AND 
   executions > 0
 GROUP BY
	   sql_id, plan_hash_value ),
a AS (-- avg_et_secs y avg_rows por plan en AWR
SELECT sql_id, plan_hash_value,
	   SUM(elapsed_time_total)/SUM(executions_total) avg_et_secs,
	   SUM(rows_processed_total)/SUM(executions_total) avg_rows
  FROM dba_hist_sqlstat
 WHERE --sql_id = '&1'
   --AND 
   executions_total > 0
 GROUP BY
	   sql_id, plan_hash_value ),
total as (
SELECT p.sql_id, p.plan_hash_value,
	   (NVL(m.avg_et_secs, a.avg_et_secs)/1e6) avg_et_secs,
		(a.avg_rows+(NVL(m.avg_rows, a.avg_rows)))/2 avg_rows --Suma avg rows memoria + awr /2
	   --(NVL(m.avg_rows, a.avg_rows)) avg_rows
  FROM p, m, a
 WHERE 
	--p.sql_id in (select distinct sql_id from gv$sql where last_active_time>sysdate+(1/1440*-&3) --and sql_id in (select sql_id from gv$sql_monitor where status='EXECUTING')
	--)
   --AND 
   p.sql_id = m.sql_id(+)
   AND p.sql_id = a.sql_id(+)
   AND p.plan_hash_value = m.plan_hash_value(+)
   AND p.plan_hash_value = a.plan_hash_value(+)
 ORDER BY avg_et_secs NULLS LAST
),
current_sqlid as (
select /*+ materialize */ distinct sql_id 
from
gv$sql where last_active_time>sysdate+(1/1440*-&3) --and sql_id in (select sql_id from gv$sql_monitor where status='EXECUTING')
)
select * from (
select sql_id,count(plan_hash_value) phv_cnt,(min(avg_rows_per_sec)),(max(avg_rows_per_sec)),round(((100*max(avg_rows_per_sec))/min(avg_rows_per_sec))-100) avg_rows_per_sec_pct, 
(min(avg_et_secs)),(max(avg_et_secs)),
min(first_seen_current_phv) first_seen_current_phv,
(max(avg_et_secs))-(min(avg_et_secs)) diff_secs,
round((100*max(avg_et_secs))/min(avg_et_secs))-100 avg_et_secs_pct,
avg(sum_execs),
max(worst_phv) worst_phv,
max(best_phv) best_phv,
(select max(plan_hash_value) from (select plan_hash_value,DENSE_RANK ()  OVER (ORDER BY last_active_time desc) rw from gv$sql z where z.sql_id=sql_id and z.plan_hash_value <> 0 and z.plan_hash_value is not null) where rw=1) current_phv
from(
select /*+ LEADING(a) USE_HASH(total) */ a.sql_id, total.plan_hash_value,
 round(avg_rows-(select min(total.avg_rows) from total)) diff_avg_rows_from_min, 
 round((total.avg_rows*100/(select decode(min(total.avg_rows),0,0.99999,min(total.avg_rows)) from total))-100,1)  avg_rows_pct_from_min,
 avg_rows/(decode(avg_et_secs,0,0.99999,avg_et_secs)) avg_rows_per_sec,
 avg_et_secs,
 (select min(begin_interval_time) from 
	(select begin_interval_time from dba_hist_snapshot h where h.snap_id = (select min(snap_id) from dba_hist_sqlstat z wHERE z.sql_id = sql_id and z.plan_hash_value=plan_hash_value)
	 union
	 select last_active_time begin_interval_time from gv$sql z where z.sql_id = sql_id and z.plan_hash_value=plan_hash_value
	)
) as first_seen_current_phv,
 nvl((select SUM(executions_total) from dba_hist_sqlstat t where t.sql_id = sql_id and t.plan_hash_value=plan_hash_value and executions_delta=0), 
			(select min(min_executions_total)-min(min_executions_delta) from (select MIN(executions_total) keep  (DENSE_RANK FIRST ORDER BY EXECUTIONS_TOTAL) OVER () min_executions_total, MIN(executions_delta) keep  (DENSE_RANK FIRST ORDER BY EXECUTIONS_TOTAL) OVER () min_executions_delta from dba_hist_sqlstat z where z.sql_id = sql_id and z.plan_hash_value=plan_hash_value)) )+ --Min(executions_total)(-su executions_delta) en caso que no se haya registrado el total con executions_delta=0
	(select SUM(executions_delta) from dba_hist_sqlstat z where z.sql_id = sql_id and z.plan_hash_value=plan_hash_value) sum_execs,
	(select (plan_hash_value) from (select plan_hash_value, DENSE_RANK ()  OVER (ORDER BY avg_rows/(decode(avg_et_secs,0,0.99999,avg_et_secs))) rw from total h where sql_id = h.sql_id) where rw=1 and rownum=1) worst_phv,
	(select (plan_hash_value) from (select plan_hash_value, DENSE_RANK ()  OVER (ORDER BY avg_rows/(decode(avg_et_secs,0,0.99999,avg_et_secs)) desc) rw from total h where sql_id = h.sql_id) where rw=1 and rownum=1) best_phv
 from current_sqlid a, total where total.sql_id=a.sql_id
 ) k where avg_rows_per_sec is not null and avg_rows_per_sec <> 0
 and sum_execs is not null and sum_execs>0
 group by sql_id having count(plan_hash_value) > 1
 order by (100*max(avg_rows_per_sec))/min(avg_rows_per_sec) --AVG_ROWS_PER_SEC_PCT
 ) where current_phv = worst_phv --Plan actual es el peor en base a avg_rows_per_sec_pct
 and avg_rows_per_sec_pct > &1
 and diff_secs > &2
 and first_seen_current_phv > sysdate+(1/1440*-&3) --Es un nuevo plan
 --and AVG_ET_SECS_PCT > 100
 /