echo "MAX PERFORMANCE"
dgmgrl -silent sys/sysgardbop1127 <<EOF
EDIT DATABASE 'GARDBOP' SET PROPERTY 'LogXptMode'='ASYNC';
EDIT DATABASE 'GARDBOP2' SET PROPERTY 'LogXptMode'='ASYNC';
EDIT CONFIGURATION SET PROTECTION MODE AS MAXPERFORMANCE;
enable configuration;
show configuration;
EOF
date
export ORACLE_SID=GARDBOP
echo "Carga en la base de datos"
sqlplus -s dbas/dbas @/home/oracle/sql/sql_test_1.sql &
sqlplus -s dbas/dbas @/home/oracle/sql/sql_test_2.sql &
sqlplus -s dbas/dbas @/home/oracle/sql/sql_test_3.sql &
echo "Truncate table"
sqlplus -s dbas/dbas <<EOF
truncate table prueba_stb;
EOF
date
echo "Inserts..."
sqlplus -s dbas/dbas <<EOF
set feedback off
set timing on
begin
for r in 1..1000000
loop
insert into prueba_stb (numero) values (r);
commit;
end loop;
end;
/
EOF
echo "Hora termina inserts:"
date
echo "Shutdown abort..."
sqlplus -s / as sysdba <<EOF
shutdown abort
EOF
date
echo "Verifico cantidad de inserts realizados en GARDBOP2"
ssh oraidx2a <<EOF
sh /home/oracle/bin/test_stb.sh
EOF
date
echo "Start GARDBOP"
sqlplus -s / as sysdba <<EOF
startup
alter system switch logfile;
EOF
date
echo "Fin MAX PERFORMANCE"
echo "MAX AVAILABILITY (Base STB Arriba)"
date
dgmgrl -silent sys/sysgardbop1127 <<EOF
EDIT DATABASE 'GARDBOP' SET PROPERTY 'LogXptMode'='SYNC';
EDIT DATABASE 'GARDBOP2' SET PROPERTY 'LogXptMode'='SYNC';
EDIT CONFIGURATION SET PROTECTION MODE AS MAXAVAILABILITY;
enable configuration;
show configuration;
EOF
date
echo "Carga en la base de datos"
sqlplus -s dbas/dbas @/home/oracle/sql/sql_test_1.sql &
sqlplus -s dbas/dbas @/home/oracle/sql/sql_test_2.sql &
sqlplus -s dbas/dbas @/home/oracle/sql/sql_test_3.sql &
echo "Truncate table"
sqlplus -s dbas/dbas <<EOF
truncate table prueba_stb;
EOF
date
echo "Inserts..."
sqlplus -s dbas/dbas <<EOF
set feedback off
set timing on
begin
for r in 1..1000000
loop
insert into prueba_stb (numero) values (r);
commit;
end loop;
end;
/
EOF
echo "Hora termina inserts:"
date
echo "Shutdown abort..."
sqlplus -s / as sysdba <<EOF
shutdown abort
EOF
date
echo "Verifico cantidad de inserts realizados en GARDBOP2"
ssh oraidx2a <<EOF
sh /home/oracle/bin/test_stb.sh
EOF
date
echo "Start GARDBOP"
sqlplus -s / as sysdba <<EOF
startup
alter system switch logfile;
EOF
date
echo "Fin MAX AVAILABILITY (Base STB Arriba)"
echo "MAX AVAILABILITY (Base STB Abajo)"
date
echo "Bajo base GARDBOP2"
ssh oraidx2a <<EOF
dbshut $ORACLE_HOME
EOF
date
echo "Carga en la base de datos"
sqlplus -s dbas/dbas @/home/oracle/sql/sql_test_1.sql &
sqlplus -s dbas/dbas @/home/oracle/sql/sql_test_2.sql &
sqlplus -s dbas/dbas @/home/oracle/sql/sql_test_3.sql &
echo "Truncate table"
sqlplus -s dbas/dbas <<EOF
truncate table prueba_stb;
EOF
date
echo "Inserts..."
sqlplus -s dbas/dbas <<EOF
set feedback off
set timing on
begin
for r in 1..1000000
loop
insert into prueba_stb (numero) values (r);
commit;
end loop;
end;
/
EOF
echo "Hora termina inserts:"
date
echo "Fin MAX AVAILABILITY (Base STB Abajo)"
echo "Levanto base STB"
ssh oraidx2a <<EOF
dbstart $ORACLE_HOME
EOF
date
echo "MAX PERFORMANCE"
dgmgrl -silent sys/sysgardbop1127 <<EOF
EDIT DATABASE 'GARDBOP' SET PROPERTY 'LogXptMode'='ASYNC';
EDIT CONFIGURATION SET PROTECTION MODE AS MAXPERFORMANCE;
EDIT DATABASE 'GARDBOP2' SET PROPERTY 'LogXptMode'='ASYNC';
enable configuration;
show configuration;
EOF
echo "Fin prueba"
date
