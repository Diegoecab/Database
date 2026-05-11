REM ======================================================================
REM diff_parameters.sql		Version 1.1	15 Febrero 2012
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM Tomar los parametros mas relevantes en la base de datos
REM Dependencias:
REM	v$parameter
REM
REM Notas:
REM 	Ejecutar usuario dba
REM	Para todas las versiones <= 7
REM
REM Precauciones:
REM	
REM ======================================================================
REM
col value for a30
col display_value for a30
col value_prod for a30
col value_dev for a30
col value_uat for a30
col display_value_prod for a30
col display_value_uat for a30
col display_value_dev for a30
col name for a50
set lines 400

select a.name,a.value value_prod,a.display_value display_value_prod,b.value value_uat,b.display_value display_value_uat from v$parameter a join
v$parameter@amluat_dc22057 b on b.name=a.name and upper(b.value) <> upper(a.value) and
a.name not in('dg_broker_config_file1','dg_broker_config_file2','control_files','audit_file_dest','background_dump_dest','core_dump_dest','user_dump_dest','spfile')
order by 1,2
/


select a.name,a.value value_prod,a.display_value display_value_prod,b.value value_dev,b.display_value display_value_dev from v$parameter a join
v$parameter@amldev_dc22057 b on b.name=a.name and upper(b.value) <> upper(a.value) and
a.name not in('dg_broker_config_file1','dg_broker_config_file2','control_files','audit_file_dest','background_dump_dest','core_dump_dest','user_dump_dest','spfile')
order by 1,2
/