--alert_log_table_create
REM    Creacion de objetos para ver el alert log en una tabla externa
REM ======================================================================
REM alert_log_table_create.sql        Version 1.1    25 Agosto 2011
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
REM     Ejecutar con usuario dba
REM
REM Precauciones:
REM
REM ======================================================================
REM

set verify off
set long 100000
set serveroutput on
define alert_length="2000"

PROMPT
ACCEPT OWNER prompt 'Owner: '
PROMPT
ACCEPT TBS prompt 'Tablespace: '
PROMPT

drop table &OWNER..alert_log;

create table &OWNER..alert_log (
  alert_date date,
  alert_text varchar2(&&alert_length)
)
tablespace &TBS;

create index alert_log_idx on &OWNER..alert_log(alert_date)
tablespace &TBS;

column db    new_value _DB    noprint;
column bdump new_value _bdump noprint;

select instance_name db from v$instance;

select value bdump from v$parameter 
 where name ='background_dump_dest';


drop   directory BDUMP;
create directory BDUMP as '&&_bdump';

drop table &OWNER..alert_log_disk;

create table &OWNER..alert_log_disk ( text varchar2(&&alert_length) )
organization external (
  type oracle_loader
  default directory BDUMP
      access parameters (
          records delimited by newline nologfile nobadfile
          fields terminated by "&" ltrim
      )
  location('alert_&&_DB..log')
)
reject limit unlimited;

CREATE OR REPLACE FUNCTION &OWNER..alert_log_date (text IN VARCHAR2)
   RETURN DATE
IS
   invaliddate   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invaliddate, -1846);
BEGIN
   RETURN TO_DATE (text,
                   'Dy Mon DD HH24:MI:SS YYYY',
                   'NLS_DATE_LANGUAGE=AMERICAN'
                  );
EXCEPTION
   WHEN invaliddate
   THEN
      RETURN NULL;
   WHEN OTHERS
   THEN
      RETURN NULL;
END;
/

create or replace public synonym alert_log_disk for &OWNER..alert_log_disk;
create or replace public synonym alert_log for &OWNER..alert_log;

PROMPT
PROMPT Ejecutar alert_log_table_update para subir los datos a la tabla
PROMPT
