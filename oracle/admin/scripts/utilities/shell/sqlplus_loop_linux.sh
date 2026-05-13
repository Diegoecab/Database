# ------------------------------------------------------------------------------
# File       : sqlplus_loop_linux.sh
# Purpose    : Oracle administration helper: sqlplus loop linux.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./sqlplus_loop_linux.sh
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
for R in {1..1000}
do
sqlplus -S "oraadmin/oraadmin1@(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = diegoec.ckyx0wdxr13x.us-east-1.rds.amazonaws.com) (PORT = 1521))(CONNECT_DATA = (SID = ORCL)))" <<EOF
set serveroutput off
set feed off
begin
for r in 1..1000 loop
insert into TESTAUDIT values (r,'TEST');
end loop;
commit;
end;
/
EOF
done

for R in {1..1000}
do
sqlplus -S "oraadmin/oraadmin1@(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = diegoec.ckyx0wdxr13x.us-east-1.rds.amazonaws.com) (PORT = 1521))(CONNECT_DATA = (SID = ORCL)))" <<EOF
insert into TESTAUDIT values (1,'TEST');
commit;
exit;
/
EOF
done

