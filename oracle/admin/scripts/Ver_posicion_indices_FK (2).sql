/*1 Ver todas las FK Y las ordenes de las columnas y comparar con los indices de las FK que tengas el mismo 
orden de columnas que las FK. Owner de FK GEM_TV*/
SELECT A.OWNER,A.TABLA,A.FOREIGN_KEY,A.COLUMNA,A.POSICION,B.INDICE,B.COLUMNA_INDICE,B.POSICION_INDICE,A.REF_OWNER,A.REF_PK,A.REF_TABLE_NAME            
  FROM (SELECT  a.*, b.column_name columna_indice,
               b.column_position posicion_indice
          FROM (SELECT /*+  RULE */
                       b.owner, b.table_name tabla,
                       a.constraint_name foreign_key, b.column_name columna,
                       b.POSITION posicion, c.owner ref_owner,
                       c.table_name ref_table_name,
                       a.r_constraint_name ref_pk,
                       a.constraint_name || '_I' indice
                  FROM dba_constraints a RIGHT JOIN dba_cons_columns b
                       ON a.constraint_name = b.constraint_name
                       JOIN dba_constraints c
                       ON a.r_constraint_name = c.constraint_name
                 WHERE a.constraint_type = 'R' AND a.owner IN ('GEM_TV')) a,
               dba_ind_columns b
         WHERE a.indice = b.index_name AND a.columna = b.column_name) a,
       (SELECT /*+ RULE */ a.*, b.column_name columna_indice,
               b.column_position posicion_indice
          FROM (SELECT /*+  RULE */
                       b.owner, b.table_name tabla,
                       a.constraint_name foreign_key, b.column_name columna,
                       b.POSITION posicion, c.owner ref_owner,
                       c.table_name ref_table_name,
                       a.r_constraint_name ref_pk,
                       a.constraint_name || '_I' indice
                  FROM dba_constraints a RIGHT JOIN dba_cons_columns b
                       ON a.constraint_name = b.constraint_name
                       JOIN dba_constraints c
                       ON a.r_constraint_name = c.constraint_name
                 WHERE a.constraint_type = 'R' AND a.owner IN ('GEM_TV')) a,
               dba_ind_columns b
         WHERE a.indice = b.index_name AND a.columna = b.column_name) b
 WHERE a.tabla = b.tabla
   AND a.foreign_key = b.foreign_key
   AND a.columna = b.columna
   AND a.columna_indice = b.columna_indice
   AND a.posicion != b.posicion_indice
   ORDER BY A.OWNER,A.TABLA,A.FOREIGN_KEY,A.POSICION