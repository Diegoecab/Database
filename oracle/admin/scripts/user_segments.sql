--user_segments

set pages 1000
set verify off
set feedback off
set lines 600
set head on

undefine all
col owner for a20
col segment_name for a40
col partition_name for a20 truncate
col size_mb for 99999999


break on owner on report
compute sum of size_mb on report

select segment_type, segment_name, partition_name, tablespace_name, round(bytes/1024/1024) size_mb
from 
user_segments
where upper(segment_name) like upper('%&segment_name%')
and segment_name not like 'BIN$%' --Recycle bin
and segment_type like upper('%&segment_type%')
and nvl(partition_name,'null') like upper('%&partition_mame%')
and tablespace_name like upper('%&tablespace_name%')
and bytes/1024/1024/1024 > nvl ('&gb',0)
order by size_mb
/