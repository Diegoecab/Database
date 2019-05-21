--dba_tab_subpartitions

col table_owner for a20
col table_name for a30
col pct_free for 999
col buffer_pool for a10
col subpartition_position for 9999
col high_value for a100
set long 4000
set lines 400
set verify off

select
table_owner,table_name,--bytes/1024/1024 mb,
a.partition_name,a.subpartition_name,a.blocks, a.empty_blocks, last_analyzed, subpartition_position,high_value,num_rows,a.tablespace_name,pct_free,logging,compression,a.buffer_pool
from dba_tab_subpartitions a 
--join dba_segments b on b.owner=a.table_owner and b.segment_name=a.table_name and b.partition_name=a.subpartition_name
where table_owner like upper('%&table_owner%')
and table_name like upper('%&table_name%')
and a.partition_name like upper('%&partition_name%')
and a.subpartition_name like upper('%&subpartition_name%')
and a.tablespace_name like upper('%&tablespace_name%')
order by 1,2,6
/

clear col