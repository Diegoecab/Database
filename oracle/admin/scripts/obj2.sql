set linesize 180
col owner format a10
col object_type format a20
col object_name format a30
col last_ddl_time format a20
select owner, object_type, object_name, CREATED, last_ddl_time,status 
from dba_objects where object_name like '%'||upper('&1')||'%'
order by owner, object_name,object_type
/
