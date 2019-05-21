CREATE OR REPLACE TRIGGER "DBADMIN"."ERROR_TNLRSV"
after servererror on database
declare
C_EMAIL_FROM   CONSTANT VARCHAR2(100):='mariano.raul.quidiello@citi.com';
C_EMAIL_TO   CONSTANT VARCHAR2(100):='mariano.raul.quidiello@citi.com';
v_osuser VARCHAR2(30);
v_machine VARCHAR2(64);
v_process VARCHAR2(9);
v_program VARCHAR2(64);
v_database varchar2(50);
v_hostname varchar2(50);
v_date VARCHAR2(50);
v_sqlid varchar2(13);
v_prev_sqlid varchar2(13);
begin
        select osuser, machine, process, program, SYS_CONTEXT ('USERENV', 'DB_NAME' ) db, SYS_CONTEXT ('USERENV', 'SERVER_HOST' ) host,  to_char(sysdate,'YYYY-MON-DD HH24:MI:SS'), sql_id, prev_sql_id
        into v_osuser, v_machine, v_process, v_program , v_database, v_hostname, v_date, v_sqlid , v_prev_sqlid
        from v$session
        where audsid=userenv('SESSIONID')
        and sid=(select distinct sid from v$mystat);

      IF (IS_SERVERERROR (1017)) THEN
       DB_MONITORING.SEND_EMAIL(C_EMAIL_FROM,C_EMAIL_TO,'Error Trigger - '||v_hostname||' - '||v_database,v_date||' - '||DBMS_UTILITY.FORMAT_ERROR_STACK||' osuser: '||v_osuser||' machine: '||v_machine||' program: '||v_program);
      END IF;

end ERROR_TNLRSV;
/

ALTER TRIGGER "DBADMIN"."ERROR_TNLRSV" enable;
