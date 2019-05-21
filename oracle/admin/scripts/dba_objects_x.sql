set pages 1000
set lines 132
set trims on
col owner for a20
col object_name for a40

select owner,object_type,object_name,created,status from 
dba_objects where 
owner like upper('%&OWNER%') and
object_name like upper('%&OBJ_NAME%')
/