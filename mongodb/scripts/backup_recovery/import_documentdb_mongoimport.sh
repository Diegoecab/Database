# ------------------------------------------------------------------------------
# File       : import_documentdb_mongoimport.sh
# Purpose    : mongodb backup_recovery helper: import documentdb mongoimport.
# Engine     : mongodb
# Category   : backup_recovery
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./import_documentdb_mongoimport.sh
# Parameters : Review script body before running.
# Risk       : REVIEW
# Output     : Client, shell or script-defined output.
# Notes      : Validate in a non-production environment before operational use.
# Source     : internal
# Change Log :
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#

mongoimport --ssl \
    --host="${DOCDB_HOST:?set DOCDB_HOST, for example cluster endpoint with port}" \
    --collection="${DOCDB_COLLECTION:-order}" \
    --db="${DOCDB_DATABASE:-test}" \
    --file="${DOCDB_IMPORT_FILE:-order.json}" \
    --numInsertionWorkers 4 \
    --username="${DOCDB_USERNAME:?set DOCDB_USERNAME}" \
    --password="${DOCDB_PASSWORD:?set DOCDB_PASSWORD}" \
    --sslCAFile "${DOCDB_CA_FILE:-global-bundle.pem}"
	
