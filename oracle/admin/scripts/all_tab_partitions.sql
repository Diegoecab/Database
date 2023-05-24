--all_tab_partitions
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
table_owner,table_name,composite,a.partition_name,partition_position,num_rows,high_value, interval,blocks,
subpartition_count,a.tablespace_name,pct_free,logging,compression,last_analyzed
from all_tab_partitions a
order by 1,2,5
/


clear col