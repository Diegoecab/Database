# ------------------------------------------------------------------------------
# File       : rds.cli.create_db_instance.sh
# Purpose    : aws cloud/rds helper: rds.cli.create db instance.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.create_db_instance.sh
# Parameters : Review script body before running.
# Risk       : CHANGES
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds create-db-instance \
--db-instance-identifier diegoec-cdb \
--db-name pdb1 \
--engine oracle-ee-cdb \
--db-instance-class db.t3.medium \
--engine-version 19.0.0.0.ru-2024-01.rur-2024-01.r1 \
--multi-tenant \
--storage-type gp3 \
--allocated-storage 20 \
--master-username oraadmin \
--master-user-password oraadmin1 \
--vpc-security-group-ids "sg-0aae60f95c2830148"
