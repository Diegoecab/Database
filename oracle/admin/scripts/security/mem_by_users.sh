# ------------------------------------------------------------------------------
# File       : mem_by_users.sh
# Purpose    : Oracle security, audit, user, role or grants helper: mem by users.
# Category   : security
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./mem_by_users.sh
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
echo "USER                 RSS      PROCS" ; echo "-------------------- -------- -----" ; ps hax -o rss,user | awk '{rss[$2]+=$1;procs[$2]+=1;}END{for(user in rss) printf "%-20s %8.0f %5.0f\n", user, rss[user]/1024, procs[user];}' | sort -rnk2