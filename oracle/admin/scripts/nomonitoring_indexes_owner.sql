--nomonitoring_indexes_owner.sql
set pages 1000
set lines 132
set trims on
set verify off
set feedback off

col owner for a10
accept OWNER prompt 'Ingrese OWNER: '

select * from (
select 
   u.name as owner,
   io.name "index_name",
   t.name "table_name",
   decode(bitand(i.flags, 65536), 0, 'no', 'yes') as monitoring,
   decode(bitand(nvl(ou.flags,0), 1), 0, 'no', 'yes') as used,
   ou.start_monitoring "start_monitoring",
   ou.end_monitoring "end_monitoring"
from 
   sys.obj$ io, 
   sys.obj$ t, 
   sys.ind$ i, 
   sys.object_usage ou, sys.user$ u
where 
   t.obj#=i.bo#
and 
   io.owner#=u.user#
and 
   io.obj#=i.obj#
and 
   u.name not in ('SYS','SYSTEM')
and 
   i.obj# =ou.obj#(+)
) where monitoring = 'no' and owner=upper('&OWNER');

set feedback on