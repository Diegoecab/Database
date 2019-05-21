set pages 1000
set verify off
set lines 132
set feedback off
set trims on
set linesize 200
col owner for a20
col object_name for a40 heading "Nombre de Objeto"
accept OBJ_NAME prompt 'Ingrese Nombre de objeto: '

select owner,segment_type,tablespace_name,
blocks,extents,buffer_pool,sum(bytes)/1024/1024 MB 
from 
dba_Segments 
where 
segment_name=upper('&OBJ_NAME') 
group by owner,segment_type,tablespace_name,blocks,extents,buffer_pool;