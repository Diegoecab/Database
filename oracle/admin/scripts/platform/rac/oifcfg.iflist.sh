# ------------------------------------------------------------------------------
# File       : oifcfg.iflist.sh
# Purpose    : Oracle RAC or cluster administration helper: oifcfg iflist.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./oifcfg.iflist.sh
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
#Determine the list of interfaces available to the cluster
echo Determine the list of interfaces available to the cluster
oifcfg iflist -p -n