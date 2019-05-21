REM	Ejemplo trigger de base de datos "after logon"
REM ======================================================================
REM trg_database_logon.sql		Version 1.1	18 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	Ejemplos
REM Dependencias:
REM	
REM
REM Notas:
REM
REM Precauciones:
REM	
REM ======================================================================
REM
REM TABLA

CREATE TABLE SYSTEM.DB_ACCESS_ALLOW
(
  HOST      VARCHAR2(50 BYTE),
  COMMENT#  VARCHAR2(100 BYTE)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX SYSTEM.HOST_UQ ON SYSTEM.DB_ACCESS_ALLOW
(HOST)
LOGGING
NOPARALLEL;


ALTER TABLE SYSTEM.DB_ACCESS_ALLOW ADD (
  CONSTRAINT HOST_UQ
 UNIQUE (HOST));

 REM TRIGGER
 
CREATE OR REPLACE TRIGGER trg_database_logon
   AFTER LOGON ON DATABASE
DECLARE
   acceso   NUMBER;
BEGIN
   BEGIN
      acceso := 0;
      SELECT 1
        INTO acceso
        FROM SYSTEM.db_access_allow
       WHERE db_access_allow.HOST = SYS_CONTEXT ('USERENV', 'IP_ADDRESS');
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error
                       (-20003,
                        'No tiene permiso para conectarse a la base de datos'
                       );
   --Podria ser USERENV HOST
   /* Para validar hora y o fecha*/
   --IF (to_number(to_char(sysdate,'HH24'))< 6) and (to_number(to_char(sysdate,'HH24')) >18) THEN
--RAISE_APPLICATION_ERROR(-20005,'Solo puede acceder en horario laboral');
--END IF;
   END;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'No tiene permiso para conectarse a la base de datos'
                       );
END trg_database_logon;
/



REM Trigger validando por el rango de IP

CREATE OR REPLACE TRIGGER trg_database_logon
   AFTER LOGON ON DATABASE
BEGIN
   IF SYS_CONTEXT ('USERENV', 'IP_ADDRESS') NOT LIKE '172.19.12.%'
   THEN
      raise_application_error
                       (-20003,
                        'No tiene permiso para conectarse a la base de datos'
                       );
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'No tiene permiso para conectarse a la base de datos'
                       );
END trg_database_logon;
/