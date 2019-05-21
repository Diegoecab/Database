set pages 999
set lines 150

ttitle 'Contenido del buffer keep de la base de datos'
 

drop table t1;


create table t1 as
select
   o.object_name    object_name,
   o.object_type    object_type,
   count(1)         num_blocks
from
   dba_objects  o,
   v$bh         bh
where
   o.object_id  = bh.objd
and
   o.owner not in ('SYS','SYSTEM')
group by
   o.object_name,
   o.object_type
order by
   count(1) desc
;

 
Break on mb on report 
compute sum of mb on report 
compute sum of mbm on report 
 
column owner heading "Owner"					format a20
column c1 heading "Object|Name"                 format a40
column c2 heading "Object|Type"                 format a15
column c3 heading "Number of|Blocks"            format 9999,999,999,999
column c4 heading "Percentage|of object|data blocks|in Buffer" format 999
column MB heading "MB|Objeto"
column buffer_pool heading "Buffer|Pool"		format a20
column mbm heading "MB|En|Memoria"

 

select
   s.owner,
   object_name       c1,
   object_type       c2,
   num_blocks        c3,
   round((num_blocks * 8192)/1024/1024,1) mbm,
   (num_blocks/decode(sum(blocks), 0, .001, sum(blocks)))*100 c4,
   buffer_pool,
   round(sum(bytes/1024/1024),1) MB
from
   t1,
   dba_segments s
where
   s.segment_name = t1.object_name
and
   num_blocks > 10
and
	buffer_pool = 'DEFAULT'
group by
   owner,
   object_name,
   object_type,
   num_blocks,
   buffer_pool
order by
owner,
   num_blocks desc
;

drop table t1;

ttitle off