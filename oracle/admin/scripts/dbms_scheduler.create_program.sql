--dbms_scheduler.create_program.sql


prompt program_name:	"DBADMIN"."PRG_STATISTICS"
prompt program_type:	plsql_block / stored_procedure
prompt program_action:	"STAT_GATHER_PKG"."GATHER_STATISTICS"



begin
dbms_scheduler.create_program (
   program_name          => '&program_name',
   program_type          => '&program_type',
   program_action        => '&program_action',
   number_of_arguments   => 0,
   enabled               => &enabled,
   comments              => '&comments');
end;
/

commit;