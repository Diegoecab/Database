set lines 900
set pages 1000
col owner for a10
col table_name for a15
col partition_name for a18
col subpartition_name for a18

select owner, object_type, table_name, partition_name, partition_position, subpartition_name, num_rows, last_analyzed, stale_stats from dba_tab_statistics
where upper(owner) like upper('%&OWNER%');