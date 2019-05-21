spool c:\temp\citi_trg_test.log
set feed off

PROMPT ************************************
PROMPT Create functional user
PROMPT ************************************ 
 
CREATE USER FNCUSER IDENTIFIED BY FNCUSER PROFILE DEFAULT
DEFAULT TABLESPACE users;

GRANT CREATE SESSION TO FNCUSER;

GRANT CREATE ANY TABLE TO FNCUSER;

GRANT CREATE ANY TRIGGER TO FNCUSER;

PROMPT ************************************
PROMPT Create user ENDUSER
PROMPT ************************************

CREATE USER ENDUSER IDENTIFIED BY ENDUSER PROFILE DEFAULT
DEFAULT TABLESPACE users;

GRANT CREATE SESSION TO ENDUSER;

PROMPT ************************************
PROMPT Connect with FNUSER
PROMPT ************************************

conn FNCUSER/FNCUSER@CDWDEV
set feed off
--Con usuario generico para crear objetos FNCUSER

PROMPT ************************************
PROMPT Change current_schema
PROMPT ************************************

ALTER SESSION SET CURRENT_SCHEMA=DBADMIN;

PROMPT ************************************
PROMPT Creating tables
PROMPT ************************************
 
CREATE TABLE PRUEBA_TRG (NUM   NUMBER, STATUS VARCHAR2 (3));

CREATE TABLE PRUEBA2_TRG (NUM   NUMBER, STATUS VARCHAR2 (3));

--Trigger After insert
PROMPT ************************************
PROMPT Creating triggers
PROMPT ************************************

CREATE TRIGGER INS_PRUEBA_TRG
   BEFORE INSERT
   ON PRUEBA_TRG
   FOR EACH ROW
BEGIN
   :NEW.STATUS := 'INS';
END;
/

--Trigger After update

CREATE TRIGGER UPD_PRUEBA_TRG
   BEFORE UPDATE
   ON PRUEBA_TRG
   FOR EACH ROW
BEGIN
   :NEW.STATUS := 'UPD';
END;
/

--Trigger After delete

CREATE TRIGGER DEL_PRUEBA_TRG
   AFTER DELETE
   ON PRUEBA_TRG
   FOR EACH ROW
BEGIN
   EXECUTE IMMEDIATE ('INSERT INTO PRUEBA2_TRG (NUM,STATUS) values (99,''DEL'') ');
END;
/

PROMPT ************************************
PROMPT Connect with DBA
PROMPT ************************************

CONN DC22057@CDWDEV
set feed off

PROMPT ************************************
PROMPT Grants DEL,INS,UPD,SEL
PROMPT ************************************

GRANT SELECT,INSERT,UPDATE,DELETE ON DBADMIN.PRUEBA_TRG TO ENDUSER;
GRANT SELECT,INSERT,UPDATE,DELETE ON DBADMIN.PRUEBA2_TRG TO ENDUSER;

PROMPT ************************************
PROMPT Verify Objects 
PROMPT ************************************

select owner,table_name from dba_Tables where table_name in ('PRUEBA_TRG','PRUEBA2_TRG');

PROMPT
PROMPT ************************************
PROMPT DBA_TRIGGERS
PROMPT ************************************

set verify off
set linesize 200
set long 500
set pagesize 2000
col column_name for a20
col table_owner for a10
col description for a20
col triggering_event for a15
col trigger_body for a80
col when_clause for a20
select trigger_type,triggering_event,trigger_body,status,table_owner,
table_name,when_clause,action_type from dba_triggers where table_name in ('PRUEBA_TRG','PRUEBA2_TRG');

set pages 1000
set verify off
set lines 150
set feedback off
set trims on

col owner for a20


PROMPT
PROMPT ************************************
PROMPT SOURCE INS_PRUEBA_TRG
PROMPT ************************************

select TEXT from dba_source where name= 'INS_PRUEBA_TRG' order by owner,name,type,line;

PROMPT
PROMPT ************************************
PROMPT SOURCE UPD_PRUEBA_TRG
PROMPT ************************************

select TEXT from dba_source where name= 'UPD_PRUEBA_TRG' order by owner,name,type,line;

PROMPT
PROMPT ************************************
PROMPT SOURCE DEL_PRUEBA_TRG
PROMPT ************************************

select TEXT from dba_source where name= 'DEL_PRUEBA_TRG' order by owner,name,type,line;

--Con usuario funcional ENDUSER

PROMPT ************************************
PROMPT Connect with ENDUSER
PROMPT ************************************

conn ENDUSER/ENDUSER@CDWDEV
set feed off
@nls_date

PROMPT ************************************
PROMPT Change current_schema
PROMPT ************************************

ALTER SESSION SET CURRENT_SCHEMA=DBADMIN;

PROMPT
PROMPT ************************************
PROMPT  INSERT ON PRUEBA_TRG 
PROMPT ************************************

INSERT INTO PRUEBA_TRG (NUM)
  VALUES   (1);

COMMIT;

SELECT   * FROM PRUEBA_TRG;

PROMPT
PROMPT ************************************
PROMPT  UPDATE ON PRUEBA_TRG
PROMPT ************************************ 

UPDATE   PRUEBA_TRG
   SET   NUM = 2;

COMMIT;

SELECT   * FROM PRUEBA_TRG;

PROMPT
PROMPT ************************************
PROMPT  DELETE ON PRUEBA_TRG
PROMPT ************************************

DELETE FROM   PRUEBA_TRG;

COMMIT;

SELECT   * FROM PRUEBA2_TRG;


spool off

conn DC22057@CDWDEV

DROP USER FNCUSER  cascade;
DROP USER ENDUSER  cascade;

DROP TABLE dbadmin.PRUEBA_TRG;
DROP TABLE dbadmin.PRUEBA2_TRG;