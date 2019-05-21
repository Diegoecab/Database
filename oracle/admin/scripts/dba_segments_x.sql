--dba_segments_x

set pages 1000
set verify off
set feedback off
set lines 300

col owner for a20
col segment_name for a40
col size_mb for 99999

select owner, segment_type, segment_name, partition_name, tablespace_name,
blocks, extents, buffer_pool, round(bytes/1024/1024) size_mb
from 
dba_Segments
where 
owner like upper('%&owner%')
and segment_name like upper('%&segment_name%')
and nvl(partition_name,'null') like upper('%&partition_mame%')
and tablespace_name like upper('%&tablespace_name%')
order by owner,segment_type,size_mb
/