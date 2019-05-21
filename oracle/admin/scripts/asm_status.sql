--asm_status.sql

set wrap off
set lines 120
set pages 999

clear columns


col "Group Name"   form a25
col "Disk Name"    form a30
col "State"  form a15
col "Type"   form a7
col "Free GB"   form 9999

 

prompt
prompt ASM Disk Groups
prompt ===============

select group_number  "Group"
,      name          "Group Name"
,      state         "State"
,      type          "Type"
,      total_mb/1024 "Total GB"
,      free_mb/1024  "Free GB"
from   v$asm_diskgroup
/

 

prompt
prompt ASM Disks
prompt =========

 

col "Group"          form 999
col "Disk"           form 999
col "Header"         form a9
col "Mode"           form a8
col "Redundancy"     form a10
col "Failure Group"  form a10
col "Path"           form a19

 

select group_number  "Group"
,      disk_number   "Disk"
,      header_status "Header"
,      mode_status   "Mode"
,      state         "State"
,      redundancy    "Redundancy"
,      total_mb      "Total MB"
,      free_mb       "Free MB"
,      name          "Disk Name"
,      failgroup     "Failure Group"
,      path          "Path"
from   v$asm_disk
order by group_number
,        disk_number
/

 

prompt
prompt Instances currently accessing these diskgroups
prompt ==============================================

col "Instance" form a8

select c.group_number  "Group"
,      g.name          "Group Name"
,      c.instance_name "Instance"
from   v$asm_client c
,      v$asm_diskgroup g
where  g.group_number=c.group_number
/

 

prompt
prompt Current ASM disk operations
prompt ===========================

select *
from   v$asm_operation
/

 

prompt
prompt free ASM disks and their paths
prompt ===========================

select header_status , mode_status, path from V$asm_disk
where header_status in ('FORMER','CANDIDATE')
/

 

clear columns