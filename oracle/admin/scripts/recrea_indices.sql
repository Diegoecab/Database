/* Script para detectar indices de FK en donde la posicion de la columnas del indice difiera

de la posicion de las columnas en la FK */



/* Creacion de una vista donde detecta diferencias en las posiciones*/


CREATE OR REPLACE VIEW LISTA_COL_POSIC
AS
   SELECT   A.OWNER OWNER_CONSTRAINT, A.TABLE_NAME TABLA,
            A.CONSTRAINT_NAME CONSTRAINT, B.COLUMN_NAME COLUMNA_EN_FK,
            B.POSITION POSICION_EN_FK, C.INDEX_OWNER OWNER_INDICE,
            C.INDEX_NAME INDICE, C.COLUMN_NAME COLUMNA_EN_IND,
            C.COLUMN_POSITION POSICION_EN_IND
       FROM DBA_CONSTRAINTS A JOIN DBA_CONS_COLUMNS B
            ON B.CONSTRAINT_NAME = A.CONSTRAINT_NAME
            JOIN ALL_IND_COLUMNS C
            ON C.INDEX_NAME = A.CONSTRAINT_NAME || '_I'
          AND C.COLUMN_NAME = B.COLUMN_NAME
          AND C.COLUMN_POSITION != B.POSITION
      WHERE A.OWNER IN ('GEM_GRL', 'GEM_TV', 'GEM_IFZ')
        AND A.CONSTRAINT_TYPE = 'R'
   ORDER BY A.OWNER, A.TABLE_NAME, A.CONSTRAINT_NAME, B.POSITION
/


/* Armado de scripts */

