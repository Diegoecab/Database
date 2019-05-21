/* Previo con sys:
GRANT SELECT ON DBA_OBJECTS TO SYSTEM WITH GRANT OPTION 
GRANT SELECT ON DBA_SEGMENTS TO SYSTEM WITH GRANT OPTION
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
(SEGMENT_TYPE, OWNER, SEGMENT_NAME)
AS 
SELECT   S.SEGMENT_TYPE, OBJ_CANT_BLOQ.OWNER, S.SEGMENT_NAME
       FROM OBJ_CANT_BLOQ, DBA_SEGMENTS S
      WHERE S.SEGMENT_NAME = OBJ_CANT_BLOQ.OBJECT_NAME
        AND S.OWNER = OBJ_CANT_BLOQ.OWNER
        AND S.SEGMENT_TYPE = OBJ_CANT_BLOQ.OBJECT_TYPE
        AND NVL (S.PARTITION_NAME, '-') =
                                       NVL (OBJ_CANT_BLOQ.SUBOBJECT_NAME, '-')
        AND BUFFER_POOL <> 'KEEP'
        AND OBJECT_TYPE IN ('TABLE')
        AND OBJ_CANT_BLOQ.OWNER <> 'SYS'
   GROUP BY S.SEGMENT_TYPE, OBJ_CANT_BLOQ.OWNER, S.SEGMENT_NAME
     HAVING (SUM (NUM_BLOCKS) / GREATEST (SUM (BLOCKS), .001)) * 100 > 80
/



CREATE OR REPLACE PROCEDURE GET_OBJ_KEEP
AS
   SQL_TEXT    VARCHAR2 (1000);
   SQL_TEXTN   VARCHAR2 (10000);
BEGIN
   SELECT 'SELECT    ''ALTER ''|| SEGMENT_TYPE||'' ''|| OWNER|| ''.''|| SEGMENT_NAME|| '' storage (buffer_pool keep)''  FROM OBJETOS_TO_KEEP'
     INTO SQL_TEXT
     FROM DUAL;

   EXECUTE IMMEDIATE SQL_TEXT
                INTO SQL_TEXTN;

   DBMS_OUTPUT.PUT_LINE (SQL_TEXTN);

   EXECUTE IMMEDIATE SQL_TEXTN;

   COMMIT;
END;
/

DROP TABLE LOG_KEEP;

CREATE TABLE LOG_KEEP (FECHA DATE,STRNG VARCHAR2(4000)) TABLESPACE PRUEBA;


CREATE OR REPLACE TRIGGER FECHA_EXEC
   BEFORE INSERT
   ON LOG_KEEP
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   :NEW.FECHA := SYSDATE;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END FECH_EXEC;
/



CREATE OR REPLACE PROCEDURE GET_OBJ_KEEP
AS
   SQL_TEXT    VARCHAR2 (1000);
   SQL_TEXTN   VARCHAR2 (10000);
BEGIN
   SELECT 'SELECT    ''ALTER ''|| SEGMENT_TYPE||'' ''|| OWNER|| ''.''|| SEGMENT_NAME|| '' storage (buffer_pool keep)''  FROM OBJETOS_TO_KEEP'
     INTO SQL_TEXT
     FROM DUAL;

   EXECUTE IMMEDIATE SQL_TEXT
                INTO SQL_TEXTN;

--DBMS_OUTPUT.PUT_LINE(SQL_TEXTN);
   EXECUTE IMMEDIATE SQL_TEXTN;

   COMMIT;
END;
/






CREATE OR REPLACE PROCEDURE SYSTEM.GET_OBJ_KEEP
AS
   SQL_TEXT    VARCHAR2 (1000);
   SQL_TEXT_2   VARCHAR2 (10000);   
   SQL_TEXTN   VARCHAR2 (10000);
   CANT_OBJ NUMBER;
BEGIN
   
   SELECT COUNT(*) INTO CANT_OBJ FROM OBJETOS_TO_KEEP;
   IF CANT_OBJ != 0 THEN
   FOR i in 0..CANT_OBJ LOOP  
   SQL_TEXT := 'ALTER ''|| SEGMENT_TYPE||'' ''|| OWNER|| ''.''|| SEGMENT_NAME|| '' storage (buffer_pool keep)';
   SQL_TEXT_2 := 'SELECT    MIN('''||SQL_TEXT||''')
  FROM OBJETOS_TO_KEEP';

--  EXECUTE IMMEDIATE SQL_TEXT
  --         INTO SQL_TEXTN;
               --USING SYS.DICTIONARY_OBJ_OWNER, SYS.DICTIONARY_OBJ_NAME;

DBMS_OUTPUT.PUT_LINE(SQL_TEXT_2);

--INSERT INTO PRUEBA (STRING) VALUES (SQL_TEXT_2);


--  EXECUTE IMMEDIATE SQL_TEXTN;
   COMMIT;
   END LOOP;
  END IF;
        exception
        when others then RAISE;
END;
/

--CREATE TABLE PRUEBA (STRING VARCHAR2(4000)) tablespace PRUEBA
--TRUNCATE TABLE PRUEBA

