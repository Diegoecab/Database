set lines 900
col compatibility for a20
col DATABASE_COMPATIBILITY for a20
COL NAME FOR A30

select group_number, name, state, type, total_mb, round(total_mb/1024) total_gb, free_mb, 
 COMPATIBILITY  ,                                                                      
 DATABASE_COMPATIBILITY,VOTING_FILES,
round(free_mb/1024) free_gb from  v$asm_diskgroup
 order by 1;
 
 
select group_number, name, state, type, total_mb, round(total_mb/1024) total_gb, free_mb, 
round(free_mb/1024) free_gb,  round(free_mb*100/total_mb) pct_free, 
round(100-(free_mb*100/total_mb)) pct_used from  v$asm_diskgroup
where total_mb > 0
 order by 10;
 
 
select dg.name, d.failgroup, d.state, d.header_status, d.mount_status, d.mode_status, count(1) num_disks
from v$asm_disk d, v$asm_diskgroup dg
where d.group_number = dg.group_number
and dg.name like upper ('%&DG%')
group by dg.name, d.failgroup, d.state, d.header_status, d.mount_status, d.mode_status
order by 1,2,3;



col path format a150
col label for a40
col total_gb for 99999
set lines 1200

select dg.name, d.state, d.failgroup,  round(d.total_mb/1024) total_gb, d.label, d.path
from v$asm_disk d, v$asm_diskgroup dg
where d.group_number = dg.group_number
and dg.name like upper ('%&DG%') 
order by 1,2,3;



select dg.name, dg.state, d.failgroup,  round(sum(d.total_mb)/1024) total_gb, count(*)
from v$asm_disk d, v$asm_diskgroup dg
where d.group_number = dg.group_number
group by dg.name, dg.state, d.failgroup;



select dg.name, dg.state, round(sum(d.total_mb)/1024) total_gb, count(*)
from v$asm_disk d, v$asm_diskgroup dg
where d.group_number = dg.group_number
group by dg.name, dg.state;
