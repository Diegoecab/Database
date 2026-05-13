REM	Script para ver la diferencia de un profile no default contra el valor del profile default
REM ======================================================================
REM profiles_dif_nodefault.sql		Version 1.1	22 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM 
REM Dependencias:
REM	
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set verify off
set linesize 200
col limit for a20
col limit_default for a20
select distinct profile from dba_profiles;
accept PROFILE prompt 'Ingrese nombre de perfil: '
select a.*,b.limit limit_default 
from dba_profiles a, dba_profiles b where a.profile = '&PROFILE' and b.profile= 'DEFAULT' 
and a.resource_name=b.resource_name 
and a.limit <> 'DEFAULT' and a.limit <> b.limit 
order by 1,2;
prompt Usuarios con el perfil
select username from dba_users where profile='&PROFILE';