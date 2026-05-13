-- ------------------------------------------------------------------------------
-- File       : db01.sql
-- Purpose    : Oracle administration helper: db01.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @db01.sql
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
set verify off
PROMPT specify a password for sys as parameter 1;
DEFINE sysPassword = &1
PROMPT specify a password for system as parameter 2;
DEFINE systemPassword = &2
PROMPT specify a password for sysman as parameter 3;
DEFINE sysmanPassword = &3
PROMPT specify a password for dbsnmp as parameter 4;
DEFINE dbsnmpPassword = &4
host /u01/app/oracle/product/10.2.0/bin/orapwd file=/u01/app/oracle/product/10.2.0/dbs/orapwdb01 password=&&sysPassword force=y
@/u01/app/oracle/admin/db01/scripts/CloneRmanRestore.sql
@/u01/app/oracle/admin/db01/scripts/cloneDBCreation.sql
@/u01/app/oracle/admin/db01/scripts/postScripts.sql
@/u01/app/oracle/admin/db01/scripts/postDBCreation.sql
