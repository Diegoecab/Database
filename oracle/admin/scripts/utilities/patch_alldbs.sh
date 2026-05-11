#!/bin/bash
# ------------------------------------------------------------------------------
# File       : patch_alldbs.sh
# Purpose    : Oracle administration helper: patch alldbs.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./patch_alldbs.sh
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
for db in `cat /etc/oratab|egrep ':N|:Y'|cut -f1 -d':'`
do
 echo "database is $db"
export ORACLE_SID=$db

cd $ORACLE_HOME/sqlpatch/27475598
sqlplus / as sysdba <<! >> /home/oracle/$db.upgrade.log 2>&1
shutdown immediate
STARTUP upgrade
@postinstall.sql
shutdown immediate
startup
@?/rdbms/admin/utlrp.sql
@?/rdbms/admin/catbundle.sql psu apply
@?/rdbms/admin/utlrp.sql
exit;
!


done