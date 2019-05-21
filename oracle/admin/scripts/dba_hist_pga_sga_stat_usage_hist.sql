select sn.INSTANCE_NUMBER, sga.mem_sga sga, pga.mem_pga pga,(sga.mem_sga+pga.mem_pga) tot,to_char(END_INTERVAL_TIME,'DD-MON-YY HH24:MI:SS') end_interval_time
  from
(select snap_id,INSTANCE_NUMBER,round(sum(bytes)/1024/1024,2) mem_sga
   from DBA_HIST_SGASTAT
  group by snap_id,INSTANCE_NUMBER) sga
,(select snap_id,INSTANCE_NUMBER,round(sum(value)/1024/1024,2) mem_pga
    from DBA_HIST_PGASTAT where name = 'total PGA allocated'
   group by snap_id,INSTANCE_NUMBER) pga
, dba_hist_snapshot sn
where sn.snap_id=sga.snap_id
  and sn.INSTANCE_NUMBER=sga.INSTANCE_NUMBER
  and sn.snap_id=pga.snap_id
  and sn.INSTANCE_NUMBER=pga.INSTANCE_NUMBER
and
sn.begin_interval_time > '&DATE'
order by begin_interval_time
/
