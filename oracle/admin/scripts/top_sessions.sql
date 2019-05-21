col sid for 9999
col machine_name for a50
set lines 400

select * from
(select b.sid sid,
     b.username user_name,
     d.spid os_id,
     b.machine machine_name,
     to_char(logon_time,'dd-mon-yy hh:mi:ss pm') logon_time,
    (sum(decode(c.name,'physical reads  ',value,0)) +
     sum(decode(c.name,'physical writes',value,0)) +
     sum(decode(c.name,'physical writes direct',value,0)) +
     sum(decode(c.name,'physical writes direct (lob)',value,0))+
     sum(decode(c.name,'physical reads  direct (lob)',value,0)) +
     sum(decode(c.name,'physical reads   direct',value,0)))
     total_physical_io,
    (sum(decode(c.name,'db block gets',value,0)) +
     sum(decode(c.name,'db block changes',value,0)) +
     sum(decode(c.name,'consistent changes',value,0)) +
     sum(decode(c.name,'consistent gets ',value,0)) )
     total_logical_io,
    (sum(decode(c.name,'session pga memory',value,0))+
     sum(decode(c.name,'session uga memory',value,0)) )
     total_memory_usage,
     sum(decode(c.name,'parse count (total)',value,0)) parses,
     sum(decode(c.name,'cpu used by this session',value,0))
     total_cpu,
     sum(decode(c.name,'parse time cpu',value,0)) parse_cpu,
     sum(decode(c.name,'recursive cpu usage',value,0))
       recursive_cpu,
     sum(decode(c.name,'cpu used by this session',value,0)) -
     sum(decode(c.name,'parse time cpu',value,0)) -
     sum(decode(c.name,'recursive cpu usage',value,0))
       other_cpu,
     sum(decode(c.name,'sorts (disk)',value,0)) disk_sorts,
     sum(decode(c.name,'sorts (memory)',value,0)) memory_sorts,
     sum(decode(c.name,'sorts (rows)',value,0)) rows_sorted,
     sum(decode(c.name,'user commits',value,0)) commits,
     sum(decode(c.name,'user rollbacks',value,0)) rollbacks,
     sum(decode(c.name,'execute count',value,0)) executions
from sys.v_$sesstat  a,
     sys.v_$session b,
     sys.v_$statname c,
     sys.v_$process d
	 --,sys.v_$bgprocess e
where a.statistic#=c.statistic# 
and b.paddr = d.addr
--and e.paddr = d.addr
and b.username is not null
group by b.sid,
         d.spid,
         b.username,
         b.machine,
         to_char(logon_time,'dd-mon-yy hh:mi:ss pm')
order by 10 desc)
where rownum < 50
/