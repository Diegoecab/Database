# ------------------------------------------------------------------------------
# File       : oms_host_encryption_check.sh
# Purpose    : Oracle administration helper: oms host encryption check.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./oms_host_encryption_check.sh
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

curl -k -vvvv https://omshost.com:1159  --ciphers rsa_aes_256_cbc_sha_256
