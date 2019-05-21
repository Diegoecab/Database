/*1 Ver todas las FK Y las ordenes de las columnas y comparar con los indices de las FK que tengas el mismo 
orden de columnas que las FK. Owner de FK GEM_TV*/
CREATE TABLE T1 TABLESPACE GEMDATMM AS
SELECT A.OWNER,A.TABLA,A.FOREIGN_KEY,A.COLUMNA,A.POSICION,B.INDICE,B.COLUMNA_INDICE,B.POSICION_INDICE,A.REF_OWNER,A.REF_PK,A.REF_TABLE_NAME            
  FROM (SELECT  a.*, b.column_name columna_indice,
               b.column_position posicion_indice
          FROM (SELECT /*+  RULE */
                       b.owner, b.table_name tabla,
                       a.constraint_name foreign_key, b.column_name columna,
                       b.POSITION posicion, c.owner ref_owner,
                       c.table_name ref_table_name,
                       a.r_constraint_name ref_pk,
                       a.constraint_name || '_I' indice
                  FROM dba_constraints a RIGHT JOIN dba_cons_columns b
                       ON a.constraint_name = b.constraint_name
                       JOIN dba_constraints c
                       ON a.r_constraint_name = c.constraint_name
                 WHERE a.constraint_type = 'R' AND a.owner IN ('GEM_TV')) a,
               dba_ind_columns b
         WHERE a.indice = b.index_name AND a.columna = b.column_name) a,
       (SELECT /*+ RULE */ a.*, b.column_name columna_indice,
               b.column_position posicion_indice
          FROM (SELECT /*+  RULE */
                       b.owner, b.table_name tabla,
                       a.constraint_name foreign_key, b.column_name columna,
                       b.POSITION posicion, c.owner ref_owner,
                       c.table_name ref_table_name,
                       a.r_constraint_name ref_pk,
                       a.constraint_name || '_I' indice
                  FROM dba_constraints a RIGHT JOIN dba_cons_columns b
                       ON a.constraint_name = b.constraint_name
                       JOIN dba_constraints c
                       ON a.r_constraint_name = c.constraint_name
                 WHERE a.constraint_type = 'R' AND a.owner IN ('GEM_TV')) a,
               dba_ind_columns b
         WHERE a.indice = b.index_name AND a.columna = b.column_name) b
 WHERE a.tabla = b.tabla
   AND a.foreign_key = b.foreign_key
   AND a.columna = b.columna
   AND a.columna_indice = b.columna_indice
   AND a.posicion != b.posicion_indice
   ORDER BY A.OWNER,A.TABLA,A.FOREIGN_KEY,A.POSICION;


CREATE TABLE T2
(
  OWNER            VARCHAR2(30 BYTE),
  TABLA            VARCHAR2(30 BYTE),
  FOREIGN_KEY      VARCHAR2(30 BYTE),
  COLUMNA          VARCHAR2(4000 BYTE),
  POSICION         NUMBER,
  INDICE           VARCHAR2(32 BYTE),
  COLUMNA_INDICE   VARCHAR2(4000 BYTE),
  POSICION_INDICE  NUMBER,
  REF_OWNER        VARCHAR2(30 BYTE),
  REF_PK           VARCHAR2(30 BYTE),
  REF_TABLE_NAME   VARCHAR2(30 BYTE)
)
TABLESPACE GEMDATMM
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          5M
            NEXT             5M
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE OR REPLACE TRIGGER TRIGGER1
BEFORE INSERT
ON T2
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
VAR VARCHAR2 (255);
VAR2 VARCHAR2 (255);
BEGIN
     DELETE FROM T2 WHERE OWNER=:NEW.OWNER AND FOREIGN_KEY=:NEW.FOREIGN_KEY AND INDICE=:NEW.INDICE AND COLUMNA_INDICE=:NEW.COLUMNA_INDICE;
     SELECT TABLA INTO VAR FROM T2 WHERE TABLA=:NEW.TABLA;
     IF VAR IS NOT NULL THEN  
     :NEW.TABLA:=NULL;
     ELSE NULL;
     END IF;     
      SELECT FOREIGN_KEY INTO VAR2 FROM T2 WHERE FOREIGN_KEY=:NEW.FOREIGN_KEY;
     IF VAR2 IS NOT NULL THEN  
     :NEW.FOREIGN_KEY:=NULL;
     ELSE NULL;
     END IF;     
     EXCEPTION WHEN NO_DATA_FOUND THEN null;
END;
/
SHOW ERRORS;

TRUNCATE TABLE T2;







***************************************************************************************************************************



