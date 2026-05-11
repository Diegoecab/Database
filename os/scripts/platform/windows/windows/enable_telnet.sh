# ------------------------------------------------------------------------------
# File       : enable_telnet.sh
# Purpose    : os platform/windows helper: enable telnet.
# Engine     : os
# Category   : platform/windows
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./enable_telnet.sh
# Parameters : TelnetClient
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
dism /online /Enable-Feature /FeatureName:TelnetClient
