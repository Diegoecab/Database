# ------------------------------------------------------------------------------
# File       : rds.cli.describe_modify_instances.sh
# Purpose    : aws cloud/rds helper: rds.cli.describe modify instances.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.describe_modify_instances.sh
# Parameters : Review script body before running.
# Risk       : DESTRUCTIVE
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds describe-db-instances --db-instance-identifier do-not-delete-training-diegoec --query 'DBInstances[*].[DBInstanceStatus]'
aws rds modify-db-instance --db-instance-identifier do-not-delete-training-diegoec --backup-retention-period 1
