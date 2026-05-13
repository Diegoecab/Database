# ------------------------------------------------------------------------------
# File       : pg_dump.sh
# Purpose    : postgres backup_recovery helper: pg dump.
# Engine     : postgres
# Category   : backup_recovery
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./pg_dump.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
pg_dump --host pg1214-13819666251.cdus3jhjlk3a.us-east-1.rds.amazonaws.com --port 5432 --username postgres --schema-only -n dms_sample --verbose postgres > dms_sample_dump.sql
