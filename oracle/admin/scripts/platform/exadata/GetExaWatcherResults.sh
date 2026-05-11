# ------------------------------------------------------------------------------
# File       : GetExaWatcherResults.sh
# Purpose    : Oracle Exadata administration helper: GetExaWatcherResults.
# Category   : platform/exadata
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./GetExaWatcherResults.sh
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
ExaWatcher utility on Exadata database servers and storage cells (Doc ID 1617454.1)
Example: 
# ./GetExaWatcherResults.sh --from 01/25/2014_13:00:00 --to 01/25/2014_14:00:00
