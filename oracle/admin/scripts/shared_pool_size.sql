/*Hit Ratio de Compartimiento de Cursores*/
SELECT NAMESPACE, GETHITRATIO
  FROM V$LIBRARYCACHE;


/*Si el ratio de recargas de pins es mayor al 1% debería aumentar el shared_pool_size*/
SELECT SUM (PINS) "Ejecuciones", SUM (RELOADS) "Cache Perdidos",
       SUM (RELOADS) / SUM (PINS) "Ratio Recargas Pins"
  FROM V$LIBRARYCACHE;


/*Busqueda de PL/SQL que no se mantiene en la cache de biblioteca*/
col name for a50
SELECT *
  FROM V$DB_OBJECT_CACHE
 WHERE SHARABLE_MEM > 10000
   AND TYPE IN ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
   AND KEPT = 'NO' ORDER BY 1,2;
   
SELECT OWNER,NAME,round(SHARABLE_MEM/1024) sharable_mem_KB,LOADS,EXECUTIONS,PINS,KEPT,INVALIDATIONS 
FROM V$DB_OBJECT_CACHE
 WHERE SHARABLE_MEM > 10000
   AND TYPE IN ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
   AND KEPT = 'NO' ORDER BY 1,2;
   
SELECT OWNER,round((sum(SHARABLE_MEM))/1024/1024) sharable_mem_MB
FROM V$DB_OBJECT_CACHE
 WHERE
 TYPE IN ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
   AND KEPT = 'NO' GROUP BY OWNER ORDER BY 2;

/*Bloques PL/SQL anonimos grandes que podrian que podrian estar guardados en la base y ejecutarlos con PL/SQL chicos*/
COL SQL_TEXT FOR A150
SELECT SQL_TEXT
  FROM V$SQLAREA
 WHERE COMMAND_TYPE = 47 AND LENGTH (SQL_TEXT) > 500;

