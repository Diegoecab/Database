# ------------------------------------------------------------------------------
# File       : listener_log_grep_logins.sh
# Purpose    : Oracle administration helper: listener log grep logins.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./listener_log_grep_logins.sh
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
file=/oracle/diag/tnslsnr/dblxorainet01/listener_7366/trace/listener_7366.log
BASE=RIO29
FECHA=01-JUL-2021
HORA=18
cat $file|grep ^[0-9]|grep -v service_update|grep -v service_register|grep "$FECHA $HORA"|grep -v ping|awk '{print $1,$2}'|cut -d ":" -f 1,2|sort | uniq|while read ff
do
echo $ff " ----> " `cat $file|grep "$ff"|grep -i $BASE|grep 0$|wc -l`
done

