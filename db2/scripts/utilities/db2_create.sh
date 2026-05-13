# ------------------------------------------------------------------------------
# File       : db2_create.sh
# Purpose    : db2 utilities helper: db2 create.
# Engine     : db2
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./db2_create.sh
# Parameters : Review script body before running.
# Risk       : CHANGES
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
db2 create database sample
db2 create database sample using codeset SJIS territory JP collate using system page 32 k
