# ------------------------------------------------------------------------------
# File       : listener_log_grep_users_host.sh
# Purpose    : Oracle security, audit, user, role or grants helper: listener log grep users host.
# Category   : security
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./listener_log_grep_users_host.sh
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
ORASID=326D
grep -i $ORASID listener_5321.log| grep -v telegraf| grep -v `hostname` | grep -v `hostname -I | awk '{print $1}'` | grep establish| grep -oP '(?<=USER=)\w+'| sort | uniq -c | sort -nr
grep -i $ORASID listener_5321.log| grep -v telegraf| grep -v `hostname` | grep -v `hostname -I | awk '{print $1}'` | grep establish| grep -oP '(?<=HOST=)\w+'| sort | uniq -c | sort -nr
grep -i $ORASID listener_5321.log| grep -v telegraf| grep -v `hostname` | grep -v `hostname -I | awk '{print $1}'` | grep establish| grep -oP '(?<=PROGRAM=)\w+'| sort | uniq -c | sort -nr