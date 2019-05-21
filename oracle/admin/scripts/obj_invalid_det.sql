col owner format a10
col object_type format a20
col object_name format a30
col last_ddl_time format a20
select owner, object_type, status, count(*) from dba_objects where status <> 'VALID' group by owner, object_type,  status
/

select owner, object_type, object_name from dba_objects where status <> 'VALID' order by owner, object_type, status
/
