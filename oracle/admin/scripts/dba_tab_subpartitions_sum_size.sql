--dba_tab_partitions
col subpartition_count for 999
col table_owner for a20
col table_name for a30
col pct_free for 999
col composite for a3
col buffer_pool for a10
col partition_position for 9999
col high_value for a10 truncate
col mb for 99999
set long 4000
set lines 300
set verify off
col table_owner for a20 truncate
col table_name for a20 truncate
col SUBPARTITION_NAME for a20 truncate
col PARTITION_NAME for a20 truncate


select count(*) from (
select
a.table_owner,a.table_name,
(select bytes from dba_segments b where b.owner=a.table_owner and b.segment_name=a.table_name and 
b.partition_name=a.subpartition_name) bytes,
(select round(bytes/1024/1024,1) from dba_segments b where b.owner=a.table_owner and b.segment_name=a.table_name and 
b.partition_name=a.subpartition_name) mbytes,
z.high_value high_value_part,
z.partition_position,
a.subpartition_position,
a.partition_name,
a.subpartition_name,
a.high_value,
a.interval
from dba_tab_subpartitions a, dba_tab_partitions z
where a.table_owner = 'DTV_PROD_STG'
and a.table_name = 'SA_REL_PCOMERCIAL_CLIENTE_HIST'
and z.table_owner = a.table_owner and z.table_name=a.table_name and z.partition_name=a.partition_name
and a.partition_position between 6954	and	7319	--	2019
order by z.partition_position, a.subpartition_position
) where bytes is  null;


