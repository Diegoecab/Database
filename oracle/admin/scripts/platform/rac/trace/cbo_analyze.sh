#!/bin/sh
# ------------------------------------------------------------------------------
# File       : cbo_analyze.sh
# Purpose    : Oracle RAC or cluster administration helper: cbo analyze.
# Category   : platform/rac
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./cbo_analyze.sh
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

cat $1 | awk '

function p(str) { printf("%6d: %s\n", NR, str) ; return 0 }

/Now joining|Join order/{ p($0) } 

/^Best::/{ x=1 ; p($0) } 

(!/Best::/ && x ==1) { p($0) ; x=0 }

' 
