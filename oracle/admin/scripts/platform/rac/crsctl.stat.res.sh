# ------------------------------------------------------------------------------
# File       : crsctl.stat.res.sh
# Purpose    : Oracle RAC or cluster administration helper: crsctl stat res.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./crsctl.stat.res.sh
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
crsctl stat res ora.dbfsc1.avm_u071_01.acfs
crsctl stat res ora.dbfsc1.avm_u071_01.acfs -f