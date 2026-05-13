-- ------------------------------------------------------------------------------
-- File       : get_ddl_rol.sql
-- Purpose    : Oracle administration helper: get ddl rol (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @get_ddl_rol (1).sql
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
set heading off;
set echo off;
Set pages 999;
set feedback off
set long 90000;
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR', true);
accept ROLE prompt 'Ingrese Rol: '
prompt Create role ...
SELECT dbms_metadata.get_ddl('ROLE','&ROLE') from dual;
prompt System grants
SELECT DBMS_METADATA.GET_GRANTED_DDL('SYSTEM_GRANT','&ROLE') from dual;
prompt Object grants
SELECT DBMS_METADATA.GET_GRANTED_DDL('OBJECT_GRANT','&ROLE') from dual;
prompt Role grants
SELECT DBMS_METADATA.GET_GRANTED_DDL('ROLE_GRANT','&ROLE') from dual;
set feedback on