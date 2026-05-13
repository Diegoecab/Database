# ------------------------------------------------------------------------------
# File       : wget - example.sh
# Purpose    : Oracle administration helper: wget example.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./wget - example.sh
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
wget --no-cookies --http-user=dcabrera@datastar.com.ar --http-password=aaaaaaaaaaaaaa --no-cookies --header "Cookie: gpw_e24=yippi ka yei madafaka;" --no-check-certificate --output-document=LINUX.X64_180000_db_home.zip "https://download.oracle.com/otn/linux/oracle18c/180000/LINUX.X64_180000_db_home.zip?AuthParam=1569443019_ab2af2f7889c9c8da555e5de98c0953a"