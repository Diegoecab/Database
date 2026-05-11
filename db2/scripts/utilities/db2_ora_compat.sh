# ------------------------------------------------------------------------------
# File       : db2_ora_compat.sh
# Purpose    : db2 utilities helper: db2 ora compat.
# Engine     : db2
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./db2_ora_compat.sh
# Parameters : Review script body before running.
# Risk       : CHANGES
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
db2set db2_compatibility_vector=ORA
db2stop
db2START
db2 create database ora2db2
