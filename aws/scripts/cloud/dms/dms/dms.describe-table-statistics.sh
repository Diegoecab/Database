# ------------------------------------------------------------------------------
# File       : dms.describe-table-statistics.sh
# Purpose    : aws cloud/dms helper: dms.describe table statistics.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./dms.describe-table-statistics.sh
# Parameters : Review script body before running.
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws dms describe-table-statistics --replication-task-arn $AWS_DMS_TSKEP_ARN
