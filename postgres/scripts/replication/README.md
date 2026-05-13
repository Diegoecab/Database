# postgres replication

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `check_is_replica_instance_pg_is_in_recovery.sql` | postgres replication helper: check is replica instance pg is in recovery. | `READ_ONLY` | `-` |
| `pg_class_replica.sql` | postgres replication helper: pg class replica. | `READ_ONLY` | `-` |
| `pg_current_lsn.sql` | postgres replication helper: pg current lsn. | `READ_ONLY` | `-` |
| `pg_drop_replication_slot.sql` | postgres replication helper: pg drop replication slot. | `DESTRUCTIVE` | `-` |
| `pg_publication_tables.sql` | postgres replication helper: pg publication tables. | `READ_ONLY` | `-` |
| `pg_replication_lag.sql` | postgres replication helper: pg replication lag. | `READ_ONLY` | `int` |
| `pg_replication_slots.sql` | postgres replication helper: pg replication slots. | `READ_ONLY` | `-` |
| `pg_replication_slots_create.sql` | postgres replication helper: pg replication slots create. | `CHANGES` | `-` |
| `pg_walfile_name_lsn.sql` | postgres replication helper: pg walfile name lsn. | `READ_ONLY` | `-` |
| `publications.sql` | postgres replication helper: publications. | `READ_ONLY` | `-` |
| `replica_identity_table.sql` | postgres replication helper: replica identity table. | `READ_ONLY` | `regclass` |
