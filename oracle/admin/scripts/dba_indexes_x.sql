REM
--dba_indexes_x
set verify off
set linesize 200
set pagesize 1000
col owner for a20
col degree heading 'Degree' for a3
col owner heading 'Owner'
col index_name heading 'Index Name'
col index_type heading 'Index Type' for a25
col table_name heading 'Table Name'
col uniqueness heading 'Uniqueness'
col compression heading 'Compression'
col per_clust_fact_x_t_num_rows heading 'Perc|Clus Fact|X|Table|Num Rows'
col clustering_Factor heading 'Clustering|Factor'
col t_num_rows heading 'Table|Num Rows'
col t_blocks heading 'Table|Blocks'

accept INDEX prompt 'Ingrese nombre de indice: '

select a.owner,a.index_name,a.index_type,a.table_name,a.uniqueness,a.compression,a.degree,a.clustering_factor,b.num_rows t_num_rows,b.blocks t_blocks,
round((a.clustering_factor*100)/b.num_rows,1) per_clust_fact_x_t_num_rows
from dba_indexes a, dba_tables b
where b.owner = a.owner
and b.num_rows <> 0
and b.table_name = a.table_name
and a.index_name=upper('&INDEX')
/