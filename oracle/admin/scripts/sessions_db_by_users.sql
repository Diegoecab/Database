--sessions_db_by_users.sql
set lines 300
set pages 100
col username for a30 truncate
col MACHINE for a30 truncate
col osuser for a20 truncate
col service_name for a20 truncate
SELECT NVL(s.username, '[bkgrnd]') AS username, s.inst_id, status, osuser,machine,
        service_name, min(logon_time), count(*)
FROM   gv$session s,
       gv$process p
WHERE  s.paddr      = p.addr
AND    s.inst_id = p.inst_id
GROUP BY NVL(s.username, '[bkgrnd]'), s.inst_id, status, osuser,machine, service_name
ORDER BY 1
/