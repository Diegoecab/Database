/* Ver el hit ratio de la Cache*/
SELECT (P1.value + P2.value - P3.value) / (P1.value + P2.value) "Cache Hit Ratio"
     FROM   v$sysstat P1, v$sysstat P2, v$sysstat P3
     WHERE  P1.name = 'db block gets'
     AND    P2.name = 'consistent gets'
     AND    P3.name = 'physical reads'
     
/* Cache hit ratio para una sesion especifica*/  
SELECT (P1.value + P2.value - P3.value) / (P1.value + P2.value)
     FROM   v$sesstat P1, v$statname N1, v$sesstat P2, v$statname N2,
            v$sesstat P3, v$statname N3
     WHERE  N1.name = 'db block gets'
     AND    P1.statistic# = N1.statistic#
     AND    P1.sid = <enter SID of session here>
     AND    N2.name = 'consistent gets'
     AND    P2.statistic# = N2.statistic#
     AND    P2.sid = P1.sid
     AND    N3.name = 'physical reads'
     AND    P3.statistic# = N3.statistic#
     AND    P3.sid = P1.sid     
     


 
/*Advice de DB_CACHE*/

SELECT SIZE_FOR_ESTIMATE "Tamaño cache (MB)", BUFFERS_FOR_ESTIMATE "Buffers",
       --ESTD_PHYSICAL_READ_FACTOR AS "ESTD PHYSIC Read Factor",
       ESTD_PHYSICAL_READS "Estimativo Lecturas Físicas"
  FROM V$DB_CACHE_ADVICE
 WHERE NAME = 'DEFAULT'
   AND BLOCK_SIZE = (SELECT VALUE
                       FROM V$PARAMETER
                      WHERE NAME = 'db_block_size')
   AND ADVICE_STATUS = 'ON';




/*Advice de DB_CACHE 16K*/
SELECT SIZE_FOR_ESTIMATE "Tamaño cache (MB)", BUFFERS_FOR_ESTIMATE "Buffers",
       --ESTD_PHYSICAL_READ_FACTOR AS "ESTD PHYSIC Read Factor",
       ESTD_PHYSICAL_READS "Estimativo Lecturas Físicas"
  FROM V$DB_CACHE_ADVICE
 WHERE NAME = 'DEFAULT'
   AND BLOCK_SIZE = 16384
   AND ADVICE_STATUS = 'ON';