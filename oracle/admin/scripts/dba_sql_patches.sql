--@dba_sql_patches
col name for a40 truncate
set lines 300
col description for a40 truncate
select name, created, description, status, SIGNATURE from dba_sql_patches;