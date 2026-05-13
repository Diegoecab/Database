# ------------------------------------------------------------------------------
# File       : port.sh
# Purpose    : mysql utilities helper: port.
# Engine     : mysql
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./port.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
grep port /etc/mysql/my.cnf
netstat -tlpn | grep mysql

