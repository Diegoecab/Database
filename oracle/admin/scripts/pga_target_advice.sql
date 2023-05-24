--pga_target_advice.sql
set pagesize 60
set linesize 200

SELECT
    a.inst_id,
    a.pga_target_factor factor,
    to_number(trunc(a.pga_target_for_estimate / 1024 / 1024 / 1024)) pga_target_gb,
    a.estd_pga_cache_hit_percentage estd_cache_hit,
    a.estd_overalloc_count,
    ah.optimal_exec,
    ah.onepass_exec,
    ah.multipass_exec
FROM
    gv$pga_target_advice a,
    (select inst_id, PGA_TARGET_FACTOR, SUM(ESTD_OPTIMAL_EXECUTIONS) optimal_exec, SUM(ESTD_ONEPASS_EXECUTIONS) onepass_exec, SUM(ESTD_MULTIPASSES_EXECUTIONS) multipass_exec
       FROM gV$PGA_TARGET_ADVICE_HISTOGRAM 
   GROUP BY inst_id, PGA_TARGET_FACTOR) ah
where a.pga_target_factor = ah.pga_target_factor
  and a.inst_id = ah.inst_id
order by 1,3
;
