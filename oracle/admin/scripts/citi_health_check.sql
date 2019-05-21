--citi_health_check.sql
col subpartition_count for 999
col table_owner for a20
col table_name for a30
col pct_free for 999
col composite for a3
col buffer_pool for a10
col partition_position for 9999
col high_value for a100
col mb for 99999
col interval for a30
set long 4000
set lines 400
set verify off
set pages 1000
set lines 400
set trims on
set verify off
col owner for a20
col object_name for a40
col sql for a80
col owner for a20
col degree for a3
col index_name for a30
col index_type for a25
col table_name for a30
col uniqueness for a10
col compression for a10
col per_clust_fact_x_t_num_rows for 999999

prompt  >> Tables that exist in dbadmin.dbs_tab_part but not (or interval is different) in dba_part_tables
select ownname, tabname, interval from dbadmin.dbs_tab_part a where interval is not null and not exists (
select 1 from dba_part_tables b where b.owner=a.ownname
and b.table_name=a.tabname and b.interval = a.interval)
/

prompt  >> Tables that exist in dba_part_tables but not (or interval is different) in dbadmin.dbs_tab_part
select owner, table_name, interval from dba_part_tables b where interval is not null and not exists (
select 1 from  dbadmin.dbs_tab_part a where b.owner=a.ownname
and b.table_name=a.tabname and b.interval = a.interval)
/

/*
prompt  >> Tablas que no tengan creada la particion para enero de 2015
select distinct table_owner, table_name from dba_tab_partitions a where partition_name like 'PARTITION_%' and
not exists (select 1 from dba_tab_partitions x where x.table_owner=a.table_owner and x.table_name = a.table_name
and x.partition_name like 'PARTITION_2015%')
and 
not exists (select 1 from dba_tab_partitions x where x.table_owner=a.table_owner and x.table_name = a.table_name
and x.partition_name like '%JAN15%')
and table_name not like '%_H'
and table_owner not like 'DBA_%'
and
not exists (select 1 from dba_part_tables z where z.owner=a.table_owner and z.table_name = a.table_name
and z.interval is not null)
/
*/

prompt >> Invalid Objects
SELECT   owner,
           object_type,
           object_name,
           created,
           status,
		   last_ddl_time,
           CASE object_type
              WHEN 'PACKAGE BODY'
              THEN
                    'ALTER PACKAGE '
                 || owner
                 || '.'
                 || object_name
                 || '  COMPILE BODY;'
              ELSE
                    'ALTER '
                 || object_type
                 || ' '
                 || owner
                 || '.'
                 || object_name
                 || '  compile;'
           END
              "SQL"
    FROM   dba_objects
   WHERE   status <> 'VALID'
ORDER BY   1, 2, 3
/


prompt >> Unusable indexes
select a.owner,a.index_name,a.index_type,a.table_name,a.uniqueness,a.tablespace_name,a.status, 'ALTER INDEX '||a.owner||'.'||a.index_name||' rebuild;' as rbld
from dba_indexes a, dba_tables b
where b.owner = a.owner
and b.table_name = a.table_name
and a.status = 'UNUSABLE'
order by 1,2,4
/

prompt >> Unusable index partitions
select index_owner,index_name,partition_name,subpartition_count,partition_position,high_value,tablespace_name,pct_free,compression,status
, 'ALTER INDEX '||index_owner||'.'||index_name||' rebuild partition '||partition_name||';' as rbld
from
dba_ind_partitions
where 
status = 'UNUSABLE'
order by 1,2,3
/
