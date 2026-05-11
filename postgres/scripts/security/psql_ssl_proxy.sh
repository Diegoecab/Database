# ------------------------------------------------------------------------------
# File       : psql_ssl_proxy.sh
# Purpose    : postgres security helper: psql ssl proxy.
# Engine     : postgres
# Category   : security
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./psql_ssl_proxy.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
psql "sslmode=require host=proxy-1699481485728-serverlessv2.proxy-cdus3jhjlk3a.us-east-1.rds.amazonaws.com user=postgres sslrootcert=rds-ca-2019-root.pem"
