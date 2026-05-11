-- ------------------------------------------------------------------------------
-- File       : trace_usuarios.sql
-- Purpose    : Oracle RAC or cluster administration helper: trace usuarios.
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @trace_usuarios.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
CREATE OR REPLACE TRIGGER
trace_usuario_trigger
AFTER LOGON ON DATABASE
DECLARE
sessid VARCHAR2(50);

usuar VARCHAR2(30);

BEGIN
SELECT sys_context('USERENV','SESSIONID') INTO sessid FROM sys.dual;

SELECT USERNAME INTO USUAR FROM ALL_USERS WHERE USER_ID=UID;

INSERT INTO SYS.LOGONS (USUARIO,HORA_DE_CON,SESSION_ID) VALUES (usuar,SYSDATE,sessid);

COMMIT;

EXECUTE IMMEDIATE 'ALTER SESSION SET SQL_TRACE=TRUE';
END;
/

ALTER TRIGGER trace_usuario_trigger ENABLE;

CREATE TABLE LOGONS (USUARIO VARCHAR2(100), HORA_DE_CON DATE, SESSION_ID NUMBER);


GRANT ALL ON LOGONS TO RGEM_ADM_ALL;

GRANT SELECT ON LOGONS TO GEM_ADM;

GRANT ALL ON LOGONS TO RGEM_ADM_QRY;

GRANT SELECT ON V_$SESSION TO PUBLIC;