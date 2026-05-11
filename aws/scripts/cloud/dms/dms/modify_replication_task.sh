# ------------------------------------------------------------------------------
# File       : modify_replication_task.sh
# Purpose    : aws cloud/dms helper: modify replication task.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./modify_replication_task.sh
# Parameters : F2G5JZIPAQFBDVVBZMR537CSTU, aws, dms, task, us
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws dms modify-replication-task --replication-task-arn arn:aws:dms:us-west-2:461375372952:task:F2G5JZIPAQFBDVVBZMR537CSTU --replication-task-settings "file://settings.json"
#{"Id":"SOURCE_UNLOAD","Severity":"LOGGER_SEVERITY_DETAILED_DEBUG"}

