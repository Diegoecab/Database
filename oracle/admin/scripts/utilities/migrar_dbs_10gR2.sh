# ------------------------------------------------------------------------------
# File       : migrar_dbs_10gR2.sh
# Purpose    : Oracle administration helper: migrar dbs 10gR2.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./migrar_dbs_10gR2.sh
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
export ORACLE_SID=p_cha_01
sqlplus / as sysdba <<EOF >>upgrade_p_cha_01.log 2>upgrade_p_cha_01.err
shutdown immediate
startup upgrade
@?/rdbms/admin/catupgrd.sql
@?/rdbms/admin/utlu102s.sql
shutdown immediate
startup
@?/rdbms/admin/olstrig.sql
@?/rdbms/admin/utlrp
SELECT count(*) FROM dba_objects WHERE status='INVALID';
SELECT distinct object_name FROM dba_objects WHERE status='INVALID';
exit
EOF

export ORACLE_SID=d_cha_01
sqlplus / as sysdba <<EOF >>upgrade_d_cha_01.log 2>upgrade_d_cha_01.err
shutdown immediate
startup upgrade
@?/rdbms/admin/catupgrd.sql
@?/rdbms/admin/utlu102s.sql
shutdown immediate
startup
@?/rdbms/admin/olstrig.sql
@?/rdbms/admin/utlrp
SELECT count(*) FROM dba_objects WHERE status='INVALID';
SELECT distinct object_name FROM dba_objects WHERE status='INVALID';
exit
EOF