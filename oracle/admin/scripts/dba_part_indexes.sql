col owner for a30
col table_name for a30
col index_name for a30
col column_name for a30

SELECT i.owner, C.TABLE_NAME,I.INDEX_NAME,I.PARTITIONING_TYPE, I.SUBPARTITIONING_TYPE, I.LOCALITY,I.ALIGNMENT,C.COLUMN_NAME,C.COLUMN_POSITION
FROM DBA_PART_INDEXES I JOIN DBA_IND_COLUMNS C
ON (I.INDEX_NAME = C.INDEX_NAME)
WHERE i.owner like upper('%&owner%') AND C.TABLE_NAME like upper('%&table_name%') AND UPPER(I.INDEX_NAME) like upper('%&index_name%')
ORDER BY 1,2,7;