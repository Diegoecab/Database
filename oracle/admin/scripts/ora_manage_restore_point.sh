#!/bin/sh
#
# ora_manage_restore_point.sh
#
# Author: Diego Cabrera
#
#
# Crea consulta o elimina un restore point en o mas DBs Oracle
#
# 	Creacion -> crea el RP guarantee en caso de que no exista. 
#				-> Se pone la base en Flashback si se especifica -f
# 	Eliminacion -> Elimina el RP especificado en caso de que exista
#	Consulta -> Lista RP con configuracion de Flashback y archivelog
#

HEADER_SQL="
set serveroutput on
set feed off
set head off
set verify off
set lines 600
"

INF_QUERY="
declare
v_name varchar2(30) := null;
v_flashback_on varchar2(30) := null;
v_log_mode varchar2(30) := null;
v_database_role varchar2(30) := null;
v_force_logging varchar2(30) := null;
v_host_name varchar2(50) := null;
v_db_fb_ret_target varchar2(50) := null;
begin
select host_name into v_host_name from v\$instance;
select value into v_db_fb_ret_target from v\$parameter where name='db_flashback_retention_target';
select name,flashback_on,log_mode,database_role,force_logging into v_name,v_flashback_on,v_log_mode,v_database_role,v_force_logging from v\$database;
dbms_output.put_line ('Host_name:'||v_host_name||',db_name:'||v_name||',flashback_on:'||v_flashback_on||',log_mode:'||v_log_mode||',database_role:'||v_database_role||',force_logging:'||v_force_logging||',db_flashback_retention_target:'||v_db_fb_ret_target);
/*if v_flashback_on  'YES' then
    dbms_output.put_line ('Flasback database is disabled');
end if;*/
exception when others then
    dbms_output.put_line ('ERROR: '||SQLERRM||' SQLCODE:'||SQLCODE);
end;
/";

QUERY="${HEADER_SQL}
${INF_QUERY}"

for db in `ps -ef | grep pmon | grep -v grep | awk '{ print $8 }' | cut -d '_' -f3 | grep -v "^+" | grep -v "^-"`
do
export ORAENV_ASK=NO
export PATH=$ORACLE_HOME/bin:.:$PATH
export ORACLE_SID=$db
. oraenv 2>/dev/null 1>/dev/null

 sqlplus -s / as sysdba <<!
${QUERY}
exit;
!
done