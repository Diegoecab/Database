--plan_x_sqlid.sql

-- +----------------------------------------------------------------------------+
-- |                          Diego Cabrera	                                    |
-- |                      diego.ecab@gmail.com	                                |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 2020 Diego Cabrera	   . All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : plan_x_sqlid.sql                           |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : This SQL script provides a list of sqlid which changed their execution plan |
-- | VERSION  : 1.2                        |
-- | USAGE    :                                                                 |
-- |                                                                            |
-- |sqlplus -s <dba>/<password> @plan_x_sqlid.sql sqlid   			|
--|	
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+


prompt ******************************************************************************************************************
prompt
prompt AVG Time per plan for sqlid &1
prompt
prompt ******************************************************************************************************************
set lines 310
set pages 1000
col min_time_exec_plan for a25
col last_time_exec_plan for a25
col avg_et_secs heading 'Avg|Secs' for 999999.9999999
col diff_avg_et_secs_from_min heading 'Diff|Avg|ET Secs|From|Min'
col avg_et_secs_pct_from_min heading 'Pct|Avg|ET Secs|From|Min'
col avg_rows heading 'Avg|Rows' for 9999999
col min_rows heading 'Min|Rows' for 9999999
col max_rows heading 'Max|Rows' for 9999999
col diff_avg_rows_from_min heading 'Diff|Avg|Rows|From|Min'
col avg_rows_pct_from_min heading 'Pct|Avg|Rows|From|Min'
col avg_rows_per_sec for 999999.999999 heading 'Avg|Rows|per|Sec'
col sum_execs heading 'Sum|Execs' for 9999999
col sum_end_of_fetch_count heading 'Sum|Fetch|count' for 9999999
col Offload heading 'Off|Load' for a4
col avg_pio heading 'Avg|Pio' for 9999999999
col avg_lio heading 'Avg|Lio' for 99999999
col avg_px heading 'Avg|Px' for 999
col avg_invalidations heading 'Avg|Inva|lida|tions' for 999
col sql_profile for a4 heading 'SQL|Prof|ile'
col "|" for a1



WITH
p AS ( --Distintos planes de ejecucion en MEM y AWR
SELECT sql_id, plan_hash_value
  FROM gv$sql_plan
 WHERE sql_id = '&1'
   AND other_xml IS NOT NULL
 UNION
SELECT sql_id, plan_hash_value
  FROM dba_hist_sql_plan
 WHERE sql_id = '&1'
   AND other_xml IS NOT NULL ),
m AS ( -- avg_et_secs y avg_rows por plan en MEM
SELECT sql_id, plan_hash_value,
	   SUM(elapsed_time)/SUM(executions) avg_et_secs,
	   SUM(rows_processed)/SUM(executions) avg_rows
  FROM gv$sql
 WHERE sql_id = '&1'
   AND executions > 0
 GROUP BY
	   sql_id, plan_hash_value ),
a AS (-- avg_et_secs y avg_rows por plan en AWR
SELECT sql_id, plan_hash_value,
	   SUM(elapsed_time_total)/SUM(executions_total) avg_et_secs,
	   SUM(rows_processed_total)/SUM(executions_total) avg_rows
  FROM dba_hist_sqlstat
 WHERE sql_id = '&1'
   AND executions_total > 0
 GROUP BY
	   sql_id, plan_hash_value ),
