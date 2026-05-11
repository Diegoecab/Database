# ------------------------------------------------------------------------------
# File       : oh_clone_12.1.sh
# Purpose    : Oracle administration helper: oh clone 12 1.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./oh_clone_12.1.sh
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
SOURCE_PATH=/oracle/SOFT_REPO/Linux_x86_64/RDBMS12.1.0.2/
DBHOME_FILE=RDBMS12.1.0.2.0_JUL2017.tgz
ORACLE_HOME_DEST=/oracle/app/oracle/product/12c
tar zxvf RDBMS12.1.0.2.0_APR2020.tgz -C /
RUNNINSTALLER_COMMAND="cd ${ORACLE_HOME_DEST}/clone/bin; ./clone.pl -silent UNIX_GROUP_NAME=oinstall ORACLE_BASE=/oracle/app/oracle ORACLE_HOME=$ORACLE_HOME_DEST \
OSDBA_GROUP=dba OSOPER_GROUP=oper OSASM_GROUP=asmadmin OSBACKUPDBA_GROUP=backupdba OSDGDBA_GROUP=dgdba OSKMDBA_GROUP=kmdba OSRACDBA_GROUP=racdba -ignoreSysPrereqs; $ORACLE_HOME_DEST/bin/diagsetup basedir=/oracle/app/oracle oraclehome=$ORACLE_HOME_DEST"
