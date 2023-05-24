--all_tab_partitions_high_value.sql
col table_name for a30 truncate
col partition for a30 truncate
col high_value for a30 truncate
set pages 100
with xml as (
  select dbms_xmlgen.getxmltype('select table_name, partition_name, high_value from all_tab_partitions') as x
  from   dual
)
  select extractValue(rws.object_value, '/ROW/TABLE_NAME') table_name,
         extractValue(rws.object_value, '/ROW/PARTITION_NAME') partition,
         extractValue(rws.object_value, '/ROW/HIGH_VALUE') high_value
  from   xml x, 
         table(xmlsequence(extract(x.x, '/ROWSET/ROW'))) rws;