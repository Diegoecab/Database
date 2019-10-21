--rc_rman_status_full
--Last full backup for each database
col status for a30
col name for a30

select a.dbid,a.name, b.* from RC_database A left outer join
(
select db_key, max(start_time) last_backup_time , RANK() OVER (PARTITION BY db_key ORDER BY  max(start_time)	 DESC) start_time_last, object_type, row_level, status,
round ( max(output_bytes) / 1000000000 ) GBytes_Processed,
output_device_type "DEVICE"
 from rc_rman_status b where b.start_time < sysdate -1 and operation='BACKUP' and
(object_type = 'DB FULL' or object_type = 'DB INCR')
GROUP BY db_key, DB_NAME, object_type, row_level, status,
output_device_type
order by 2 ) b on a.db_key = b.db_key and start_time_last = 1 order by name
/
