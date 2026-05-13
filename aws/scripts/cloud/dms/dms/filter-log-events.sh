# ------------------------------------------------------------------------------
# File       : filter-log-events.sh
# Purpose    : aws cloud/dms helper: filter log events.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./filter-log-events.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws logs filter-log-events --log-group-name dms-tasks-clicksdba-ora2pg-prod-pads1fe --log-stream-names dms-task-TGHPEZ57ANXV52QLIQMSLO46RA --filter-pattern "invalid byte sequence"
