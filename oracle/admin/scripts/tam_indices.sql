/*Para ver el tama�o de un �ndice*/

SELECT (SUM (BYTES) / 1024) / 1024 "Tama�o MB"
  FROM DBA_EXTENTS
 WHERE SEGMENT_NAME = �nombre_indice�;