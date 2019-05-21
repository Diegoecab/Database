/* Para evitar el trabajo de I/O Innecesario puedo levantar objetos al keep (full caching)*/ 
/* Para levantar todos los bloques de una tabla a KEEP cache. Cualquier objeto que tengan mas del 80% de sus bloques de datos en el
buffer de datos*/

/*Hay que revisar el parametro db_keep_cache_size para que entren los objetos*/

/* Dar los siguientes grants con sys 
GRANT SELECT ON SYS.DBA_OBJECTS TO SYSTEM WITH GRANT OPTION;
GRANT SELECT ON SYS.DBA_SEGMENTS TO SYSTEM WITH GRANT OPTION;
*/

CREATE OR REPLACE VIEW OBJ_CANT_BLOQ
AS
   SELECT   O.OWNER OWNER, O.OBJECT_NAME OBJECT_NAME,
            O.SUBOBJECT_NAME SUBOBJECT_NAME, O.OBJECT_TYPE OBJECT_TYPE,
            COUNT (DISTINCT FILE# || BLOCK#) NUM_BLOCKS
       FROM DBA_OBJECTS O, V$BH BH
      WHERE O.DATA_OBJECT_ID = BH.OBJD
        AND O.OWNER NOT IN ('SYS', 'SYSTEM')
        AND BH.STATUS != 'free'
   GROUP BY O.OWNER, O.OBJECT_NAME, O.SUBOBJECT_NAME, O.OBJECT_TYPE
   ORDER BY COUNT (DISTINCT FILE# || BLOCK#) DESC;

CREATE OR REPLACE VIEW OBJETOS_TO_KEEP
AS
   SELECT   S.SEGMENT_TYPE, OBJ_CANT_BLOQ.OWNER, S.SEGMENT_NAME
       FROM OBJ_CANT_BLOQ, DBA_SEGMENTS S
      WHERE S.SEGMENT_NAME = OBJ_CANT_BLOQ.OBJECT_NAME
        AND S.OWNER = OBJ_CANT_BLOQ.OWNER
        AND S.SEGMENT_TYPE = OBJ_CANT_BLOQ.OBJECT_TYPE
        AND NVL (S.PARTITION_NAME, '-') =
                                       NVL (OBJ_CANT_BLOQ.SUBOBJECT_NAME, '-')
        AND BUFFER_POOL <> 'KEEP'
        AND OBJECT_TYPE IN ('TABLE', 'INDEX')
   GROUP BY S.SEGMENT_TYPE, OBJ_CANT_BLOQ.OWNER, S.SEGMENT_NAME
     HAVING (SUM (NUM_BLOCKS) / GREATEST (SUM (BLOCKS), .001)) * 100 > 80;

SELECT    'ALTER '
       || SEGMENT_TYPE
       || ' '
       || OWNER
       || '.'
       || SEGMENT_NAME
       || ' storage (buffer_pool keep);'
  FROM OBJETOS_TO_KEEP;

/* Consulta para ver el ratio hit de keep cache*/

/*(Para los objetos que estoy colocando exista la menor lectura fisica posible) Arriba del 95%*/

/* De otra forma hay q elevar el db_keep_cache_size*/

/* Normalmente se sube objetos al keep como tablas pequeñas y muy accedidas pero que salen rapido del buffer*/

SELECT NAME, PHYSICAL_READS, DB_BLOCK_GETS, CONSISTENT_GETS,
       1 - (PHYSICAL_READS / (DB_BLOCK_GETS + CONSISTENT_GETS)) "Hit Ratio"
  FROM V$BUFFER_POOL_STATISTICS;
  
  
  