total as (
SELECT p.sql_id, p.plan_hash_value,
	   (NVL(m.avg_et_secs, a.avg_et_secs)/1e6) avg_et_secs,
		(a.avg_rows+(NVL(m.avg_rows, a.avg_rows)))/2 avg_rows --Suma avg rows memoria + awr /2
	   --(NVL(m.avg_rows, a.avg_rows)) avg_rows
  FROM p, m, a
 WHERE p.plan_hash_value = m.plan_hash_value(+)
   AND p.plan_hash_value = a.plan_hash_value(+)
 ORDER BY avg_et_secs NULLS LAST
),
last_exec as
(select sql_id, max(begin_interval_time) begin_interval_time from 
	(select sql_id, begin_interval_time from dba_hist_snapshot h, dba_hist_sqlstat z where z.snap_id=h.snap_id and sql_id = '&1' and h.snap_id = (select max(snap_id) from dba_hist_sqlstat wHERE sql_id = '&1')
	 union
	 select sql_id, last_active_time begin_interval_time from gv$sql where sql_id = '&1' --In Memory
	) group by sql_id
)
select total.sql_id, total.plan_hash_value,  
	nvl((select SUM(executions_total) from dba_hist_sqlstat where sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and executions_delta=0), (select min(min_executions_total)-min(min_executions_delta) from (select MIN(executions_total) keep  (DENSE_RANK FIRST ORDER BY EXECUTIONS_TOTAL) OVER () min_executions_total, MIN(executions_delta) keep  (DENSE_RANK FIRST ORDER BY EXECUTIONS_TOTAL) OVER () min_executions_delta from dba_hist_sqlstat where sql_id = '&1' and plan_hash_value=total.plan_hash_value)) )+ --Min(executions_total)(-su executions_delta) en caso que no se haya registrado el total con executions_delta=0
	(select SUM(executions_delta) from dba_hist_sqlstat where sql_id = total.sql_id and plan_hash_value=total.plan_hash_value) sum_execs,
	(select SUM(end_of_fetch_count_delta) from dba_hist_sqlstat where sql_id = total.sql_id and plan_hash_value=total.plan_hash_value) sum_end_of_fetch_count,
(select min(begin_interval_time) from 
	(select begin_interval_time from dba_hist_snapshot where snap_id = (select min(snap_id) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value)
	 union
	 select last_active_time begin_interval_time from gv$sql where sql_id = total.sql_id and plan_hash_value=total.plan_hash_value
	)
) min_time_exec_plan,
(select max(begin_interval_time)  from 
	(select begin_interval_time from dba_hist_snapshot where snap_id = (select max(snap_id) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value)
	 union
	 select last_active_time begin_interval_time from gv$sql where sql_id = total.sql_id and plan_hash_value=total.plan_hash_value
	)
) last_time_exec_plan,
case when ((select to_char(max(begin_interval_time),'DD-MM-YY HH24:MI') from 
	(select begin_interval_time from dba_hist_snapshot where snap_id = (select min(snap_id) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value)
	 union
	 select last_active_time begin_interval_time from gv$sql where sql_id = total.sql_id and plan_hash_value=total.plan_hash_value
	)
)) = to_char(last_exec.begin_interval_time,'DD-MM-YY HH24:MI') then '*' else '' end current_plan,
 round(avg_et_secs,1) avg_et_secs, 
 round(avg_et_secs-(select min(total.avg_et_secs) from total)) diff_avg_et_secs_from_min, 
 round(((total.avg_et_secs*100)/(select decode(min(total.avg_et_secs),0,0.99999,min(total.avg_et_secs)) from total))-100,1) avg_et_secs_pct_from_min, 
 '|' as "|",
 round(avg_rows,1) avg_rows,
 (select (min(rows_processed_total)) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and executions_total > 0) min_rows,
 (select (max(rows_processed_total)) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and executions_total > 0) max_rows,
 round(avg_rows-(select min(total.avg_rows) from total)) diff_avg_rows_from_min, 
 round((total.avg_rows*100/(select decode(min(total.avg_rows),0,0.99999,min(total.avg_rows)) from total))-100,1)  avg_rows_pct_from_min,
 avg_rows/(decode(avg_et_secs,0,0.99999,avg_et_secs)) avg_rows_per_sec,
 '|' as "|",
 (select distinct('Yes') from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and io_offload_elig_bytes_total <> 0 and executions_total > 0) Offload,
 (select round(sum(cpu_time_total)     /SUM(executions_total)) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and executions_total > 0) avg_cpu ,
 (select round(sum(optimizer_cost)     /SUM(executions_total)) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and executions_total > 0) avg_opt_cost ,
 (select round(sum(disk_reads_delta)      /SUM(executions_total)) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and executions_total > 0) avg_pio ,
 (select round(sum(buffer_gets_delta)     /SUM(executions_total)) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and executions_total > 0) avg_lio ,
 (select round(sum(px_servers_execs_delta)/SUM(executions_total)) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and executions_total > 0) avg_px,
 (select round(sum(invalidations_total)     /SUM(executions_total)) from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and executions_total > 0) avg_invalidations,
 (select distinct('Yes') from dba_hist_sqlstat wHERE sql_id = total.sql_id and plan_hash_value=total.plan_hash_value and sql_profile is not null and executions_total > 0) sql_profile
 from total,last_exec
order by avg_et_secs NULLS LAST
/