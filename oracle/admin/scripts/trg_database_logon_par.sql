REM	Ejemplo trigger de base de datos "after logon"
REM ======================================================================
REM trg_database_logon_par.sql		Version 1.1	29 Marzo 2010
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
 
CREATE OR REPLACE TRIGGER trg_database_logon_par
   AFTER LOGON ON DATABASE
DECLARE
USUARIO VARCHAR2 (100);
BEGIN
	select USER into USUARIO from dual;
	IF USUARIO = 'AUDITAR' THEN
   EXECUTE IMMEDIATE 'alter session set optimizer_index_cost_adj=60';
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                       (-20003,
                        'Error en cambio de parametro database login'
                       );
END trg_database_logon_par;
/