SELECT B.NAME,DECODE (B.CLASS,
               1, 'User',
               2, 'Redo',
               4, 'Enqueue',
               8, 'Cache',
               16, 'OS',
               32, 'ParallelServer',
               64, 'SQL',
               128, 'Debug',
               72, 'SQL & Cache',
               40, 'ParallelServer & Cache'
              ) CLASS, A.VALUE
  FROM V$SESSTAT A, V$STATNAME B, V$SESSION C
 WHERE C.AUDSID = USERENV ('sessionid')
   AND A.SID = C.SID
   AND (A.STATISTIC# = B.STATISTIC#);