select  df_sp.tablespace_name, df_sp.megas total_df, free_sp.megas libres
from   
(
SELECT tablespace_name, sum(bytes)/1024/1024 megas
FROM   dba_free_space
group by tablespace_name ) free_sp,
(
select tablespace_name, sum(bytes)/1024/1024 megas
from   dba_data_files
group by tablespace_name) df_sp
where  free_sp.tablespace_name = df_sp.tablespace_name
/