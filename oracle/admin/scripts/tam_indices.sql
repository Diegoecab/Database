/*Para ver el tamaño de un índice*/

SELECT (SUM (BYTES) / 1024) / 1024 "Tamaño MB"
  FROM DBA_EXTENTS
 WHERE SEGMENT_NAME = ’nombre_indice’;