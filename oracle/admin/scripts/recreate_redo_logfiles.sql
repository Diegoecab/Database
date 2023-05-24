set lines 600
set pages 100
set serveroutput on

begin
for r in (select * from  v$log) loop
dbms_output.put_line ('ALTER DATABASE DROP LOGFILE GROUP '||r.group#||';');
dbms_output.put_line ('ALTER DATABASE ADD LOGFILE GROUP '||r.group#||' size '||ROUND (r.BYTES / 1024 / 1024)||'M ;');
end loop;
end;
/