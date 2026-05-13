# ------------------------------------------------------------------------------
# File       : rds.cli.describe_db_instances.sh
# Purpose    : aws cloud/rds helper: rds.cli.describe db instances.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.describe_db_instances.sh
# Parameters : Review script body before running.
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds describe-db-instances \
 --db-instance-identifier rds-pg-labs \
 --region us-east-1 \
  --output table \
--query 'DBInstances[*].DomainMemberships'
# --profile aws-acc-1 \

aws rds describe-db-instances --region us-east-1 --query 'DBInstances[*].[DBInstanceIdentifier,AvailabilityZone]' \
 --filters Name="db-cluster-id",Values="prd-sum-useast1-core-cluster"
