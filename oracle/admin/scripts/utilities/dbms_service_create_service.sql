-- ------------------------------------------------------------------------------
-- File       : dbms_service_create_service.sql
-- Purpose    : Oracle administration helper: dbms service create service.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_service_create_service.sql
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
define serv_name='srv_RIO57_ap'
COLUMN name FORMAT A30
COLUMN network_name FORMAT A30

SELECT name,
       network_name
FROM   dba_services where name='&serv_name'
ORDER BY 1;

BEGIN
  DBMS_SERVICE.create_service(
    service_name => '&serv_name',
    network_name => '&serv_name'
  );
END;
/


SELECT name,
       network_name
FROM   dba_services
ORDER BY 1;

SELECT name,
       network_name
FROM   v$active_services
ORDER BY 1;

BEGIN
  DBMS_SERVICE.start_service(
    service_name => '&serv_name'
  );
END;
/


SELECT name,
       network_name
FROM   v$active_services
ORDER BY 1;