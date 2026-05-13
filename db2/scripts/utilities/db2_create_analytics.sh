# ------------------------------------------------------------------------------
# File       : db2_create_analytics.sh
# Purpose    : db2 utilities helper: db2 create analytics.
# Engine     : db2
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./db2_create_analytics.sh
# Parameters : Review script body before running.
# Risk       : CHANGES
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
db2set db2_worlload=analytics
db2 create database cars
dv2 create table cars_db (c1,..c100)
