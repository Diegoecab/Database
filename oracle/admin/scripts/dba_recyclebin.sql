--dba_recyclebin
set pages 50
col owner for a20
col object_name for a30 TRUNCATE
col ts_name for a20 truncate
col original_name for a30 truncate
Break on object_name on report 
compute sum of mb on report 
select a.owner,a.object_name,a.original_name,a.droptime,a.ts_name,sum(b.bytes)/1024/1024 MB from dba_recyclebin a inner join dba_Segments b
on b.owner=a.owner and b.segment_name=a.object_name group by a.owner,a.object_name,a.original_name,a.droptime,a.ts_name,b.bytes order by b.bytes
/


select  a.ts_name,a.owner,min(a.droptime), max(a.droptime),round(sum(b.bytes)/1024/1024/1024) GB from dba_recyclebin a inner join dba_Segments b
on b.owner=a.owner and b.segment_name=a.object_name group by
a.ts_name,a.owner order by 5
/

