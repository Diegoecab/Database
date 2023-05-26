select * from (
select owner, segment_name, segment_type, 
(SELECT min(min_high_value) as min_high_value  from (
  SELECT
    TO_DATE(
                substr(
                    extractvalue(dbms_xmlgen.getxmltype(
                        'select high_value FROM DBA_TAB_PARTITIONS WHERE table_owner = ''' || t.table_owner || ''' and table_name = ''' || t.table_name || ''' and PARTITION_NAME = ''' || t.partition_name || ''''
                    ), '//text()')
                , 12, 10),
            'YYYY-MM-DD') AS min_high_value
  FROM DBA_TAB_PARTITIONS t where
t.table_owner=a.owner and t.table_name = a.segment_name and interval='YES')) min_high_value 
,
 count(*), round(sum(bytes)/1024/1024/1024) GB
from dba_Segments a
where owner like '%&OWNER%'
and segment_type='TABLE PARTITION'
group by owner, segment_name, segment_type
order by owner, min_high_value, GB)
where min_high_value < sysdate -6
/
