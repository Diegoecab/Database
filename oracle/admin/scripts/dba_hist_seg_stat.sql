--dba_hist_seg_stat
set lines 400
col owner for a20 truncate
col OBJECT_NAME for a30 truncate
col OBJECT_TYPE for a10 truncate

select INSTANCE_NUMBER inst_id, b.owner, b.object_type, 
(select BEGIN_INTERVAL_TIME from dba_hist_snapshot where snap_id=a.snap_id) as dttime,
PHYSICAL_READS_TOTAL,PHYSICAL_READS_DELTA,PHYSICAL_WRITES_TOTAL,PHYSICAL_WRITES_DELTA,round(SPACE_USED_TOTAL /1024/1024) SPACE_USED_MB,round(SPACE_ALLOCATED_TOTAL/1024/1024) SPACE_ALLOCATED_MB,PHYSICAL_READ_REQUESTS_TOTAL
    from dba_hist_seg_stat a, dba_objects b
    where a.obj# = b.object_id
    and   b.owner = 'PL'
    and object_name = 'IDX_PYL_SISTEMA_EVENTOS'
order by b.timestamp;