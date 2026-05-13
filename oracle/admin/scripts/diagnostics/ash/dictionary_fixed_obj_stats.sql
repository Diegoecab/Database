-- ------------------------------------------------------------------------------
-- File       : dictionary_fixed_obj_stats.sql
-- Purpose    : Oracle diagnostic query/report helper: dictionary fixed obj stats.
-- Category   : diagnostics/ash
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dictionary_fixed_obj_stats.sql
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
alter session set nls_date_format='YYYY-Mon-DD';
col last_analyzed for a13
set termout off
set trimspool off
set feedback off
spool dictionary_statistics

prompt 'Statistics for SYS tables'
SELECT NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed, COUNT(*) dictionary_tables
FROM dba_tables
WHERE owner = 'SYS'
GROUP BY TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 1 DESC;

prompt 'Statistics for Fixed Objects'
select NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed, COUNT(*) fixed_objects
FROM dba_tab_statistics
WHERE object_type = 'FIXED TABLE'
GROUP BY TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 1 DESC;

spool off


prompt To gather dictionary stats, execute one of the following:
prompt 
prompt SQL> EXEC DBMS_STATS.GATHER_SCHEMA_STATS ('SYS');
prompt SQL> exec DBMS_STATS.GATHER_DATABASE_STATS (gather_sys=>TRUE);
prompt SQL> EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;

