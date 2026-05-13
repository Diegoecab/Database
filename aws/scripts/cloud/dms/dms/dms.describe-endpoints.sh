# ------------------------------------------------------------------------------
# File       : dms.describe-endpoints.sh
# Purpose    : aws cloud/dms helper: dms.describe endpoints.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./dms.describe-endpoints.sh
# Parameters : Review script body before running.
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws dms describe-endpoints --filters Name=endpoint-id,Values=$TDB
