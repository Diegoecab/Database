# ------------------------------------------------------------------------------
# File       : describe-replication-tasks.sh
# Purpose    : aws cloud/dms helper: describe replication tasks.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./describe-replication-tasks.sh
# Parameters : Review script body before running.
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws dms describe-replication-tasks --filter Name=replication-task-id,Values=orcltosorcl --output json
aws dms describe-replication-tasks --filter Name=replication-task-id,Values=orcltosorcl --output json | jq '.ReplicationTasks | .[] | .TableMappings |= fromjson | .ReplicationTaskSettings |= fromjson | .["CdcStartPosition"] = .RecoveryCheckpoint | delpaths([
    ["ReplicationTaskArn"],["ReplicationTaskStartDate"],["ReplicationTaskStats"],["Status"],["StopReason"],["ReplicationTaskCreationDate"],["ReplicationTaskSettings","Logging","CloudWatchLogGroup"],["ReplicationTaskSettings","Logging","CloudWatchLogStream"],["RecoveryCheckpoint"]])
    | .TableMappings |= tostring |.ReplicationTaskSettings |= tostring'
aws dms describe-replication-tasks --filter Name=replication-task-id,Values=orcltosorcl --output json | jq '.ReplicationTasks | .[] | .TableMappings |= fromjson | .ReplicationTaskSettings |= fromjson | .["CdcStartPosition"] = .RecoveryCheckpoint | delpaths([ ["ReplicationTaskArn"],["ReplicationTaskStartDate"],["ReplicationTaskStats"],["Status"],["StopReason"],["ReplicationTaskCreationDate"],["ReplicationTaskSettings","Logging","CloudWatchLogGroup"],["ReplicationTaskSettings","Logging","CloudWatchLogStream"],["RecoveryCheckpoint"]]) | .TableMappings |= tostring |.ReplicationTaskSettings |= tostring' > task_backup.json
