SELECT RPAD (component, 30), current_size / 1024 / 1024 taman_act_mb,
       min_size / 1024 / 1024 taman_min_mb, max_size, oper_count
  FROM v$sga_dynamic_components
 WHERE component LIKE '%buffer cache%';