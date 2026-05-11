-- ------------------------------------------------------------------------------
-- File       : dbms_sqltune.drop_sqlset.sql
-- Purpose    : Oracle SQL performance and tuning helper: dbms sqltune drop sqlset.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_sqltune.drop_sqlset.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--dbms_sqltune.drop_sqlset.sql
ttitle off

accept USERN prompt 'SQLSet Owner: '
accept SQLSNAME prompt 'SQLSet Name: '


BEGIN 
dbms_sqltune.drop_sqlset(sqlset_name => '&SQLSNAME', sqlset_owner =>'&USERN');
END;
/