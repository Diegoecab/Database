set lines 300
set pages 50
col diskgroup for a20
col name for a30
col path for a50
col free_mb for 999999999999
col total_mb for 999999999999
col new_aloc_mb for 999999999999
col add_mb for 999999999999

select
dg.name,
FAILGROUP,
label,
dk.path
,dk.header_status
,dk.total_mb
,dk.free_mb
,dk.MOUNT_DATE
,dk.create_DATE
from v$asm_diskgroup dg
, v$asm_disk dk
where dg.group_number =dk.group_number (+)
--and dk.path like upper('%HDD_E0_S00_1612431856%')
and dg.name like UPPER('%&dg%')
order by dk.name
;




select GROUP_NUMBER, label, path, name,header_status
,total_mb
,free_mb
,MOUNT_DATE
,create_DATE
from v$asm_disk;
