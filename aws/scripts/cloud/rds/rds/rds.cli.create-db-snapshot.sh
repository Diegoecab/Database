# ------------------------------------------------------------------------------
# File       : rds.cli.create-db-snapshot.sh
# Purpose    : aws cloud/rds helper: rds.cli.create db snapshot.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.create-db-snapshot.sh
# Parameters : Review script body before running.
# Risk       : CHANGES
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds create-db-snapshot \
    --db-instance-identifier database-mysql \
    --db-snapshot-identifier mydbsnapshot
