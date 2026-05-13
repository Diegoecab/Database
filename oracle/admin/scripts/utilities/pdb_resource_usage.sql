-- ------------------------------------------------------------------------------
-- File       : pdb_resource_usage.sql
-- Purpose    : Oracle administration helper: pdb resource usage.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @pdb_resource_usage.sql
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




SET LINESIZE 300
COLUMN pdb_name FORMAT A10
COLUMN begin_time FORMAT A26
COLUMN end_time FORMAT A26
ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YYYY HH24:MI:SS'; 
ALTER SESSION SET NLS_TIMESTAMP_FORMAT='DD-MON-YYYY HH24:MI:SS.FF'; 

-- Last sample per PDB.
SELECT r.con_id,
       p.pdb_name,
       r.begin_time,
       r.end_time,
       r.cpu_consumed_time,
       r.cpu_wait_time,
       r.avg_running_sessions,
       r.avg_waiting_sessions,
       r.avg_cpu_utilization,
       r.avg_active_parallel_stmts,
       r.avg_queued_parallel_stmts,
       r.avg_active_parallel_servers,
       r.avg_queued_parallel_servers
FROM   v$rsrcpdbmetric r,
       cdb_pdbs p
WHERE  r.con_id = p.con_id
ORDER BY p.pdb_name;

-- Last hours samples for PDB1
SELECT r.con_id,
       p.pdb_name,
       r.begin_time,
       r.end_time,
       r.cpu_consumed_time,
       r.cpu_wait_time,
       r.avg_running_sessions,
       r.avg_waiting_sessions,
       r.avg_cpu_utilization,
       r.avg_active_parallel_stmts,
       r.avg_queued_parallel_stmts,
       r.avg_active_parallel_servers,
       r.avg_queued_parallel_servers
FROM   v$rsrcpdbmetric_history r,
       cdb_pdbs p
WHERE  r.con_id = p.con_id
AND    p.pdb_name = 'SI02'
ORDER BY r.begin_time;

-- All AWR snapshot information for PDB1.
SELECT r.snap_id,
       r.con_id,
       p.pdb_name,
       r.begin_time,
       r.end_time,
       r.cpu_consumed_time,
       r.cpu_wait_time,
       r.avg_running_sessions,
       r.avg_waiting_sessions,
       r.avg_cpu_utilization,
       r.avg_active_parallel_stmts,
       r.avg_queued_parallel_stmts,
       r.avg_active_parallel_servers,
       r.avg_queued_parallel_servers
FROM   dba_hist_rsrc_pdb_metric r,
       cdb_pdbs p
WHERE  r.con_id = p.con_id
AND    p.pdb_name = 'SI02'
ORDER BY r.begin_time;