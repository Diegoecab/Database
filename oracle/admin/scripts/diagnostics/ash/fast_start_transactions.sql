-- ------------------------------------------------------------------------------
-- File       : fast_start_transactions.sql
-- Purpose    : Oracle diagnostic query/report helper: fast start transactions.
-- Category   : diagnostics/ash
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @fast_start_transactions.sql
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
set lines 300
alter session set NLS_DATE_FORMAT='DD-MON-YYYY HH24:MI:SS'; 

SELECT inst_id,usn, state, undoblockstotal "Total", undoblocksdone "Done", 
undoblockstotal-undoblocksdone "ToDo", 
DECODE(cputime,0,'unknown',SYSDATE+(((undoblockstotal-undoblocksdone) / (undoblocksdone / cputime)) / 86400)) 
"Finish at" 
FROM gv$fast_start_transactions; 