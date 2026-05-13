# ------------------------------------------------------------------------------
# File       : rds.cli.describe-db-cluster-snapshots.sh
# Purpose    : aws cloud/rds helper: rds.cli.describe db cluster snapshots.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.describe-db-cluster-snapshots.sh
# Parameters : Review script body before running.
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds describe-db-cluster-snapshots \
    --db-cluster-identifier dbtestencod
	
aws rds describe-db-cluster-snapshots \
    --db-cluster-identifier dbtestencod --snapshot-type automated
