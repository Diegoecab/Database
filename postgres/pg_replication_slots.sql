--used for cross region read replicas, run at primary
select * from pg_replication_slots;
select * from pg_catalog.pg_replication_slots;
--
--If you want to check the Replication Slot Lag, you can look for the CloudWatch Metric or run the following:(TransactionLogsDiskUsage)
SELECT slot_name, pg_size_pretty(pg_wal_lsn_diff(pg_current_wal_lsn(),restart_lsn)) AS replicationSlotLag,
active FROM pg_replication_slots ;
