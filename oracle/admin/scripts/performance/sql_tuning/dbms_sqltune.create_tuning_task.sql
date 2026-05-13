--dbms_sqltune.create_tuning_task.sql 0t7jhnhsu10hh
/*
--
dbms_sqltune.create_tuning_task.sql

USAGE:
@dbms_sqltune.create_tuning_task.sql <sqlid> 

E.g.

@dbms_sqltune.create_tuning_task.sql 0t7jhnhsu10hh

Author: Diego Cabrera

*/

set verify off
set long 100000
set serveroutput on

accept TSQLID prompt 'Ingrese SQL ID de la consulta: '

ttitle left 'SQL : '

select sql_fulltext from v$sql where sql_id='&TSQLID';
select sql_text from dba_hist_sqltext where sql_id='&TSQLID';

ttitle off

accept TTIME prompt 'Ingrese tiempo maximo de ejecucion (en segundos): '
accept USERNAME prompt 'Ingrese nombre de usuario con el cual se ejecuta la consulta: '
accept TTASKNAME prompt 'Ingrese nombre de la tarea: '
accept TTASKDESC prompt 'Ingrese descripcion de la tarea: '

prompt 
set serveroutput on
DECLARE
 my_task_name VARCHAR2(30);
 my_sqltext   CLOB;
BEGIN

for r in (select sql_fulltext from v$sql where sql_id='&TSQLID') loop
my_sqltext := r.sql_fulltext;
end loop;

for r in (select sql_text from dba_hist_sqltext where sql_id='&TSQLID') loop
my_sqltext := r.sql_text;
end loop;

if my_sqltext is not null then
 my_task_name := DBMS_SQLTUNE.CREATE_TUNING_TASK(
         sql_text    => my_sqltext,
         user_name   => '&USERNAME',
         scope       => 'COMPREHENSIVE',
         time_limit  => &TTIME,
         task_name   => '&TTASKNAME',
         description => '&TTASKDESC');
		 --bind_list => sql_binds(anydata.ConvertNumber(100)),
else
dbms_output.put_line ('No se encuentra el texto SQL con SQLID &TSQLID');
end if;

END;
/


accept EJECJOB prompt 'Desea ejecutar la tarea &TTASKNAME? Y/N [Y]: '

DECLARE
var varchar2 (1);
my_sqltext CLOB;
begin
var := '&EJECJOB';
for r in (select sql_fulltext from v$sql where sql_id='&TSQLID') loop
my_sqltext := r.sql_fulltext;
end loop;

for r in (select sql_text from dba_hist_sqltext where sql_id='&TSQLID') loop
my_sqltext := r.sql_text;
end loop;

if my_sqltext is not null and  (var is null or var='Y' or var='y') then
dbms_output.put_line ('Ejecutando tarea &TTASKNAME');
DBMS_SQLTUNE.execute_tuning_task(task_name => '&TTASKNAME');
end if;
end;
/

SET LONG 1000000
SET LONGCHUNKSIZE 1000
SET LINESIZE 100
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK( '&TTASKNAME')
  FROM DUAL;

accept DROPJOB prompt 'Desea eliminar la tarea &TTASKNAME junto a todos sus resultados? Y/N [Y]: '

DECLARE
var varchar2 (1);
my_sqltext CLOB;
begin
var := '&DROPJOB';
for r in (select sql_fulltext from v$sql where sql_id='&TSQLID') loop
my_sqltext := r.sql_fulltext;
end loop;

for r in (select sql_text from dba_hist_sqltext where sql_id='&TSQLID') loop
my_sqltext := r.sql_text;
end loop;

if my_sqltext is not null and  (var is null or var='Y' or var='y') then
dbms_output.put_line ('Eliminando tarea &TTASKNAME');
DBMS_SQLTUNE.DROP_TUNING_TASK('&TTASKNAME');
end if;
end;
/

  
/*

Ejemplo creacion tarea con variables bind

DECLARE
 my_task_name VARCHAR2(30);
 my_sqltext   CLOB;
BEGIN

 my_sqltext := 'SELECT * '                      ||
               'FROM employees e, locations l, departments d ' ||
               'WHERE e.department_id = d.department_id AND '  ||
                     'l.location_id = d.location_id AND '      ||
                     'e.employee_id < :bnd';

 my_task_name := DBMS_SQLTUNE.CREATE_TUNING_TASK(
         sql_text    => my_sqltext,
         bind_list   => sql_binds(anydata.ConvertNumber(100)),
         user_name   => 'HR',
         scope       => 'COMPREHENSIVE',
         time_limit  => &TTIME,
         task_name   => 'my_sql_tuning_task',
         description => 'Task to tune a query on a specified employee');
END;
/
*/