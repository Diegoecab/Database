sqlplus / as sysdba << EOF
alter system flush buffer_cache;
shutdown immediate
startup
exit;
EOF
sqlplus /nolog @random.sql &
sqlplus /nolog @random.sql &
sqlplus /nolog @random.sql &
sqlplus /nolog @random.sql &