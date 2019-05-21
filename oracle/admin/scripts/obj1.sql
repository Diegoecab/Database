set linesize 180
col owner format a10
col object_type format a20
col object_name format a30
col last_ddl_time format a20
select object_type, status, count(*) 
from dba_objects where owner = upper('&1')
group by object_type, status
ORDER BY 1,2
/
