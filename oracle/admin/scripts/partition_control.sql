set linesize 180
select TP.TABLE_OWNER, TP.TABLE_NAME, tp.partition_name,NUM_ROWS, LAST_ANALYZED
 from
 ( select table_name, max(partition_position) max
   from dba_tab_partitions
   WHERE TABLE_owner NOT IN ( 'SYS','SYSTEM')
   group by table_name ) aux,
   dba_tab_partitions tp
 where  tp.table_name = aux.table_name
   and  tp.partition_position = aux.max
   and  TABLE_owner NOT IN ( 'SYS','SYSTEM')
   AND (NUM_ROWS > 0 OR TRUNC(LAST_ANALYZED) <= TRUNC(SYSDATE) - 15) 
/
