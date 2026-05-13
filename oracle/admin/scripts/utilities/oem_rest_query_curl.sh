# ------------------------------------------------------------------------------
# File       : oem_rest_query_curl.sh
# Purpose    : Oracle administration helper: oem rest query curl.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./oem_rest_query_curl.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : READ ONLY
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
#https://docs.oracle.com/en/enterprise-manager/cloud-control/enterprise-manager-cloud-control/13.4/emadm/executing-sql-rest-api.html

curl --user sysman:Prodentmgr13c --insecure -i -X POST -H 'Content-Type: application/json' -d '{ "sqlStatement": "SELECT * FROM sysman.MGMT$TARGET_METRIC_SETTINGS", "maxRowLimit": 2, "maxColumnLimit": 4 }' https://lxentmgr01.ar.bsch:7802/em/websvcs/restful/emws/oracle.sysman.db/executesql/repository/query/v1



curl --user sysman:Prodentmgr13c --insecure -i -X POST -H 'Content-Type: application/json' \
-d '{ "sqlStatement": "SELECT app_code,machinename,oraclehome,sid,version FROM found_db_oms_databases_apps where \"DB_NAME\"='\''RIO250'\'' AND \"LIFECYCLE_STATUS\"='\''Production'\''"}' \
 https://lxentmgr01.ar.bsch:7802/em/websvcs/restful/emws/oracle.sysman.db/executesql/repository/query/v1

\"APP_CODE\"='\''DBC'\'' 

curl --insecure -i -X POST --header 'Authorization: Basic c3lzbWFuOlByb2RlbnRtZ3IxM2M=' \
-H 'Content-Type: application/json' -d '{ "sqlStatement": "SELECT * FROM found_db_oms_databases_apps", "maxRowLimit": 2}' \
 https://lxentmgr01.ar.bsch:7802/em/websvcs/restful/emws/oracle.sysman.db/executesql/repository/query/v1


