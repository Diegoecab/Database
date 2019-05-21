set linesize 400
set pagesize 1000
set verify off

col subpartition_count for 99
col index_owner for a15
col pct_Free for 999
col buffer_pool for a8
col partition_position for 999
col high_value for a85
col index_name for a30

select index_owner,index_name,partition_name,subpartition_count,partition_position,high_value,tablespace_name,pct_free,compression,status
from 
dba_ind_partitions 
where index_owner like upper('%&index_owner%')
and index_name like upper('%&index_name%')
and partition_name like upper('%&partition_name%')
and status like upper('%&unusable%')
order by 1,2,3
/