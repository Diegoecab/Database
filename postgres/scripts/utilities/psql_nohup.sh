# ------------------------------------------------------------------------------
# File       : psql_nohup.sh
# Purpose    : postgres utilities helper: psql nohup.
# Engine     : postgres
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./psql_nohup.sh
# Parameters : PGPASSWORD
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
export PGPASSWORD="${PGPASSWORD:?set PGPASSWORD before running}"
nohup psql -h "${PGHOST:-myhost}" -U "${PGUSER:-postgres}" -d "${PGDATABASE:-trnpds}" -p "${PGPORT:-15050}" -f "${PGSCRIPT:-pk_create.sql}" &
