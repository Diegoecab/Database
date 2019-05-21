SELECT ROUND(pga_target_for_estimate/1024/1024) target_mb,
       PGA_TARGET_FACTOR,
       estd_pga_cache_hit_percentage cache_hit_perc,
       estd_overalloc_count
FROM   v$pga_target_advice;

SELECT *
FROM v$pga_target_advice_histogram
WHERE pga_target_factor = 1
AND estd_total_executions != 0
ORDER BY 1;
