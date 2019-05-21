--segments_keep.sql
set pages 1000
set verify off
set lines 132
set feedback off
set trims on
set linesize 200
col owner for a20
col object_name for a40 heading "Nombre de Objeto"
Break on segment_name on report 
compute sum of MB on report 

ttitle left 'Segmentos que tienen como default buffer keep'
select owner,segment_type,tablespace_name,segment_name,round(sum(bytes)/1024/1024,1) MB 
from 
dba_Segments 
where 
buffer_pool='KEEP'
group by owner,segment_type,segment_name,tablespace_name,blocks,extents,buffer_pool;
ttitle off
prompt
prompt Parametro db_keep_cache_size
prompt
prompt **************************************************
show parameter db_keep_cache_size
prompt
prompt **************************************************
prompt
prompt 
@buffer_hit_ratio
prompt
prompt
@blocks_inbuffer_keep
prompt
prompt **************************************************
Prompt Ejecutar segments_to_keep.sql para
prompt ver candidatos a levantar a keep
prompt **************************************************
prompt