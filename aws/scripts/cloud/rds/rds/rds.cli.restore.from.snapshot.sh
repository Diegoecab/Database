# ------------------------------------------------------------------------------
# File       : rds.cli.restore.from.snapshot.sh
# Purpose    : aws cloud/rds helper: rds.cli.restore.from.snapshot.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.restore.from.snapshot.sh
# Parameters : Review script body before running.
# Risk       : DESTRUCTIVE
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
# Restoring from a snapshot to a Multi-AZ DB cluster
aws rds restore-db-cluster-from-snapshot \
    --db-cluster-identifier mynewmultiazdbcluster \
    --snapshot-identifier mysnapshot \
    --engine mysql|postgres \
    --db-cluster-instance-class db.r6gd.xlarge
	
# Restoring from a Multi-AZ DB cluster snapshot to a DB instance
aws rds restore-db-instance-from-db-snapshot \
    --db-instance-identifier mynewdbinstance \
    --db-cluster-snapshot-identifier myclustersnapshot \
    --engine mysql \
    --multi-az \
    --db-instance-class db.r6g.xlarge