ORACLE_SID=desatv
export ORACLE_SID
ORACLE_BASE=/u01/app/oracle
export ORACLE_BASE
ORACLE_HOME=/u01/app/oracle/product/9.2.0
export ORACLE_HOME

echo
echo Running Make Database Script ...
echo
echo ORACLE_SID  = $ORACLE_SID
echo ORACLE_BASE = $ORACLE_BASE
echo ORACLE_HOME = $ORACLE_HOME
echo

cp ./init$ORACLE_SID.ora $ORACLE_BASE/admin/$ORACLE_SID/pfile
cp ./init$ORACLE_SID.ora $ORACLE_BASE/admin/$ORACLE_SID/create
ln -fs $ORACLE_BASE/admin/$ORACLE_SID/pfile/init$ORACLE_SID.ora $ORACLE_HOME/dbs/init$ORACLE_SID.ora
cp ./creabase.sh $ORACLE_BASE/admin/$ORACLE_SID/create

$ORACLE_HOME/bin/orapwd FILE=$ORACLE_BASE/admin/$ORACLE_SID/pfile/orapw$ORACLE_SID PASSWORD=desatv ENTRIES=10
ln -fs $ORACLE_BASE/admin/$ORACLE_SID/pfile/orapw$ORACLE_SID $ORACLE_HOME/dbs/orapw$ORACLE_SID

sqlplus "sys/oracle as sysdba" <<EOF
spool $ORACLE_BASE/admin/$ORACLE_SID/create/createdb

startup nomount pfile="$ORACLE_BASE/admin/$ORACLE_SID/pfile/init$ORACLE_SID.ora"

create database $ORACLE_SID
  controlfile reuse 
  undo tablespace undo
  datafile '$ORACLE_BASE/oradata/$ORACLE_SID/rbs01.dbf' size 200M reuse
  logfile  '$ORACLE_BASE/oradata/$ORACLE_SID/redolog01.log' size 100M reuse,
           '$ORACLE_BASE/oradata/$ORACLE_SID/redolog02.log' size 100M reuse,
           '$ORACLE_BASE/oradata/$ORACLE_SID/Redolog03.log' size 100M reuse
  datafile '$ORACLE_BASE/oradata/$ORACLE_SID/system01.dbf' size 200M reuse;


create temporary tablespace TEMP
  tempfile '$ORACLE_BASE/oradata/$ORACLE_SID/temp01.dbf' size 200 M reuse
  extent management local uniform size 64k;
create tablespace GEMDATXX
  datafile '$ORACLE_BASE/oradata/$ORACLE_SID/gemdatxx01.dbf' size 400 M reuse
  logging
  extent management local uniform size 20M;
create tablespace GEMIDXXX
  datafile '$ORACLE_BASE/oradata/$ORACLE_SID/gemidxxx01.dbf' size 400 M reuse
  logging
  extent management local uniform size 20M;
create tablespace GEMDATMM
  datafile '$ORACLE_BASE/oradata/$ORACLE_SID/gemdatmm01.dbf' size 400 M reuse
  logging
  extent management local uniform size 5M;
create tablespace GEMIDXMM
  datafile '$ORACLE_BASE/oradata/$ORACLE_SID/gemidxmm01.dbf' size 400 M reuse
  logging
  extent management local uniform size 5M;
create tablespace GEMDATSS
  datafile '$ORACLE_BASE/oradata/$ORACLE_SID/gemdatss01.dbf' size 400 M reuse
  logging
  extent management local uniform size 1M;
create tablespace GEMIDXSS
  datafile '$ORACLE_BASE/oradata/$ORACLE_SID/gemidxss01.dbf' size 400 M reuse
  logging
  extent management local uniform size 1M;

alter user sys    temporary tablespace TEMP;
alter user system temporary tablespace TEMP;

@$ORACLE_HOME/rdbms/admin/catalog.sql
@$ORACLE_HOME/rdbms/admin/catproc.sql

@$ORACLE_HOME/rdbms/admin/catdbsyn.sql
@$ORACLE_HOME/sqlplus/admin/pupbld.sql


alter user dbsnmp temporary tablespace TEMP;
alter user outln  temporary tablespace TEMP;

grant sysdba to sys;
grant sysdba to system;



shutdown

spool off
EOF

echo "$ORACLE_SID = " >> $ORACLE_HOME/network/admin/tnsnames.ora
echo " (DESCRIPTION = " >> $ORACLE_HOME/network/admin/tnsnames.ora
echo "   (ADDRESS_LIST = " >> $ORACLE_HOME/network/admin/tnsnames.ora
echo "     (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1521))" >> $ORACLE_HOME/network/admin/tnsnames.ora
echo "   )" >> $ORACLE_HOME/network/admin/tnsnames.ora
echo "   (CONNECT_DATA =" >> $ORACLE_HOME/network/admin/tnsnames.ora
echo "     (SERVICE_NAME = $ORACLE_SID)" >> $ORACLE_HOME/network/admin/tnsnames.ora
echo "   )" >> $ORACLE_HOME/network/admin/tnsnames.ora
echo " )" >> $ORACLE_HOME/network/admin/tnsnames.ora
