-- ------------------------------------------------------------------------------
-- File       : timestamp_to_scn.sql
-- Purpose    : Oracle administration helper: timestamp to scn.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @timestamp_to_scn.sql
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
select timestamp_to_scn(to_timestamp('10-08-2020 23:59:59','dd-mm-yyyy hh24:mi:ss')) scn from dual;


select scn_to_timestamp(686933430832) as timestamp from dual;









SQL> select timestamp_to_scn(to_timestamp('04-08-2020 23:59:59','dd-mm-yyyy hh24:mi:ss')) scn from dual;

                   SCN
----------------------
          689784269522

SQL>


select scn_to_timestamp(690758970397) as timestamp from dual;


TIMESTAMP
---------------------------------------------------------------------------
04-AUG-20 11.59.57.000000000 PM

