set lines 400
select group_number, name, state, type, total_mb, round(total_mb/1024) total_gb, free_mb, 
round(free_mb/1024) free_gb from  v$asm_diskgroup
 order by 1;
 
 
select group_number, name, state, type, total_mb, round(total_mb/1024) total_gb, free_mb, 
round(free_mb/1024) free_gb,  round(free_mb*100/total_mb) pct_free, 
round(100-(free_mb*100/total_mb)) pct_used from  v$asm_diskgroup
where total_mb > 0
 order by 10;
 
 