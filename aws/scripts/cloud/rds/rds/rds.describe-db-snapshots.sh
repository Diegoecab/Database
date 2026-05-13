# ------------------------------------------------------------------------------
# File       : rds.describe-db-snapshots.sh
# Purpose    : aws cloud/rds helper: rds.describe db snapshots.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.describe-db-snapshots.sh
# Parameters : SnapshotType
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds describe-db-snapshots \
    --snapshot-type manual --output table

aws rds describe-db-snapshots \
    --snapshot-type manual \
    --query "length(*[].{DBSnapshots:SnapshotType})" \
    --region eu-central-1
