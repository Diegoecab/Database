set lines 900
DEFINE stat_name = '&1'
DEFINE parameter_name = '&2'
col value for a20
col statname for a40
col paramname for a40
select b.name as statname, p.name as paramname, max(a.value) as highest_val, p.value
from v$sesstat a, v$statname b, v$parameter p
where a.statistic# = b.statistic# 
and b.name like '%&stat_name%'
and p.name like '%&parameter_name%'
group by b.name, p.name, p.value;
