# ------------------------------------------------------------------------------
# File       : srv.config.vips.sh
# Purpose    : Oracle RAC or cluster administration helper: srv config vips.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./srv.config.vips.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : READ ONLY
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
echo "To determine the VIP hostname, VIP address"
srvctl config nodeapps -a
echo "To determine the current IP Address for the VIP Address"
srvctl config vip -n $HOSTNAME
