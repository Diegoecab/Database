COLUMN con_id FORMAT 999999
COLUMN count FORMAT 99999
COLUMN name FORMAT a8
SELECT
   v.con_id, v.name, v.open_mode, COUNT(u.event_timestamp) count
FROM
   cdb_unified_audit_trail u
FULL OUTER JOIN v$containers v ON u.con_id = v.con_id
GROUP BY
   v.con_id, v.name, v.open_mode
ORDER BY
   v.con_id;
