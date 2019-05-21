#!/bin/sh

mkdir -p /u01/app/oracle/admin/db01/adump
mkdir -p /u01/app/oracle/admin/db01/bdump
mkdir -p /u01/app/oracle/admin/db01/cdump
mkdir -p /u01/app/oracle/admin/db01/dpdump
mkdir -p /u01/app/oracle/admin/db01/pfile
mkdir -p /u01/app/oracle/admin/db01/udump
mkdir -p /u01/app/oracle/flash_recovery_area
mkdir -p /u01/app/oracle/oradata/db01
mkdir -p /u01/app/oracle/product/10.2.0/cfgtoollogs/dbca/db01
mkdir -p /u01/app/oracle/product/10.2.0/dbs
ORACLE_SID=db01; export ORACLE_SID
echo You should Add this entry in the /etc/oratab: db01:/u01/app/oracle/product/10.2.0:Y
/u01/app/oracle/product/10.2.0/bin/sqlplus /nolog @/u01/app/oracle/admin/db01/scripts/db01.sql
