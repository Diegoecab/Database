# ------------------------------------------------------------------------------
# File       : get_dbm_cfg.sh
# Purpose    : db2 utilities helper: get dbm cfg.
# Engine     : db2
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./get_dbm_cfg.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
db2 get db cfg
