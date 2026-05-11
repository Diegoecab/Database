# ------------------------------------------------------------------------------
# File       : rds.cli.describe-db-engine-versions.validpathupgrade.sh
# Purpose    : aws cloud/rds helper: rds.cli.describe db engine versions.validpathupgrade.
# Engine     : aws
# Category   : cloud/rds
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rds.cli.describe-db-engine-versions.validpathupgrade.sh
# Parameters : EngineVersion
# Risk       : READ_ONLY
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
aws rds describe-db-engine-versions --engine postgres --engine-version 13.11 --query DBEngineVersions[*].ValidUpgradeTarget[*].{EngineVersion:EngineVersion} --region eu-west-1
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.PostgreSQL.html#USER_UpgradeDBInstance.PostgreSQL.MajorVersion
