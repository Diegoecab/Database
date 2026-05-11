# ------------------------------------------------------------------------------
# File       : create-endpoint.sh
# Purpose    : aws cloud/dms helper: create endpoint.
# Engine     : aws
# Category   : cloud/dms
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./create-endpoint.sh
# Parameters : Review script body before running.
# Risk       : CHANGES
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
for r in {11..100}
do
	aws dms create-endpoint \
    --endpoint-type source \
	--engine-name oracle \
	--endpoint-identifier src-endpoint-$r-orcl \
    --oracle-settings file://orcl-endpoint-settings.json
done
	

{
  "DatabaseName": "ORCL",
  "Password": "oraadmin1",
  "Port": 1521,
  "ServerName": "testing",
  "Username": "string"
}

