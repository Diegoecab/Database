# ------------------------------------------------------------------------------
# File       : describe_instances.sh
# Purpose    : aws cloud/dms helper: describe instances.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./describe_instances.sh
# Parameters : Review script body before running.
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws dms describe-replication-instances --query 'ReplicationInstances[*].[ReplicationInstanceIdentifier,EngineVersion]'
