# ------------------------------------------------------------------------------
# File       : netstat.listen.sh
# Purpose    : os platform/linux helper: netstat.listen.
# Engine     : os
# Category   : platform/linux
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./netstat.listen.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
sudo netstat -tulpn | grep LISTEN
