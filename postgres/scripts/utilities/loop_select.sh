# ------------------------------------------------------------------------------
# File       : loop_select.sh
# Purpose    : postgres utilities helper: loop select.
# Engine     : postgres
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./loop_select.sh
# Parameters : Review script body before running.
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
while true;
do
psql  postgres -c 'select now() ,inet_server_addr(), pg_postmaster_start_time() '; 
echo -e "\n\n"
sleep 10
done

