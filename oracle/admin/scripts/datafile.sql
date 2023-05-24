set lines 500
col name for a100 truncate
col TBS_NAME for a20 truncate
select FILE#, b.NAME TBS_NAME, a.name,CREATION_TIME, round(BYTES/1024/1024/1024) size_gb,BLOCK_SIZE, STATUS, ENABLED
from v$datafile a
join v$tablespace b on a.ts#=b.ts#
order by 1;