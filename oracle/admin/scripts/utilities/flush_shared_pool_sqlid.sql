-- ------------------------------------------------------------------------------
-- File       : flush_shared_pool_sqlid.sql
-- Purpose    : Oracle administration helper: flush shared pool sqlid.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @flush_shared_pool_sqlid.sql
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
--flush_shared_pool_sqlid
REM Flushes one cursor out of the shared pool. Works on 11g+
REM To create DBMS_SHARED_POOL, run the DBMSPOOL.SQL script.
REM The PRVTPOOL.PLB script is automatically executed after DBMSPOOL.SQL runs.
REM These scripts are not run by as part of standard database creation.
SPO flush_cursor_&&sql_id..txt;
PRO *** before flush ***
SELECT inst_id, loaded_versions, invalidations, address, hash_value
FROM gv$sqlarea WHERE sql_id = '&&sql_id.' ORDER BY 1;
SELECT inst_id, child_number, plan_hash_value, executions, is_shareable
FROM gv$sql WHERE sql_id = '&&sql_id.' ORDER BY 1, 2;
BEGIN
 FOR i IN (SELECT address, hash_value
 FROM gv$sqlarea WHERE sql_id = '&&sql_id.')
 LOOP
 SYS.DBMS_SHARED_POOL.PURGE(i.address||','||i.hash_value, 'C');
 END LOOP;
END;
/
PRO *** after flush ***
SELECT inst_id, loaded_versions, invalidations, address, hash_value
FROM gv$sqlarea WHERE sql_id = '&&sql_id.' ORDER BY 1;
SELECT inst_id, child_number, plan_hash_value, executions, is_shareable
FROM gv$sql WHERE sql_id = '&&sql_id.' ORDER BY 1, 2;
UNDEF sql_id;
SPO OFF;
 
