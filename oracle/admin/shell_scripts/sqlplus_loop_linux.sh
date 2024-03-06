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

