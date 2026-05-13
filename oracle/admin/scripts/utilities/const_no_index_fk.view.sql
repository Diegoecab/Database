-- ------------------------------------------------------------------------------
-- File       : const_no_index_fk.view.sql
-- Purpose    : Oracle administration helper: const no index fk view.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @const_no_index_fk.view.sql
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
CREATE OR REPLACE VIEW lista_constraints_si as
select a.owner,a.table_name ,a.constraint_name,b.column_name,b.position Posicion_Columna from all_constraints a 
join all_cons_columns b on a.constraint_name=b.constraint_name 
where constraint_type='R'
and a.owner NOT IN ('SYS','SYSTEM','TOAD','D4OSYS','DB_BACKUP','DBSNMP')
AND NOT EXISTS (SELECT '1'
                FROM all_ind_columns aid
                WHERE aid.table_name=b.table_name
                AND aid.column_name=b.column_name)
 order by a.table_name,a.constraint_name,b.position