/*4 Columnas*/
SELECT    'DROP INDEX '
       || a.owner
       || '.'
       || a.constraint_name
       || '_I;
    CREATE INDEX '
       || a.owner
       || '.'
       || a.constraint_name
       || '_I ON '
       || a.owner
       || '.'
       || a.table_name
       || '
    ('
       || a.column_name
       || ','
       || b.column_name
       || ','
       || c.column_name
       || ','
       || d.column_name
       || ') TABLESPACE GEMIDXSS ;'
  FROM dba_cons_columns a JOIN dba_cons_columns b
       ON b.table_name = a.table_name
          AND b.constraint_name = a.constraint_name
       JOIN dba_cons_columns c
       ON c.table_name = b.table_name
          AND c.constraint_name = b.constraint_name
          JOIN dba_cons_columns d
       ON d.table_name = c.table_name
          AND d.constraint_name = c.constraint_name
 WHERE a.table_name = 'PUP_RATING'
   AND a.constraint_name IN (SELECT foreign_key
                               FROM t1
                              WHERE tabla = 'PUP_RATING')
   AND a.POSITION = 1
   AND b.POSITION = 2
   AND c.POSITION = 3
   AND d.POSITION = 4;




***************************************************************************************************************************

/*3 Columnas*/
SELECT    'DROP INDEX '
       || a.owner
       || '.'
       || a.constraint_name
       || '_I;
    CREATE INDEX '
       || a.owner
       || '.'
       || a.constraint_name
       || '_I ON '
       || a.owner
       || '.'
       || a.table_name
       || '
    ('
       || a.column_name
       || ','
       || b.column_name
       || ','
       || c.column_name
       || ') TABLESPACE GEMIDXSS ;'
  FROM dba_cons_columns a JOIN dba_cons_columns b
       ON b.table_name = a.table_name
          AND b.constraint_name = a.constraint_name
       JOIN dba_cons_columns c
       ON c.table_name = b.table_name
          AND c.constraint_name = b.constraint_name
 WHERE a.table_name = 'PUP_RATING'
   AND a.constraint_name IN (SELECT foreign_key
                               FROM t1
                              WHERE tabla = 'PUP_RATING')
   AND a.POSITION = 1
   AND b.POSITION = 2
   AND c.POSITION = 3;


***************************************************************************************************************************


/*2 Columnas*/
SELECT    'DROP INDEX '
       || a.owner
       || '.'
       || a.constraint_name
       || '_I;
    CREATE INDEX '
       || a.owner
       || '.'
       || a.constraint_name
       || '_I ON '
       || a.owner
       || '.'
       || a.table_name
       || '
    ('
       || a.column_name
       || ','
       || b.column_name
       || ') TABLESPACE GEMIDXSS ;'
  FROM dba_cons_columns a JOIN dba_cons_columns b
       ON b.table_name = a.table_name
          AND b.constraint_name = a.constraint_name
 WHERE a.table_name = 'PUP_PROVISION_AGEN_X_CONTRATO'
   AND a.constraint_name IN (SELECT foreign_key
                               FROM t1
                              WHERE tabla = 'PUP_PROVISION_AGEN_X_CONTRATO')
   AND a.POSITION = 1
   AND b.POSITION = 2;


***************************************************************************************************************************


Scripts corridos en 23/05/08 En Prod:


DROP INDEX GEM_TV.AVI_CINV_FK_I;
    CREATE INDEX GEM_TV.AVI_CINV_FK_I ON GEM_TV.PUP_AVISOS
    (PUC_CODIGO,CINV_CODIGO,EMP_CODIGO) TABLESPACE GEMIDXSS ;


DROP INDEX GEM_TV.AVI_ORD_ITE_FK_I;
    CREATE INDEX GEM_TV.AVI_ORD_ITE_FK_I ON GEM_TV.PUP_AVISOS
    (EMP_CODIGO,ORD_NUMERO,AVI_ITEM) TABLESPACE GEMIDXSS ;    
    
    
DROP INDEX GEM_TV.AVM_CINV_FK_I;
    CREATE INDEX GEM_TV.AVM_CINV_FK_I ON GEM_TV.PUP_AVISOS_MOVIMIENTOS
    (PUC_CODIGO,CINV_CODIGO,EMP_CODIGO) TABLESPACE GEMIDXSS ;    
    
DROP INDEX GEM_TV.AVM_PRO_FK_I;
    CREATE INDEX GEM_TV.AVM_PRO_FK_I ON GEM_TV.PUP_AVISOS_MOVIMIENTOS
    (EMP_CODIGO,SEN_CODIGO,PRO_FECHA) TABLESPACE GEMIDXSS ;    


DROP INDEX GEM_TV.CINV_SEN_CANJE_FK_I;
    CREATE INDEX GEM_TV.CINV_SEN_CANJE_FK_I ON GEM_TV.PUP_CON_INVERSION
    (EMP_CODIGO,SEN_CODIGO_CANJE) TABLESPACE GEMIDXSS ;
    

DROP INDEX GEM_TV.CICU_CINV_FK_I;
    CREATE INDEX GEM_TV.CICU_CINV_FK_I ON GEM_TV.PUP_CON_INVERSION_CUOTAS
    (PUC_CODIGO,CINV_CODIGO,EMP_CODIGO) TABLESPACE GEMIDXSS ;        
    
DROP INDEX GEM_TV.MEME_TIIC_FK_I;
    CREATE INDEX GEM_TV.MEME_TIIC_FK_I ON GEM_TV.PUP_METAS_MENSUALES
    (EMP_CODIGO,TIIC_CODIGO) TABLESPACE GEMIDXSS ;


DROP INDEX GEM_TV.ORD_CINV_FK_I;
    CREATE INDEX GEM_TV.ORD_CINV_FK_I ON GEM_TV.PUP_ORDENES
    (PUC_CODIGO,CINV_CODIGO,EMP_CODIGO) TABLESPACE GEMIDXSS ;

DROP INDEX GEM_TV.ORD_TEM_FK_I;
    CREATE INDEX GEM_TV.ORD_TEM_FK_I ON GEM_TV.PUP_ORDENES
    (TEM_CODIGO,PRD_CODIGO) TABLESPACE GEMIDXSS ;


DROP INDEX GEM_TV.CAC_CINV_FK_I;
    CREATE INDEX GEM_TV.CAC_CINV_FK_I ON GEM_TV.PUP_PROVISION_AGEN_X_CONTRATO
    (PUC_CODIGO,CINV_CODIGO,EMP_CODIGO) TABLESPACE GEMIDXSS ;


DROP INDEX GEM_TV.RATI_SEG_FK_I;
    CREATE INDEX GEM_TV.RATI_SEG_FK_I ON GEM_TV.PUP_RATING
    (EMP_CODIGO,SEN_CODIGO,SEG_CODIGO) TABLESPACE GEMIDXSS ;
    
DROP INDEX GEM_TV.CIC_GRP_FK_I;
    CREATE INDEX GEM_TV.CIC_GRP_FK_I ON GEM_TV.PRO_CICLOS
    (EMP_CODIGO,GRP_CODIGO) TABLESPACE GEMIDXSS ;
    
DROP INDEX GEM_TV.SEME_SEG_FK_I;
    CREATE INDEX GEM_TV.SEME_SEG_FK_I ON GEM_TV.PRO_SEGMENTO_MEDIDORA
    (EMP_CODIGO,SEN_CODIGO,SEG_CODIGO) TABLESPACE GEMIDXSS ;        

DROP INDEX GEM_TV.PDD_PRO_FK_I;
    CREATE INDEX GEM_TV.PDD_PRO_FK_I ON GEM_TV.PRO_PROGRAMACION_DIA_DETALLES
    (EMP_CODIGO,SEN_CODIGO,PRO_FECHA) TABLESPACE GEMIDXSS ;    

DROP INDEX GEM_TV.PDD_SEG_FK_I;
    CREATE INDEX GEM_TV.PDD_SEG_FK_I ON GEM_TV.PRO_PROGRAMACION_DIA_DETALLES
    (EMP_CODIGO_SEG,SEN_CODIGO_SEG,SEG_CODIGO) TABLESPACE GEMIDXSS ;

DROP INDEX GEM_TV.PDD_CON_FK_I;
    CREATE INDEX GEM_TV.PDD_CON_FK_I ON GEM_TV.PRO_PROGRAMACION_DIA_DETALLES
    (EMP_CODIGO,CON_NUMERO) TABLESPACE GEMIDXSS ;


DROP INDEX GEM_TV.ASIE_CINV_FK_I;
    CREATE INDEX GEM_TV.ASIE_CINV_FK_I ON GEM_TV.TV_ASIENTOS
    (PUC_CODIGO,CINV_CODIGO,EMP_CODIGO) TABLESPACE GEMIDXSS ;
    
DROP INDEX GEM_TV.PRO_PAIM_CEN_FK_I;
    CREATE INDEX GEM_TV.PRO_PAIM_CEN_FK_I ON GEM_TV.TV_ASIENTOS
    (EMP_CODIGO,CON_NUMERO,CEN_CODIGO) TABLESPACE GEMIDXSS ;


DROP INDEX GEM_TV.PRO_PAIM_CON_FK_I;
    CREATE INDEX GEM_TV.PRO_PAIM_CON_FK_I ON GEM_TV.TV_ASIENTOS
    (EMP_CODIGO,CON_NUMERO) TABLESPACE GEMIDXSS ;

            
DROP INDEX GEM_TV.CIE_PRO_FK_I;
    CREATE INDEX GEM_TV.CIE_PRO_FK_I ON GEM_TV.PRO_PROGRAMACION_CIERRES
    (EMP_CODIGO,SEN_CODIGO,PRO_FECHA) TABLESPACE GEMIDXSS ;            


DROP INDEX GEM_TV.CIE_GRP_FK_I;
    CREATE INDEX GEM_TV.CIE_GRP_FK_I ON GEM_TV.PRO_PROGRAMACION_CIERRES
    (GRP_NOMBRE) TABLESPACE GEMIDXSS ;


DROP INDEX GEM_TV.PREF_CICU_FK_I;
    CREATE INDEX GEM_TV.PREF_CICU_FK_I ON GEM_TV.TV_PREFACTURAS
    (PUC_CODIGO,CINV_CODIGO,CICU_CODIGO,EMP_CODIGO) TABLESPACE GEMIDXSS ;    
    
        
DROP INDEX GEM_TV.PREF_CINV_FK_I;
    CREATE INDEX GEM_TV.PREF_CINV_FK_I ON GEM_TV.TV_PREFACTURAS
    (PUC_CODIGO,CINV_CODIGO,EMP_CODIGO) TABLESPACE GEMIDXSS ;
        