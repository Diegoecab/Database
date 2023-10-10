--@resource_limit
col INITIAL_ALLOCATION heading 'Initial|Allocation'
col limit_value heading 'Limit|Value'
--select * from v$resource_limit;

set lines 300
col INITIAL_ALLOCATION for a17
col LIMIT_VALUE for a12
select resource_name,current_utilization,max_utilization,
INITIAL_ALLOCATION,LIMIT_VALUE,round((current_utilization*100)/(INITIAL_ALLOCATION)) as "Process limit %"
from v$resource_limit
where resource_name in ('processes','sessions');