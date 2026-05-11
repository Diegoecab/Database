# ------------------------------------------------------------------------------
# File       : rds.cli.create--db-parameter-group.sh
# Purpose    : aws cloud/rds helper: rds.cli.create  db parameter group.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.create--db-parameter-group.sh
# Parameters : Review script body before running.
# Risk       : CHANGES
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#

aws rds create-db-parameter-group    --db-parameter-group-name postgres15pglab   --db-parameter-group-family postgres15  --description "My new parameter group"

