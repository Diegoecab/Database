set pagesize 100
col index_owner for a30
col index_name for a40
col column_name for a30
accept OWNER_TABLA prompt 'Ingrese Owner de la tabla: '
accept NOMBRE_TABLA prompt 'Ingrese Nombre de Tabla: '
SELECT index_owner,index_name,column_name,column_position
FROM dba_ind_columns 
WHERE table_owner=UPPER('&OWNER_TABLA')
AND
table_name=UPPER('&NOMBRE_TABLA')
/
