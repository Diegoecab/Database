REM shared_pool_free_mem.sql
SELECT pool, name,round(bytes/1024/1024,2) MB FROM V$SGASTAT 
 WHERE NAME = 'free memory'
AND POOL = 'shared pool';

PROMPT Para ver memoria libre en shared_pool_reserved, script v$shared_pool_reserved.sql