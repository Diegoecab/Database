# ------------------------------------------------------------------------------
# File       : asm_cp.sh
# Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asm cp(1).
# Category   : storage
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./asm_cp(1).sh
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
export DBI_TRACE=1

asmcmd cp --port 1521 +DATAC4/CSIBSP/orapwcsibsp sys@172.20.127.22.+ASM1:+DATA_HC2/CSIBSR/orapwcsibsr
 