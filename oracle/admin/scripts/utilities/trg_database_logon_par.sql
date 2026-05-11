-- ------------------------------------------------------------------------------
-- File       : trg_database_logon_par.sql
-- Purpose    : oracle/admin utilities helper: trg database logon par.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: trg_database_logon_par.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
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