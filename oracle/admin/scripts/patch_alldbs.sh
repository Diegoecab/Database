#!/bin/bash
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