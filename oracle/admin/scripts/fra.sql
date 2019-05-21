prompt Flash Recovery Area
prompt ===================
prompt

set feedback off

col name format a30 
col value format a50
select name, decode( name,'db_recovery_file_dest',value, trim(to_char(to_number(value)/1024/1024,'999,999')||' M') ) value
from v$parameter 
where name like 'db_recovery_file_dest%';

select * from V$FLASH_RECOVERY_AREA_USAGE;

SELECT (100 - sum(percent_space_used)) + sum(percent_space_reclaimable) "% usable space"
FROM v$flash_recovery_area_usage;

col name format a50
col space_limit format 999,999
col space_used format 999,999
col space_reclaimable format 999,999
col number_of_files format 999,999
select NAME, 
trunc(SPACE_LIMIT/1024/1024) SPACE_LIMIT,
trunc(SPACE_USED/1024/1024) SPACE_USED,  
trunc(SPACE_RECLAIMABLE/1024/1024) SPACE_RECLAIMABLE, 
NUMBER_OF_FILES
from V$RECOVERY_FILE_DEST;

prompt
prompt




