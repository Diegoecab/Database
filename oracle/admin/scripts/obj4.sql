set linesize 180
col owner format a10
col object_type format a20
col object_name format a30
col last_ddl_time format a20
select owner object_type, status, count(*) 
from dba_objects where owner not in ('SYS','SYSTEM')
AND OBJECT_NAME NOT LIKE 'Z99_00%'
group by owner, object_type, status
/
