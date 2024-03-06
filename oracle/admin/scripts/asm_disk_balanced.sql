select group_number, max(free_mb) biggest, min(free_mb) lowest, avg(free_mb) AVG,
trunc(GREATEST ((avg(free_mb)*100/max(free_mb)),(min(free_mb)*100/avg(free_mb))),2)||'%' as balanced,
trunc(100-(GREATEST ((avg(free_mb)*100/max(free_mb)),(min(free_mb)*100/avg(free_mb)))),2)||'%' as inbalanced
from v$asm_disk
where group_number in
(select group_number from v$asm_diskgroup where name like upper('%&DG%'))
group by group_number;