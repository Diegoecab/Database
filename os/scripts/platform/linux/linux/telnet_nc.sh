# ------------------------------------------------------------------------------
# File       : telnet_nc.sh
# Purpose    : os platform/linux helper: telnet nc.
# Engine     : os
# Category   : platform/linux
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./telnet_nc.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
#Port Scanning
nc -z host.example.com 20-30
#see if the port 22 is open on the host 192.168.56.10:
nc -zv 192.168.1.15 22
