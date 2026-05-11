-- ------------------------------------------------------------------------------
-- File       : Parallel_Query.sql
-- Purpose    : Oracle administration helper: Parallel Query.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @Parallel_Query.sql
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
/* Determinar Consultas en paralelo */
SELECT   qcsid,
         sid,
         NVL(server_group,0) server_group,
         server_set,
         degree,
         req_degree
FROM     SYS.V_$PX_SESSION
ORDER BY qcsid,
         NVL(server_group,0),
         server_set;


/* Vistas ...*/

select * from v_$pq_sysstat;
select * from v_$px_process;
select * from v_$px_sesstat;
select * from v_$px_process_sysstat;