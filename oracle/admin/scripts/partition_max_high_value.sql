--partition_max_high_value.sql
--Diego Cabrera
col table_owner for a40
col table_name for a30
col interval for a30
set lines 900

select a.*, b.partitioning_type, b.subpartitioning_type, b.partition_count, b.status,b.interval  from
(SELECT table_owner, table_name, max(max_high_value) as max_high_value  from (
  SELECT table_owner, table_name,
    TO_DATE(
                substr(
                    extractvalue(dbms_xmlgen.getxmltype(
                        'select high_value FROM DBA_TAB_PARTITIONS WHERE table_owner = ''' || t.table_owner || ''' and table_name = ''' || t.table_name || ''' and PARTITION_NAME = ''' || t.partition_name || ''''
                    ), '//text()')
                , 13, 8),
            'YY-MM-DD') AS max_high_value
  FROM DBA_TAB_PARTITIONS t where
  t.table_owner like upper('%&owner%') and
t.table_name like upper('%&table_name%')
) group by table_owner, table_name) a,
dba_part_Tables b
where 
b.owner = a.table_owner 
and b.table_name = a.table_name
order by a.table_owner, a.table_name;
