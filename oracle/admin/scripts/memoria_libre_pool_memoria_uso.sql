SELECT A.POOL " ", (A.BYTES / 1024) / 1024 || ' Megas' "Memoria Libre",
       (B.BYTES / 1024) / 1024 || ' Megas' "Memoria en uso"
  FROM V$SGASTAT A, V$SGASTAT B
 WHERE A.NAME = 'free memory' AND B.NAME = 'memory in use'  