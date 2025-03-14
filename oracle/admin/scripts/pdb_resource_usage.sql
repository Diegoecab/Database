



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