set pagesize 999
set lines 190
col sql_text format a70 trunc
col child format 99999
col execs format 9,999
col avg_etime format 99,999.99
col "IO_SAVED_%" format 999.99
col avg_px format 999
col offload for a7

select * from (
select sql_id, inst_id, child_number child, plan_hash_value plan_hash, executions execs, to_char(LAST_ACTIVE_TIME,'DD-MM-YY HH24:MI:SS'),
(elapsed_time/1000000)/decode(nvl(executions,0),0,1,executions)/
decode(px_servers_executions,0,1,px_servers_executions/decode(nvl(executions,0),0,1,executions)) avg_etime,
px_servers_executions/decode(nvl(executions,0),0,1,executions) avg_px,
decode(IO_CELL_OFFLOAD_ELIGIBLE_BYTES,0,'No','Yes') Offload,
decode(IO_CELL_OFFLOAD_ELIGIBLE_BYTES,0,0,100*(IO_CELL_OFFLOAD_ELIGIBLE_BYTES-IO_INTERCONNECT_BYTES)
/decode(IO_CELL_OFFLOAD_ELIGIBLE_BYTES,0,1,IO_CELL_OFFLOAD_ELIGIBLE_BYTES)) "IO_SAVED_%",
sql_text
from gv$sql s
where 
sql_text not like 'BEGIN :sql_text := %'
and sql_text not like '%IO_CELL_OFFLOAD_ELIGIBLE_BYTES%'
and sql_text not like '/* SQL Analyze(%'
order by 1, 2, 3)
where Offload='Yes';



select a.name, b.value/1024/1024 mb from v$sysstat a, v$mystat b where a.statistic# = b.statistic# and (a.name in ('physical read total bytes', 'physical write total bytes','cell IO uncompressed bytes') or a.name like 'cell phy%');