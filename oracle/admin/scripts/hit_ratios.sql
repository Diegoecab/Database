SELECT 'Buffer Cache' NAME,
       ROUND (  (CONGETS.VALUE + DBGETS.VALUE - PHYSREADS.VALUE)
              * 100
              / (CONGETS.VALUE + DBGETS.VALUE),
              2
             ) VALUE
  FROM V$SYSSTAT CONGETS, V$SYSSTAT DBGETS, V$SYSSTAT PHYSREADS
 WHERE CONGETS.NAME = 'consistent gets'
   AND DBGETS.NAME = 'db block gets'
   AND PHYSREADS.NAME = 'physical reads'
UNION ALL
SELECT 'Execute/NoParse',
       DECODE (SIGN (ROUND (  (EC.VALUE - PC.VALUE)
                            * 100
                            / DECODE (EC.VALUE, 0, 1, EC.VALUE),
                            2
                           )
                    ),
               -1, 0,
               ROUND (  (EC.VALUE - PC.VALUE)
                      * 100
                      / DECODE (EC.VALUE, 0, 1, EC.VALUE),
                      2
                     )
              )
  FROM V$SYSSTAT EC, V$SYSSTAT PC
 WHERE EC.NAME = 'execute count'
   AND PC.NAME IN ('parse count', 'parse count (total)')
UNION ALL
SELECT 'Memory Sort',
       ROUND (  MS.VALUE
              / DECODE ((DS.VALUE + MS.VALUE), 0, 1, (DS.VALUE + MS.VALUE))
              * 100,
              2
             )
  FROM V$SYSSTAT DS, V$SYSSTAT MS
 WHERE MS.NAME = 'sorts (memory)' AND DS.NAME = 'sorts (disk)'
UNION ALL
SELECT 'SQL Area get hitrate', ROUND (GETHITRATIO * 100, 2)
  FROM V$LIBRARYCACHE
 WHERE NAMESPACE = 'SQL AREA'
UNION ALL
SELECT 'Avg Latch Hit (No Miss)',
       ROUND ((SUM (GETS) - SUM (MISSES)) * 100 / SUM (GETS), 2)
  FROM V$LATCH
UNION ALL
SELECT 'Avg Latch Hit (No Sleep)',
       ROUND ((SUM (GETS) - SUM (SLEEPS)) * 100 / SUM (GETS), 2)
  FROM V$LATCH;