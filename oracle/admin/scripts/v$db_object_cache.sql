--v$db_object_cache.sql

SELECT type,kept,round((sum(sharable_mem))/1024/1024) MB
  FROM V$DB_OBJECT_CACHE
 GROUP BY TYPE,KEPT
ORDER BY 3;