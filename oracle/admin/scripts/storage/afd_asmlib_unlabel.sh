# ------------------------------------------------------------------------------
# File       : afd_asmlib_unlabel.sh
# Purpose    : Oracle storage, ASM, ACFS or tablespace helper: afd asmlib unlabel.
# Category   : storage
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./afd_asmlib_unlabel.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : REVIEW
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
asmcmd afd_lsdsk

--------------------------------------------------------------------------------
Label                     Filtering   Path
================================================================================
ORA_DATA_01                 ENABLED   /dev/sdc1
ORA_DATA_02                 ENABLED   /dev/sdd1
ORA_FRA_01                  ENABLED   /dev/sde1


asmcmd afd_unlabel /dev/sdc1
asmcmd afd_unlabel /dev/sdd1
asmcmd afd_unlabel /dev/sde1