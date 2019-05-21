col subpartition_count heading 'Subp|Cnt' for 99
col table_owner heading 'Table|Owner' for a20
col pct_Free heading 'Pct|Free' for 99
col composite heading 'Com|Po|Si|Te'
col buffer_pool heading 'Buffer|Pool' for a8
col partition_position heading 'Part|Posit' for 999
col high_value for a80
set linesize 350

SELECT
table_owner,table_name,composite,partition_name,partition_position,high_value,
subpartition_count,tablespace_name,pct_free,logging,compression,buffer_pool
FROM dba_tab_partitions where table_owner='&OWNER'
ORDER BY 1,2,5
/