SELECT 'BEGIN 
DBMS_OUTPUT.PUT_LINE(''RECREANDO INDICE '||A.OWNER||'.'||A.CONSTRAINT_NAME||'_I'' );
END;
/
DROP INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ;
    CREATE INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ON '
       || A.OWNER
       || '.'
       || A.TABLE_NAME
       || '
    ('
       || A.COLUMN_NAME
       || ') TABLESPACE &TABLESPACE_INDICE ; '
  FROM DBA_CONS_COLUMNS A
 WHERE A.CONSTRAINT_NAME IN (
          SELECT V.CONSTRAINT_NAME
            FROM (SELECT   CONSTRAINT_NAME,
                           COUNT (COLUMN_NAME) AS CANTIDAD_COLUMNAS
                      FROM DBA_CONS_COLUMNS
                  GROUP BY CONSTRAINT_NAME) V
           WHERE CANTIDAD_COLUMNAS = 1)
   AND A.CONSTRAINT_NAME IN (SELECT CONSTRAINT
                               FROM LISTA_COL_POSIC)
UNION
/*2 Columnas*/
SELECT 'BEGIN 
DBMS_OUTPUT.PUT_LINE(''RECREANDO INDICE '||A.OWNER||'.'||A.CONSTRAINT_NAME||'_I'' );
END;
/ 
DROP INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ;
    CREATE INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ON '
       || A.OWNER
       || '.'
       || A.TABLE_NAME
       || '
    ('
       || A.COLUMN_NAME
       || ','
       || B.COLUMN_NAME
       || ') TABLESPACE &TABLESPACE_INDICE ; '
  FROM DBA_CONS_COLUMNS A, DBA_CONS_COLUMNS B
 WHERE B.OWNER = A.OWNER
   AND B.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND B.TABLE_NAME = A.TABLE_NAME
   AND A.POSITION = 1
   AND B.POSITION = 2
   AND A.CONSTRAINT_NAME IN (
          SELECT V.CONSTRAINT_NAME
            FROM (SELECT   CONSTRAINT_NAME,
                           COUNT (COLUMN_NAME) AS CANTIDAD_COLUMNAS
                      FROM DBA_CONS_COLUMNS
                  GROUP BY CONSTRAINT_NAME) V
           WHERE CANTIDAD_COLUMNAS = 2)
   AND A.CONSTRAINT_NAME IN (SELECT CONSTRAINT
                               FROM LISTA_COL_POSIC)
UNION
/* 3 Columnas*/
SELECT 'BEGIN 
DBMS_OUTPUT.PUT_LINE(''RECREANDO INDICE '||A.OWNER||'.'||A.CONSTRAINT_NAME||'_I'' );
END;
/ 
DROP INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ;
    CREATE INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ON '
       || A.OWNER
       || '.'
       || A.TABLE_NAME
       || '
    ('
       || A.COLUMN_NAME
       || ','
       || B.COLUMN_NAME
       || ','
       || C.COLUMN_NAME
       || ') TABLESPACE &TABLESPACE_INDICE ; '
  FROM DBA_CONS_COLUMNS A, DBA_CONS_COLUMNS B, DBA_CONS_COLUMNS C
 WHERE B.OWNER = A.OWNER
   AND B.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND B.TABLE_NAME = A.TABLE_NAME
   AND A.POSITION = 1
   AND B.POSITION = 2
   AND C.OWNER = A.OWNER
   AND C.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND C.TABLE_NAME = A.TABLE_NAME
   AND C.POSITION = 3
   AND A.CONSTRAINT_NAME IN (
          SELECT V.CONSTRAINT_NAME
            FROM (SELECT   CONSTRAINT_NAME,
                           COUNT (COLUMN_NAME) AS CANTIDAD_COLUMNAS
                      FROM DBA_CONS_COLUMNS
                  GROUP BY CONSTRAINT_NAME) V
           WHERE CANTIDAD_COLUMNAS = 3)
   AND A.CONSTRAINT_NAME IN (SELECT CONSTRAINT
                               FROM LISTA_COL_POSIC)
UNION
/* 4 Columnas*/
SELECT 'BEGIN 
DBMS_OUTPUT.PUT_LINE(''RECREANDO INDICE '||A.OWNER||'.'||A.CONSTRAINT_NAME||'_I'' );
END;
/ 
DROP INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ;
    CREATE INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ON '
       || A.OWNER
       || '.'
       || A.TABLE_NAME
       || '
    ('
       || A.COLUMN_NAME
       || ','
       || B.COLUMN_NAME
       || ','
       || C.COLUMN_NAME
       || ','
       || D.COLUMN_NAME
       || ') TABLESPACE &TABLESPACE_INDICE ; '
  FROM DBA_CONS_COLUMNS A,
       DBA_CONS_COLUMNS B,
       DBA_CONS_COLUMNS C,
       DBA_CONS_COLUMNS D
 WHERE B.OWNER = A.OWNER
   AND B.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND B.TABLE_NAME = A.TABLE_NAME
   AND A.POSITION = 1
   AND B.POSITION = 2
   AND C.OWNER = A.OWNER
   AND C.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND C.TABLE_NAME = A.TABLE_NAME
   AND C.POSITION = 3
   AND D.OWNER = A.OWNER
   AND D.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND D.TABLE_NAME = A.TABLE_NAME
   AND D.POSITION = 4
   AND A.CONSTRAINT_NAME IN (
          SELECT V.CONSTRAINT_NAME
            FROM (SELECT   CONSTRAINT_NAME,
                           COUNT (COLUMN_NAME) AS CANTIDAD_COLUMNAS
                      FROM DBA_CONS_COLUMNS
                  GROUP BY CONSTRAINT_NAME) V
           WHERE CANTIDAD_COLUMNAS = 4)
   AND A.CONSTRAINT_NAME IN (SELECT CONSTRAINT
                               FROM LISTA_COL_POSIC)
UNION
/* 5 Columnas*/
SELECT 'BEGIN 
DBMS_OUTPUT.PUT_LINE(''RECREANDO INDICE '||A.OWNER||'.'||A.CONSTRAINT_NAME||'_I'' );
END;
/ 
DROP INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ;
    CREATE INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ON '
       || A.OWNER
       || '.'
       || A.TABLE_NAME
       || '
    ('
       || A.COLUMN_NAME
       || ','
       || B.COLUMN_NAME
       || ','
       || C.COLUMN_NAME
       || ','
       || D.COLUMN_NAME
       || ','
       || E.COLUMN_NAME
       || ') TABLESPACE &TABLESPACE_INDICE ; '
  FROM DBA_CONS_COLUMNS A,
       DBA_CONS_COLUMNS B,
       DBA_CONS_COLUMNS C,
       DBA_CONS_COLUMNS D,
       DBA_CONS_COLUMNS E
 WHERE B.OWNER = A.OWNER
   AND B.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND B.TABLE_NAME = A.TABLE_NAME
   AND A.POSITION = 1
   AND B.POSITION = 2
   AND C.OWNER = A.OWNER
   AND C.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND C.TABLE_NAME = A.TABLE_NAME
   AND C.POSITION = 3
   AND D.OWNER = A.OWNER
   AND D.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND D.TABLE_NAME = A.TABLE_NAME
   AND D.POSITION = 4
   AND E.OWNER = A.OWNER
   AND E.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND E.TABLE_NAME = A.TABLE_NAME
   AND E.POSITION = 5
   AND A.CONSTRAINT_NAME IN (
          SELECT V.CONSTRAINT_NAME
            FROM (SELECT   CONSTRAINT_NAME,
                           COUNT (COLUMN_NAME) AS CANTIDAD_COLUMNAS
                      FROM DBA_CONS_COLUMNS
                  GROUP BY CONSTRAINT_NAME) V
           WHERE CANTIDAD_COLUMNAS = 5)
   AND A.CONSTRAINT_NAME IN (SELECT CONSTRAINT
                               FROM LISTA_COL_POSIC)
UNION
/* 6 Columnas*/
SELECT 'BEGIN 
DBMS_OUTPUT.PUT_LINE(''RECREANDO INDICE '||A.OWNER||'.'||A.CONSTRAINT_NAME||'_I'' );
END;
/ 
DROP INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ;
    CREATE INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ON '
       || A.OWNER
       || '.'
       || A.TABLE_NAME
       || '
    ('
       || A.COLUMN_NAME
       || ','
       || B.COLUMN_NAME
       || ','
       || C.COLUMN_NAME
       || ','
       || D.COLUMN_NAME
       || ','
       || E.COLUMN_NAME
       || ','
       || F.COLUMN_NAME
       || ') TABLESPACE &TABLESPACE_INDICE ; '
  FROM DBA_CONS_COLUMNS A,
       DBA_CONS_COLUMNS B,
       DBA_CONS_COLUMNS C,
       DBA_CONS_COLUMNS D,
       DBA_CONS_COLUMNS E,
       DBA_CONS_COLUMNS F
 WHERE B.OWNER = A.OWNER
   AND B.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND B.TABLE_NAME = A.TABLE_NAME
   AND A.POSITION = 1
   AND B.POSITION = 2
   AND C.OWNER = A.OWNER
   AND C.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND C.TABLE_NAME = A.TABLE_NAME
   AND C.POSITION = 3
   AND D.OWNER = A.OWNER
   AND D.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND D.TABLE_NAME = A.TABLE_NAME
   AND D.POSITION = 4
   AND E.OWNER = A.OWNER
   AND E.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND E.TABLE_NAME = A.TABLE_NAME
   AND E.POSITION = 5
   AND F.OWNER = A.OWNER
   AND F.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND F.TABLE_NAME = A.TABLE_NAME
   AND F.POSITION = 6
   AND A.CONSTRAINT_NAME IN (
          SELECT V.CONSTRAINT_NAME
            FROM (SELECT   CONSTRAINT_NAME,
                           COUNT (COLUMN_NAME) AS CANTIDAD_COLUMNAS
                      FROM DBA_CONS_COLUMNS
                  GROUP BY CONSTRAINT_NAME) V
           WHERE CANTIDAD_COLUMNAS = 6)
   AND A.CONSTRAINT_NAME IN (SELECT CONSTRAINT
                               FROM LISTA_COL_POSIC)
UNION
/* 7 Columnas*/
SELECT 'BEGIN 
DBMS_OUTPUT.PUT_LINE(''RECREANDO INDICE '||A.OWNER||'.'||A.CONSTRAINT_NAME||'_I'' );
END;
/ 
DROP INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ;
    CREATE INDEX '
       || A.OWNER
       || '.'
       || A.CONSTRAINT_NAME
       || '_I ON '
       || A.OWNER
       || '.'
       || A.TABLE_NAME
       || '
    ('
       || A.COLUMN_NAME
       || ','
       || B.COLUMN_NAME
       || ','
       || C.COLUMN_NAME
       || ','
       || D.COLUMN_NAME
       || ','
       || E.COLUMN_NAME
       || ','
       || F.COLUMN_NAME
       || ') TABLESPACE &TABLESPACE_INDICE ; '
  FROM DBA_CONS_COLUMNS A,
       DBA_CONS_COLUMNS B,
       DBA_CONS_COLUMNS C,
       DBA_CONS_COLUMNS D,
       DBA_CONS_COLUMNS E,
       DBA_CONS_COLUMNS F,
       DBA_CONS_COLUMNS G
 WHERE B.OWNER = A.OWNER
   AND B.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND B.TABLE_NAME = A.TABLE_NAME
   AND A.POSITION = 1
   AND B.POSITION = 2
   AND C.OWNER = A.OWNER
   AND C.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND C.TABLE_NAME = A.TABLE_NAME
   AND C.POSITION = 3
   AND D.OWNER = A.OWNER
   AND D.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND D.TABLE_NAME = A.TABLE_NAME
   AND D.POSITION = 4
   AND E.OWNER = A.OWNER
   AND E.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND E.TABLE_NAME = A.TABLE_NAME
   AND E.POSITION = 5
   AND F.OWNER = A.OWNER
   AND F.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND F.TABLE_NAME = A.TABLE_NAME
   AND F.POSITION = 6
   AND G.OWNER = A.OWNER
   AND G.CONSTRAINT_NAME = A.CONSTRAINT_NAME
   AND G.TABLE_NAME = A.TABLE_NAME
   AND G.POSITION = 7
   AND A.CONSTRAINT_NAME IN (
          SELECT V.CONSTRAINT_NAME
            FROM (SELECT   CONSTRAINT_NAME,
                           COUNT (COLUMN_NAME) AS CANTIDAD_COLUMNAS
                      FROM DBA_CONS_COLUMNS
                  GROUP BY CONSTRAINT_NAME) V
           WHERE CANTIDAD_COLUMNAS = 7)
   AND A.CONSTRAINT_NAME IN (SELECT CONSTRAINT
                               FROM LISTA_COL_POSIC)
