--dba_ind_partitions_info.sql
/**********************************************************************  

 * File:        dba_ind_partitions_info.sql
 * Type:        SQL*Plus script
 *   
 *********************************************************************/  

clear col
undefine all
set lines 400
set feed off
set verify off
prompt (0 No Stats | < 6 Excellent | between 7 and 11 Good | between 12 and 21 Fair | > 21 Poor)
accept pct_cluster prompt "Enter value for pct_cluster: "

select i.owner, i.table_name, i.index_name, i.partion_name, t.num_rows, round(bytes/1024/1024) Mb, t.blocks, i.clustering_factor,
round(i.clustering_factor / t.num_rows * 100) pct_cluster,
case when nvl(i.clustering_factor,0) = 0                       then 'No Stats' 
     when nvl(t.num_rows,0) = 0                                then 'No Stats' 
     when (round(i.clustering_factor / t.num_rows * 100)) < 6  then 'Excellent    ' 
     when (round(i.clustering_factor / t.num_rows * 100)) between 7 and 11 then 'Good' 
     when (round(i.clustering_factor / t.num_rows * 100)) between 12 and 21 then 'Fair' 
     else                                                           'Poor' 
     end  index_quality,
i.avg_data_blocks_per_key, i.avg_leaf_blocks_per_key, segment_type,
to_char(o.created,'MM/DD/YYYY HH24:MI:SSSSS') Created  
from dba_ind_partitions i, dba_objects o, dba_tab_partitions t, dba_segments s
where o.owner like upper ('%&owner%') and o.object_name like upper ('%&index_name%')
and i.owner = o.owner
and i.index_name = o.object_name
and i.table_name = t.table_name
and t.owner = o.owner
and s.owner = o.owner
and s.segment_name = o.object_name
and s.segment_type = o.object_type
and o.object_type = 'INDEX PARTITION'
and bytes/1024/1024 > nvl('&Mb',0)
and round(i.clustering_factor / t.num_rows * 100) > nvl('&pct_cluster',-1)
order by 1,pct_cluster, mb
/