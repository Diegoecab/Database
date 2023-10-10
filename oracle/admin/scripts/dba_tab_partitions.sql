--dba_tab_partitions
col subpartition_count for 999
col table_owner for a20
col table_name for a30
col pct_free for 999
col composite for a3
col buffer_pool for a10
col partition_position for 9999
col high_value for a30 truncate
col mb for 99999
set long 4000
set lines 400
set verify off
col partition_name for a20 truncate

select
table_owner,table_name,(select bytes/1024/1024 from dba_segments b where b.owner=a.table_owner and b.segment_name=a.table_name and 
b.partition_name=a.partition_name) mb,composite,a.partition_name,partition_position,high_value,num_rows, interval,
subpartition_count,a.tablespace_name,pct_free,logging,compression,last_analyzed
from dba_tab_partitions a
where table_owner like upper('%&table_owner%')
and table_name like upper('%&table_name%')
and a.partition_name like upper('%&partition_name%')
and a.tablespace_name like upper('%&tablespace_name%')
order by 1,2,6
/


clear col