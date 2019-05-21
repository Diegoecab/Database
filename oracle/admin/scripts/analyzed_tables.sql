set pages 999 lines 100
select	a.owner
,	a.total_tables tables
,	nvl(b.analyzed_tables,0) analyzed
from	(select	owner
	,	count(*) total_tables
	from	dba_tables
	group	by owner) a
,	(select	owner
	,	count(last_analyzed) analyzed_tables
	from	dba_tables
	where	last_analyzed is not null
	group	by owner) b
where	a.owner = b.owner (+)
and	a.owner not in ('SYS', 'SYSTEM')
order	by a.total_tables - nvl(b.analyzed_tables,0) desc
/

