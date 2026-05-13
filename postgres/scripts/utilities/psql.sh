# ------------------------------------------------------------------------------
# File       : psql.sh
# Purpose    : postgres utilities helper: psql.
# Engine     : postgres
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./psql.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
psql -h dbtestencod.cluster-cdus3jhjlk3a.us-east-1.rds.amazonaws.com -U testpasword8 -d postgres
psql host=dbtestencod.cluster-cdus3jhjlk3a.us-east-1.rds.amazonaws.com --username=testpasword8
