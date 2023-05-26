spool ejecuta.log

/*

Para cada cambio, editar:
1) especificar valor de variable en seccion "1) Variables"
2) especificar listado de archivos a ejecutar en session "2) archivos a ejecutar"

*/

set head off
set feed off
set timing on
set lines 300
WHENEVER SQLERROR EXIT SQL.SQLCODE



VARIABLE err NUMBER;
VARIABLE numero_cambio   varchar2(100);
VARIABLE nls_lang   varchar2(100);
VARIABLE usuario   varchar2(100);
VARIABLE dbname  varchar2(100);

--1) Variables

/*
Especificar los valores que se desea validar antes de ejecutar el change.
Si algun valor no se cumple, no se continuara con la ejecucion del/los scripts debajo del pl/sql
*/
begin
 :numero_cambio:= 'CH-XXXXXX';
 :nls_lang := 'SPANISH_SPAIN.WE8MSWIN1252';
 :usuario := 'S_RG_PRD_ACSREP2';
 :dbname := 'shengp1';
end;
/


select to_char(sysdate,'DD-MM-YY HH24:MI:SS') from dual;
Prompt Inicio de script ejecuta.sql, cambio CH-XXXXXX


Prompt Inicio de validaciones de variables de contexto

set serveroutput on
begin
:err := 0;
for r in (
	SELECT 
	sys_context('userenv','LANGUAGE') current_nls,
	sys_context ('userenv','CURRENT_SCHEMA') current_usr,
	sys_context ('userenv','DB_NAME') current_dbname
	from dual
 ) loop

if r.current_nls != :nls_lang or  r.current_usr != :usuario or r.current_dbname != :dbname THEN
	dbms_output.put_line ('============================================================================================');
	dbms_output.put_line ('ERROR: Variables de ambiente no seteadas correctamente. Variables actuales: ');
	dbms_output.put_line ('nls_lang: '||r.current_nls||', usuario: '||r.current_usr||', base de datos: '||r.current_dbname);
	dbms_output.put_line ('requerido: ');
	dbms_output.put_line ('nls_lang: '||:nls_lang||', usuario: '||:usuario||', base de datos: '||:dbname);
	dbms_output.put_line ('============================================================================================');
	:err := 1;
else
	dbms_output.put_line ('============================================================================================');
	dbms_output.put_line ('Variables de ambiente seteadas correctamente. ');
	dbms_output.put_line ('nls_lang: '||r.current_nls||', usuario: '||r.current_usr||', base de datos: '||r.current_dbname);
	dbms_output.put_line ('============================================================================================');
end if;

end loop;
end;
/


begin
if :err = 1 then
execute immediate ('select error_variables from dual');
end if;
end;
/

--Valor por default: No salir en caso de error (Va a depender de como quiera manejarlo cada aplicacion)
WHENEVER SQLERROR CONTINUE
set head on
set feed on
set timing off



Prompt Inicio de ejecucion de scripts

--2) archivos a ejecutar

@01/ejecuta01.sql
@02/ejecuta02.sql
@02/ejecuta03.sql


select to_char(sysdate,'DD-MM-YY HH24:MI:SS') from dual;
Prompt Fin de script ejecuta.sql, cambio CH-XXXXXX

Spool off
