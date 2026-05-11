# ------------------------------------------------------------------------------
# File       : srvctl.asm.status.sh
# Purpose    : Oracle storage, ASM, ACFS or tablespace helper: srvctl asm status.
# Category   : storage
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./srvctl.asm.status.sh
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
srvctl status asm -node rdp6adm02vm02 -detail