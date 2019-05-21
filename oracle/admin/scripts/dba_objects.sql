--dba_objects

set pages 1000
set lines 400
set trims on
set verify off
col owner for a20
col object_name for a40


select owner,object_type,object_name,created,status,last_ddl_time, timestamp from 
dba_objects where 
owner like upper('%&owner%') 
and object_type like upper('%&object_type%') 
and object_name like upper('%&obj_name%')
order by 1,2,3

/