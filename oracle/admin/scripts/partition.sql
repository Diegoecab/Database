set long 2000
col pos format 999
col tablespace_name format a10
col subp# format 99999
col high_value format a200
set linesize 300
select partition_position pos, partition_name, tablespace_name, subpartition_count SubP#, high_value  
from dba_tab_partitions where table_name like upper('&1')
order by partition_position
/
set linesize 150
