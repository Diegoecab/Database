-- ------------------------------------------------------------------------------
-- File       : dbms_stats.sql
-- Purpose    : Oracle SQL performance and tuning helper: dbms stats.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_stats.sql
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
begin
dbms_stats.gather_table_stats
(ownname => 'GESTAR', 
tabname => 'SYS_FIELDS_56' , 
estimate_percent => 100,
method_opt => 'for all indexed columns size auto',
cascade=> true);
end;
/


BEGIN
   DBMS_STATS.gather_table_stats
                          (ownname               => 'AUDITAR',
                           tabname               => 'VENCIMIENTOS',
                           estimate_percent      => DBMS_STATS.auto_sample_size,
                           method_opt            => 'for all indexed columns size auto',
                           CASCADE               => TRUE
                          );
END;
/