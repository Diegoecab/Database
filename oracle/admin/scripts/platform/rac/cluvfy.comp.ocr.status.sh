# ------------------------------------------------------------------------------
# File       : cluvfy.comp.ocr.status.sh
# Purpose    : Oracle RAC or cluster administration helper: cluvfy comp ocr status.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./cluvfy.comp.ocr.status.sh
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
cluvfy comp ocr -n all -verbose
#Verify Node connectivity between all nodes:
cluvfy comp nodecon -n all -verbose