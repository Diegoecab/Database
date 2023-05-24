--dba_constraints_fk_non_indexes.sql
col owner for a20 truncate
col table_name for a40 truncate
col column_name for a30 truncate

SELECT * FROM (
SELECT c.owner,c.table_name, cc.column_name, cc.position column_position
FROM   dba_constraints c, dba_cons_columns cc
WHERE  c.constraint_name = cc.constraint_name
AND    c.constraint_type = 'R'
MINUS
SELECT i.owner,i.table_name, ic.column_name, ic.column_position
FROM   dba_indexes i, dba_ind_columns ic
WHERE  i.index_name = ic.index_name
)
where owner like upper('%&OWNER%')
ORDER BY owner,table_name, column_position;