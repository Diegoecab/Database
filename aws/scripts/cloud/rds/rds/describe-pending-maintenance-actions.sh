# ------------------------------------------------------------------------------
# File       : describe-pending-maintenance-actions.sh
# Purpose    : aws cloud/rds helper: describe pending maintenance actions.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./describe-pending-maintenance-actions.sh
# Parameters : aws, db, eu, oracl, rds
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds describe-pending-maintenance-actions --resource-identifier arn:aws:rds:eu-west-1:605111634786:db:oracl-stg-tid01-01
aws rds describe-pending-maintenance-actions --filters Name=db-instance-id,Values=imm01ps
