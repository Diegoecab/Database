# ------------------------------------------------------------------------------
# File       : network_latency_mtr.sh
# Purpose    : os platform/linux helper: network latency mtr.
# Engine     : os
# Category   : platform/linux
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./network_latency_mtr.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
#You can run the report like below from both the on-prem and ec2 instance to compare the network latency.

mtr --report --tcp --port 1571 endpoint
