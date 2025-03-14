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
