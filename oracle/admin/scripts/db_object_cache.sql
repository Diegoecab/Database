--v$db_object_cache.sql
col owner for a20 truncate
col name for a20 truncate
col type for a20 truncate
set verify off
set lines 300

SELECT inst_id,owner,name,timestamp,type,kept,sharable_mem/1024/1024 MB--,round((sum(sharable_mem))/1024/1024) MB
  FROM gV$DB_OBJECT_CACHE
  where upper(owner) like upper('%&owner%')
  and upper(name) like upper('%&name%')
-- GROUP BY owner,name,TYPE,KEPT
ORDER BY 3;