-- ------------------------------------------------------------------------------
-- File       : create_sql_profile_copy.sql
-- Purpose    : Oracle SQL performance and tuning helper: create sql profile copy.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @create_sql_profile_copy.sql
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
--create_sql_profile_copy.sql
accept sql_id_from -
       prompt 'Enter value for sql_id to generate profile from: ' -
       default 'X0X0X0X0'
accept child_no_from -
       prompt 'Enter value for child_no to generate profile from: ' 
accept sql_id_to -
       prompt 'Enter value for sql_id to attach profile to: ' -
       default 'X0X0X0X0'
accept child_no_to -
       prompt 'Enter value for child_no to attach profile to: ' 
accept category -
       prompt 'Enter value for category: ' -
       default 'DEFAULT'
accept force_matching -
       prompt 'Enter value for force_matching: ' -
       default 'false'

@rg_sqlprof3 '&sql_id_from' &child_no_from '&sql_id_to' &child_no_to '&category' '&force_matching'
undef sql_id_from
undef child_no_from
undef sql_id_to
undef child_no_to
undef category
undef force_matching

