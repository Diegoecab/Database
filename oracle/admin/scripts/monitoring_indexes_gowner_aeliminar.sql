--monitoring_indexes_gowner_aeliminar.sql

col owner for a20
col segment_name for a40
col tablespace_name for a25

Break on segment_name on report 
compute sum of mb on report 

select owner,sum(bytes)/1024/1024 MB
from
dba_Segments a
where
segment_type='INDEX' and
segment_name in (select index_name from (
select
   u.name as owner,
   io.name as index_name,
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
) where monitoring = 'yes' and used = 'no' and owner=a.owner)
group by owner
order by 2
/
