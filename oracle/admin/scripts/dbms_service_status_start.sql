SELECT name,
       network_name
FROM   v$active_services
ORDER BY 1;

col name for a20 truncate
col network_name for a20 truncate
col pdb for a20 truncate
set lines 500
select name, network_name, enabled, pdb, GLOBAL_SERVICE, GOAL,EDITION from dba_services;
select name, network_name, enabled, pdb, GLOBAL_SERVICE, GOAL,EDITION from cdb_services;


PDB

BEGIN
  dbms_service.stop_service(
    service_name => 'rio112'
  );
END;
/

BEGIN
  dbms_service.start_service(
    service_name => 'rio112'
  );
END;
/


---start_all:


begin
for r in (
select name from dba_services a where not exists (select 1 from v$active_services b where lower(b.name)=lower(a.name) 
and lower(b.network_name)=lower(a.network_name))
)
loop
dbms_output.put_line ('Starting service '||r.name);
  dbms_service.start_service(
    service_name => r.name
  );
end loop;
end;
/



for db in `ps -ef | grep pmon | grep -v grep | awk '{ print $8 }' | cut -d '_' -f3 | grep -v "^+" | grep -v "^-"`
do
 echo -e "\n database is $db"
export ORAENV_ASK=NO
export PATH=$ORACLE_HOME/bin:.:$PATH
export ORACLE_SID=$db
. oraenv 2>/dev/null 1>/dev/null
sqlplus -s / as sysdba <<!

set serveroutput on
begin
for r in (select name from v\$pdbs where name<>'PDB$SEED') loop
	execute immediate ('alter session set container='||r.name);
	
	begin
		for h in (
		select name from dba_services a where not exists (select 1 from v$active_services b where lower(b.name)=lower(a.name) 
		and lower(b.network_name)=lower(a.network_name))
		)
		loop
			begin
				dbms_output.put_line ('Starting service '||h.name);
				dbms_service.start_service(
					service_name => h.name
				  );
			exception when others then
			dbms_output.put_line ('error al levantar servicio '||h.name);
			dbms_output.put_line (SQLCODE);
			end;
		end loop;
	end;
end loop;
end;
/
!
done