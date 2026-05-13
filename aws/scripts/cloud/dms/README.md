# aws cloud/dms

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `aws.cli.enablebatch.sh` | aws cloud/dms helper: aws.cli.enablebatch. | `REVIEW` | `IDIDID, XXXXXXXXXXX, aws, dms, task, true, us` |
| `awsdms_support_collector_oracle.sql` | aws cloud/dms helper: awsdms support collector oracle. | `DESTRUCTIVE` | `GRANTEE, MI, NULLABLE, OWNER, PARSING_SCHEMA_NAME, SS, TABLE_OWNER, X, Y, v_connector, v_days, v_owner` |
| `awsdms_support_collector_postgres.sql` | aws cloud/dms helper: awsdms support collector postgres. | `DESTRUCTIVE` | `Black, Consolas, White, bigint, black, bold, integer, is_eq_9, is_ge_10, is_non_rds, is_rds, none, regclass, text, timestamp, top, v_connector, v_owner, verdana` |
| `create-endpoint.sh` | aws cloud/dms helper: create endpoint. | `CHANGES` | `-` |
| `delete_unused_dms_endpoints.sh` | aws cloud/dms helper: delete unused dms endpoints. | `DESTRUCTIVE` | `arg1, arg2` |
| `describe-replication-tasks.sh` | aws cloud/dms helper: describe replication tasks. | `READ_ONLY` | `-` |
| `describe_instances.sh` | aws cloud/dms helper: describe instances. | `READ_ONLY` | `-` |
| `dms.create-replication-instance.sh` | aws cloud/dms helper: dms.create replication instance. | `CHANGES` | `-` |
| `dms.describe-endpoints.sh` | aws cloud/dms helper: dms.describe endpoints. | `READ_ONLY` | `-` |
| `dms.describe-table-statistics.sh` | aws cloud/dms helper: dms.describe table statistics. | `READ_ONLY` | `-` |
| `filter-log-events.sh` | aws cloud/dms helper: filter log events. | `REVIEW` | `-` |
| `listing_unsused_dms_endpoitns.sh` | aws cloud/dms helper: listing unsused dms endpoitns. | `READ_ONLY` | `arg1, arg2` |
| `modify_replication_task.sh` | aws cloud/dms helper: modify replication task. | `REVIEW` | `F2G5JZIPAQFBDVVBZMR537CSTU, aws, dms, task, us` |
| `oracle.sql` | aws cloud/dms helper: oracle. | `CHANGES` | `TABLE_NAME` |
| `postgres.sql` | aws cloud/dms helper: postgres. | `READ_ONLY` | `-` |
| `test-connection.sh` | aws cloud/dms helper: test connection. | `READ_ONLY` | `LUI5N3XRZ5JJ6RZ2HHR4NOGAYTZWFORAVNJK3NA, T3OM7OUB5NM2LCVZF7JPGJRNUE, aws, dms, endpoint, rep, us` |
| `upgrade_migrate_postgres_dms.sh` | aws cloud/dms helper: upgrade migrate postgres dms. | `DESTRUCTIVE` | `EM365OHC4SFK666Y3JFWXGWP6MZ3CHCGQ5V6ZHQ, HBVG6NX2WLAIMEJSP44X6CI67YWGSNANQQHO64Y, LUI5N3XRZ5JJ6RZ2HHR4NOGAYTZWFORAVNJK3NA, aws, dms, endpoint, rep, text, us` |
