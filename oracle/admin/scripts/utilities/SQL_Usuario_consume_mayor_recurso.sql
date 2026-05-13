-- ------------------------------------------------------------------------------
-- File       : SQL_Usuario_consume_mayor_recurso.sql
-- Purpose    : Oracle administration helper: SQL Usuario consume mayor recurso.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @SQL_Usuario_consume_mayor_recurso.sql
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
SELECT sess.username "Usuario", 
            sql.sql_text "Texto_SQL", 
            sort.blocks "Bloques"
FROM v$session sess, 
            v$sqltext sql,
            v$sort_usage sort
WHERE sess.serial#   = sort.session_num
AND       sort.sqladdr  = sql.address
AND       sort.sqlhash = sql.hash_value
AND       sort.blocks    > 200;