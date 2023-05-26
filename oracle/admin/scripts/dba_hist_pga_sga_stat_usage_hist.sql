--dba_hist_pga_sga_stat_usage_hist.sql days

COMPUTE MAX LABEL 'MAX' OF SGA ON report;
COMPUTE MAX LABEL 'MAX' OF PGA ON report;
COMPUTE MAX LABEL 'MAX' OF TOT ON report;
set pages 100

BREAK ON REPORT

select sn.INSTANCE_NUMBER inst_id, round(sga_tot.mem_sga) sga_tot, round(shared_pool.mem_shared_pool) shared_pool, round(pga.mem_pga) pga,round(sga_tot.mem_sga+pga.mem_pga) tot,to_char(END_INTERVAL_TIME,'DD-MON-YY HH24:MI:SS') end_interval_time
  from
(select snap_id,INSTANCE_NUMBER,round(sum(bytes)/1024/1024,2) mem_sga
   from DBA_HIST_SGASTAT
  group by snap_id,INSTANCE_NUMBER) sga_tot
,(select snap_id,INSTANCE_NUMBER,round(sum(bytes)/1024/1024,2) mem_shared_pool
   from DBA_HIST_SGASTAT where pool = 'shared pool'--/streams/java/numa/large -- pool is null
  group by snap_id,INSTANCE_NUMBER) shared_pool
,(select snap_id,INSTANCE_NUMBER,round(sum(value)/1024/1024,2) mem_pga
    from DBA_HIST_PGASTAT where name = 'total PGA allocated'
   group by snap_id,INSTANCE_NUMBER) pga
, dba_hist_snapshot sn
where sn.snap_id=sga_tot.snap_id
  and sn.INSTANCE_NUMBER=sga_tot.INSTANCE_NUMBER
  and sn.snap_id=pga.snap_id
  and sn.INSTANCE_NUMBER=pga.INSTANCE_NUMBER
  and sn.snap_id=shared_pool.snap_id
  and sn.INSTANCE_NUMBER=shared_pool.INSTANCE_NUMBER
and
sn.begin_interval_time > sysdate-&1
order by begin_interval_time
/

select con_id, INSTANCE_NUMBER ins_id, max(sga), max(pga), max(tot) from (
select sn.con_id,sn.INSTANCE_NUMBER, round(sga.mem_sga) sga, round(pga.mem_pga) pga,round(sga.mem_sga+pga.mem_pga) tot,to_char(END_INTERVAL_TIME,'DD-MON-YY HH24:MI:SS') end_interval_time
  from
(select con_id, snap_id,INSTANCE_NUMBER,round(sum(bytes)/1024/1024,2) mem_sga
   from DBA_HIST_SGASTAT
  group by con_id,snap_id,INSTANCE_NUMBER) sga
,(select con_id, snap_id,INSTANCE_NUMBER,round(sum(value)/1024/1024,2) mem_pga
    from DBA_HIST_PGASTAT where name = 'total PGA allocated'
   group by con_id,snap_id,INSTANCE_NUMBER) pga
, dba_hist_snapshot sn
where sn.snap_id=sga.snap_id
  and sn.INSTANCE_NUMBER=sga.INSTANCE_NUMBER
  and sn.snap_id=pga.snap_id
  and sn.INSTANCE_NUMBER=pga.INSTANCE_NUMBER
and
sn.begin_interval_time > sysdate-&1
order by begin_interval_time
) group by con_id,INSTANCE_NUMBER
/
