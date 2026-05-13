-- ------------------------------------------------------------------------------
-- File       : dataguard_restart.sql
-- Purpose    : Oracle diagnostic query/report helper: dataguard restart.
-- Category   : diagnostics/ash
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dataguard_restart.sql
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
Restart the archivers & redo transport on the primary:

sqlplus / as sysdba
sql> alter system set log_archive_dest_state_3=defer sid='*';
sql> show parameter log_archive_max_processes;
sql> alter system set log_archive_max_processes=1 sid='*';
sql> alter system set log_archive_max_processes=<orginal value> sid='*'; >> default is 4
sql> alter system set log_archive_dest_state_3=enable sid='*';
sql> alter system set log_archive_dest_state_2=enable sid='*';
sql> alter system archive log current;
sql> select inst_id,status,error from gv$archive_dest where dest_id in(2,3)