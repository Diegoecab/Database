# ------------------------------------------------------------------------------
# File       : rds.cli.modify-db-parameter-group.sh
# Purpose    : aws cloud/rds helper: rds.cli.modify db parameter group.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.modify-db-parameter-group.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds modify-db-parameter-group \
   --db-parameter-group-name custom-param-group-name \
   --parameters "ParameterName=pgaudit.role,ParameterValue=rds_pgaudit,ApplyMethod=pending-reboot" \
   --region aws-region


aws rds modify-db-parameter-group \
    --db-parameter-group-name pg11-source-transport-group \
    --parameters "ParameterName=pg_transport.num_workers,ParameterValue=4,ApplyMethod=immediate" \
                 "ParameterName=pg_transport.timing,ParameterValue=1,ApplyMethod=immediate" \
                 "ParameterName=pg_transport.work_mem,ParameterValue=131072,ApplyMethod=immediate" \
                 "ParameterName=shared_preload_libraries,ParameterValue=\"pg_stat_statements,pg_transport\",ApplyMethod=pending-reboot" \
                 "ParameterName=max_worker_processes,ParameterValue=24,ApplyMethod=pending-reboot"
