# ------------------------------------------------------------------------------
# File       : rds.cli.restorepointintime.cluster.sh
# Purpose    : aws cloud/rds helper: rds.cli.restorepointintime.cluster.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.restorepointintime.cluster.sh
# Parameters : Review script body before running.
# Risk       : DESTRUCTIVE
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds restore-db-cluster-to-point-in-time \
    --source-db-cluster-identifier dbtestencod \
    --db-cluster-identifier aupg15-restored \
    --restore-type copy-on-write \
    --vpc-security-group-ids sg-0d2545482618dda5c \
   --db-subnet-group-name apg-labstack-aupglabsrdsstack-1vp537traavq6-dbsubnets-nool4qqn5klb \
    --use-latest-restorable-time

aws rds create-db-instance \
    --db-instance-identifier writer-instance \
	--engine aurora-postgresql \
    --db-instance-class db.t3.medium \
    --db-subnet-group-name apg-labstack-aupglabsrdsstack-1vp537traavq6-dbsubnets-nool4qqn5klb \
	--db-cluster-identifier aupg15-restored \
	--publicly-accessible
