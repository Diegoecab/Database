# ------------------------------------------------------------------------------
# File       : rds.cli.modify-db-instance.max-allocated-storage.sh
# Purpose    : aws cloud/rds helper: rds.cli.modify db instance.max allocated storage.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.modify-db-instance.max-allocated-storage.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds modify-db-instance --db-instance-identifier <rds-identifier> --max-allocated-storage 65536
