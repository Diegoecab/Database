- First find the list of tables which have LOB columns (Query the data using your source schema or DMS user)

select col.owner as schema_name,
col.table_name,
count(*) as column_count
from sys.all_tab_columns col
inner join sys.all_tables t on col.owner = t.owner
and col.table_name = t.table_name
where col.data_type in ('BLOB', 'CLOB', 'NCLOB', 'BFILE')
-- excluding some Oracle maintained schemas
and col.owner not in ('ANONYMOUS','CTXSYS','DBSNMP','EXFSYS', 'LBACSYS',
'MDSYS', 'MGMT_VIEW','OLAPSYS','OWBSYS','ORDPLUGINS', 'ORDSYS','OUTLN',
'SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM', 'TSMSYS','WK_TEST',
'WKPROXY','WMSYS','XDB','APEX_040000', 'APEX_PUBLIC_USER','DIP', 'WKSYS',
'FLOWS_30000','FLOWS_FILES','MDDATA', 'ORACLE_OCM', 'XS$NULL',
'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'PUBLIC')
group by col.owner,
col.table_name
order by col.owner,
col.table_name;


- Then you can check each column/table to find the LOB size

SELECT DBMS_LOB.GetLength(<CLOB_DATA>)/1024/1024 AS SizeMB from <TABLE_NAME> order by <CLOB_DATA> desc;


-- Extra references provided by the vendor:

-- How to determine the actual size of the LOB segments and how to free the deleted/unused space above/below the HWM (Doc ID 386341.1)
-- How to Calculate Space Used by LOB Segments in the Database (Doc ID 369883.1)
