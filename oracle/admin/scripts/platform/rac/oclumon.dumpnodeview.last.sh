# ------------------------------------------------------------------------------
# File       : oclumon.dumpnodeview.last.sh
# Purpose    : Oracle RAC or cluster administration helper: oclumon dumpnodeview last.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./oclumon.dumpnodeview.last.sh
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
echo "Display node views from all nodes collected over the last 15 minutes"
oclumon dumpnodeview -allnodes -last "00:15:00"