--v$db_object_cache_sharedpool.sql
col object for a50
col name for a50
col type for a50
col owner for a15
col db_link for a20
set lines 220
select     OWNER,
   NAME,
   TYPE,
   loads,
   executions,
   locks,
   kept,
        pins,
		db_link,
   round(SHARABLE_MEM/1024) KB
from       v$db_object_cache
where      SHARABLE_MEM > 10000
and        type in ('PACKAGE','PACKAGE BODY','FUNCTION','PROCEDURE')
--and owner='BFI'
order      by SHARABLE_MEM desc
/