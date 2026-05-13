-- ------------------------------------------------------------------------------
-- File       : get_row_block_id.sql
-- Purpose    : Oracle administration helper: get row block id.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @get_row_block_id.sql
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
PROMPT  Just an example;
PROMPT  
PROMPT  select empno, ename,
PROMPT  dbms_rowid.rowid_relative_fno(rowid) fileno,
PROMPT  dbms_rowid.rowid_block_number(rowid) block_no
PROMPT  from scott.emp where empno = 7521;
