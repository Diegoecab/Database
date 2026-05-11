# ------------------------------------------------------------------------------
# File       : aws.cli.enablebatch.sh
# Purpose    : aws cloud/dms helper: aws.cli.enablebatch.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./aws.cli.enablebatch.sh
# Parameters : IDIDID, XXXXXXXXXXX, aws, dms, task, true, us
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws dms modify-replication-task --replication-task-arn arn:aws:dms:us-east-1:XXXXXXXXXXX:task:IDIDID --replication-task-settings "{\"TargetMetadata\":{\"BatchApplyEnabled\":true}}"
