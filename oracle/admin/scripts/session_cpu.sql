--v$session_cpu.sql
--
-- Show CPU Usage for Active Sessions
--

--SET PAUSE ON
--SET PAUSE 'Press Return to Continue'
SET PAGESIZE 60
SET LINESIZE 300

COLUMN username FORMAT A30
COLUMN sid FORMAT 999999999999
COLUMN serial# FORMAT 999999999999
COLUMN "cpu usage (seconds)"  FORMAT 999999999999
COLUMN "cpu usage (min)"  FORMAT 999999999999

SELECT   s.username, t.SID, s.serial#,
         SUM (VALUE / 100) AS "cpu usage (seconds)",
         ROUND (SUM (VALUE / 100) / 60) AS "cpu usage (min)"
    FROM v$session s, v$sesstat t, v$statname n
   WHERE t.statistic# = n.statistic#
     AND NAME LIKE '%CPU used by this session%'
     AND t.SID = s.SID
     AND s.status = 'ACTIVE'
     AND s.username IS NOT NULL
GROUP BY username, t.SID, s.serial#
ORDER BY 4
/