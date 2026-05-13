# aws cloud/rds

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `cliauth` | aws cloud/rds helper: cliauth. | `REVIEW` | `-` |
| `create-event-subscription.sh` | aws cloud/rds helper: create event subscription. | `CHANGES` | `Decrypt, GenerateDataKey, aws, iam, key, kms, my, root, sns, us` |
| `wget-19c-ee.sh` | aws cloud/rds helper: wget 19c ee. | `READ_ONLY` | `COOKIE_FILE, LANG, LOGDIR, LOGFILE, OUTPUT_DIR, WGET, token` |
| `describe-pending-maintenance-actions.sh` | aws cloud/rds helper: describe pending maintenance actions. | `READ_ONLY` | `aws, db, eu, oracl, rds` |
| `list-ec2instances.py` | aws cloud/rds helper: list ec2instances. | `CHANGES` | `-` |
| `list-rds.py` | aws cloud/rds helper: list rds. | `REVIEW` | `-` |
| `rds.cli.create--db-parameter-group.sh` | aws cloud/rds helper: rds.cli.create db parameter group. | `CHANGES` | `-` |
| `rds.cli.create-db-snapshot.sh` | aws cloud/rds helper: rds.cli.create db snapshot. | `CHANGES` | `-` |
| `rds.cli.create_db_cluster.sh` | aws cloud/rds helper: rds.cli.create db cluster. | `CHANGES` | `-` |
| `rds.cli.create_db_instance.sh` | aws cloud/rds helper: rds.cli.create db instance. | `CHANGES` | `-` |
| `rds.cli.create_global_db_cluster.sh` | aws cloud/rds helper: rds.cli.create global db cluster. | `CHANGES` | `-` |
| `rds.cli.createdb.postgres.sh` | aws cloud/rds helper: rds.cli.createdb.postgres. | `CHANGES` | `AWSREGION, DBSECGRP, DBSUBNETGRP, EMROLE, EMROLEARN, RDSKMSKEY, RDSSTACK` |
| `rds.cli.describe-db-cluster-snapshots.sh` | aws cloud/rds helper: rds.cli.describe db cluster snapshots. | `READ_ONLY` | `-` |
| `rds.cli.describe-db-engine-versions.validpathupgrade.sh` | aws cloud/rds helper: rds.cli.describe db engine versions.validpathupgrade. | `READ_ONLY` | `EngineVersion` |
| `rds.cli.describe-orderable-db-instance-options.sh` | aws cloud/rds helper: rds.cli.describe orderable db instance options. | `READ_ONLY` | `-` |
| `rds.cli.describe-rds-databases-dashboard-tree.sh` | aws cloud/rds helper: rds.cli.describe rds databases dashboard tree. | `READ_ONLY` | `DBInstanceIdentifier, Engine, EngineVersion, IsClusterWriter, Status` |
| `rds.cli.describe_db_instances.sh` | aws cloud/rds helper: rds.cli.describe db instances. | `READ_ONLY` | `-` |
| `rds.cli.describe_db_parameters.sh` | aws cloud/rds helper: rds.cli.describe db parameters. | `CHANGES` | `SnapshotType` |
| `rds.cli.describe_modify_instances.sh` | aws cloud/rds helper: rds.cli.describe modify instances. | `DESTRUCTIVE` | `-` |
| `rds.cli.modify-db-instance.backup-retention-period.sh` | aws cloud/rds helper: rds.cli.modify db instance.backup retention period. | `REVIEW` | `-` |
| `rds.cli.modify-db-instance.max-allocated-storage.sh` | aws cloud/rds helper: rds.cli.modify db instance.max allocated storage. | `REVIEW` | `-` |
| `rds.cli.modify-db-parameter-group.sh` | aws cloud/rds helper: rds.cli.modify db parameter group. | `REVIEW` | `-` |
| `rds.cli.proxies.sh` | aws cloud/rds helper: rds.cli.proxies. | `READ_ONLY` | `-` |
| `rds.cli.restore.from.snapshot.sh` | aws cloud/rds helper: rds.cli.restore.from.snapshot. | `DESTRUCTIVE` | `-` |
| `rds.cli.restorepointintime.cluster.sh` | aws cloud/rds helper: rds.cli.restorepointintime.cluster. | `DESTRUCTIVE` | `-` |
| `rds.cli.restorepointintime.snapshot.sh` | aws cloud/rds helper: rds.cli.restorepointintime.snapshot. | `DESTRUCTIVE` | `-` |
| `rds.describe-db-snapshots.sh` | aws cloud/rds helper: rds.describe db snapshots. | `READ_ONLY` | `SnapshotType` |
| `rds_events_to_lambda_CW_logs.sh` | aws cloud/rds helper: rds events to lambda CW logs. | `DESTRUCTIVE` | `AssumeRole, DescribeDBClusterEndpoints, DescribeDBClusterParameterGroups, DescribeDBClusterParameters, DescribeDBClusters, DescribeDBEngineVersions, DescribeDBInstances, DescribeDBLogFiles, DescribeGlobalClusters, DescribeOptionGroups, DescribePendingMaintenanceActions, DescribeReservedDBInstances, DescribeReservedDBInstancesOfferings, DescribeSourceRegions, DescribeValidDBInstanceModifications, InvokeFunction, KEY, ListTagsForResource, REGION, StartDBCluster, StartDBInstance, StopDBCluster, StopDBInstance, VALUE, aws, events, function, iam, lambda, log, logs, policy, rds, role, rule, us` |
| `start-export-task-export-snapshot-to-s3.sh` | aws cloud/rds helper: start export task export snapshot to s3. | `DESTRUCTIVE` | `AWS_Region, aws, iam, key, kms, manualbkp120723, rds, role, snapshot, us` |
