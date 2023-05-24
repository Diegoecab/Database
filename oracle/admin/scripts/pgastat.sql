--pgastat.sql
--show max total pga allocated since instance startup

set lines 180

col pga_target_gb format 9999999999999
col max_pga_gb format 999999999
col over_alloc_count format 999999999
col mem_bound format 999999999

with pga_target as (
	select inst_id, value pga_target
	from gv$pgastat
	where name = 'aggregate PGA target parameter'
),
pga_auto_target as (
	select inst_id, value pga_auto_target
	from gv$pgastat
	where name = 'aggregate PGA auto target'
),
over_alloc as (
	select inst_id, value over_alloc_count
	from gv$pgastat
	where name = 'over allocation count'
),
max_pga as (
	select inst_id, value max_pga
	from gv$pgastat
	where name = 'maximum PGA allocated'
),
global_mem_bound as (
	select inst_id, value mem_bound
	from gv$pgastat
	where name = 'global memory bound'
)
select 
	t.inst_id
	, t.pga_target/1024/1024/1024
	, i.pga_auto_target/1024/1024/1024
	, m.max_pga/1024/1024/1024
	, o.over_alloc_count--/1024/1024/1024
	, g.mem_bound/1024/1024/1024
from pga_target t
join over_alloc o on o.inst_id = t.inst_id
join max_pga m on m.inst_id = t.inst_id
join pga_auto_target i on i.inst_id = t.inst_id
join global_mem_bound g on g.inst_id = t.inst_id
order by inst_id
/
