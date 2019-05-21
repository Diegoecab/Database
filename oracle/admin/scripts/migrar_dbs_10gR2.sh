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