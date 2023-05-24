--dba_hist_pgastat.sql

col pga_target format 999999999
col max_pga format 999999999
col over_alloc_count format 999999999
col mem_bound format 999999999
col begin_interval_time format a30 head 'SNAPSHOT START TIME'

set line 200 trimspool on
set pagesize 60

with pga_target as (
	select snap_id, instance_number, value pga_target
	from  dba_hist_pgastat
	where name = 'aggregate PGA target parameter'
),
over_alloc as (
	select snap_id, instance_number, value over_alloc_count
	from dba_hist_pgastat
	where name = 'over allocation count'
),
max_pga as (
	select snap_id, instance_number, value max_pga
	from dba_hist_pgastat
	where name = 'maximum PGA allocated'
),
tot_pga as (
	select snap_id, instance_number, value tot_pga
	from dba_hist_pgastat
	where name = 'total PGA allocated'
),
global_mem_bound as (
	select snap_id, instance_number, value mem_bound
	from dba_hist_pgastat
	where name = 'global memory bound'
)
select
	s.begin_interval_time
	, t.instance_number
	, t.pga_target/1024/1024
	, m.max_pga/1024/1024
	, h.tot_pga/1024/1024
	, o.over_alloc_count
	, g.mem_bound/1024/1024
	, case 
		when g.mem_bound < power(2,20) then 'Mem too low' -- see v$pgastat docs
		else 'Mem ok'
	end memchk
from pga_target t
join over_alloc o on o.instance_number = t.instance_number
	and o.snap_id = t.snap_id
join max_pga m on m.instance_number = t.instance_number
	and m.snap_id = t.snap_id
join tot_pga h on h.instance_number = t.instance_number
	and h.snap_id = t.snap_id
join global_mem_bound g on g.instance_number = t.instance_number
	and g.snap_id = t.snap_id
join dba_hist_snapshot s on s.snap_id = t.snap_id
	and s.instance_number = t.instance_number
where begin_interval_time > sysdate-7
order by s.snap_id, t.instance_number
/




SELECT  sn.INSTANCE_NUMBER,
         sga.allo sga,
         pga.allo pga,
         (sga.allo + pga.allo) tot,
         TRUNC (SN.END_INTERVAL_TIME, 'mi') time
    FROM (  SELECT snap_id,
                   INSTANCE_NUMBER,
                   ROUND (SUM (bytes) / 1024 / 1024 / 1024, 3) allo
              FROM DBA_HIST_SGASTAT
          GROUP BY snap_id, INSTANCE_NUMBER) sga,
         (  SELECT snap_id,
                   INSTANCE_NUMBER,
                   ROUND (SUM (VALUE) / 1024 / 1024 / 1024, 3) allo
              FROM DBA_HIST_PGASTAT
             WHERE name = 'total PGA allocated'
          GROUP BY snap_id, INSTANCE_NUMBER) pga,
         dba_hist_snapshot sn
   WHERE     sn.snap_id = sga.snap_id
         AND sn.INSTANCE_NUMBER = sga.INSTANCE_NUMBER
         AND sn.snap_id = pga.snap_id
         AND sn.INSTANCE_NUMBER = pga.INSTANCE_NUMBER
		 AND END_INTERVAL_TIME > sysdate -3
ORDER BY sn.snap_id, sn.INSTANCE_NUMBER;