# ------------------------------------------------------------------------------
# File       : srv.gns_config.sh
# Purpose    : Oracle RAC or cluster administration helper: srv gns config.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./srv.gns_config.sh
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
srvctl config gns -a
echo "see config in /etc/named.conf"