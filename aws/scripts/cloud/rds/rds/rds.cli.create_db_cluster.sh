# ------------------------------------------------------------------------------
# File       : rds.cli.create_db_cluster.sh
# Purpose    : aws cloud/rds helper: rds.cli.create db cluster.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.create_db_cluster.sh
# Parameters : Review script body before running.
# Risk       : CHANGES
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds create-db-cluster \
  --region us-east-1 \
  --db-cluster-identifier primary  \
  --master-username rdsadmin1 \
  --master-user-password rdsadmin1 \
  --engine aurora-postgresql \
  --engine-version 15.3

aws rds create-db-instance \
  --db-cluster-identifier primary \
  --db-instance-class db.r5.large \
  --db-instance-identifier instance-1 \
  --engine aurora-postgresql \
  --engine-version 15.3 \
  --region us-east-1

