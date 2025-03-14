SELECT a.ksppinm "Parameter", b.KSPPSTDF "Default Value",
  2         b.ksppstvl "Session Value",
       c.ksppstvl "Instance Value",
       decode(bitand(a.ksppiflg/256,1),1,'TRUE','FALSE') IS_SESSION_MODIFIABLE,
       decode(bitand(a.ksppiflg/65536,3),1,'IMMEDIATE',2,'DEFERRED',3,'IMMEDIATE','FALSE') IS_SYSTEM_MODIFIABLE
FROM   sys.rds_x$ksppi a,
       sys.rds_x$ksppcv b,
       sys.rds_x$ksppsv c
WHERE  a.indx = b.indx
AND    a.indx = c.indx
AND    a.ksppinm LIKE '/_emon_send_timeout' escape '/';
