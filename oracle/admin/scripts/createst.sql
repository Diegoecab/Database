create database testtv
  controlfile reuse
  undo tablespace undo
  datafile '/u01/app/oracle/oradata/testtv/rbs01.dbf' size 200M reuse
  logfile  '/u01/app/oracle/oradata/testtv/redolog01.log' size 100M reuse,
           '/u01/app/oracle/oradata/testtv/redolog02.log' size 100M reuse,
           '/u01/app/oracle/oradata/testtv/Redolog03.log' size 100M reuse
  datafile '/u01/app/oracle/oradata/testtv/system01.dbf' size 200M reuse;

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

