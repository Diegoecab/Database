# ------------------------------------------------------------------------------
# File       : rds.cli.proxies.sh
# Purpose    : aws cloud/rds helper: rds.cli.proxies.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.proxies.sh
# Parameters : Review script body before running.
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds describe-db-proxies
aws rds describe-db-proxy-targets --db-proxy-name rds-pg-labs-proxy --region us-east-1
aws rds describe-db-proxy-target-groups --db-proxy-name rds-pg-labs-proxy
