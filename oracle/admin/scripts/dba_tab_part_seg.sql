SELECT
table_owner, round(sum(b.bytes/1024/1024)) Mb, table_name,composite,a.partition_name,partition_position,
subpartition_count,a.tablespace_name,pct_free,logging,compression,a.buffer_pool,round(((sum(b.bytes/1024/1024))*10)/100) REC
FROM dba_tab_partitions a, dba_segments b
where a.table_owner = '&OWNER'
and b.owner=a.table_owner and b.segment_name=a.table_name and b.partition_name=a.partition_name
--and pct_free <> 0 and a.partition_name not like '%DEC11' and a.partition_name not like '%12'
group by table_owner,TABLE_NAME,composite,a.partition_name,partition_position,
subpartition_count,a.tablespace_name,pct_free,logging,compression,a.buffer_pool
ORDER BY 1,2,5
/
