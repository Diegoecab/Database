set serveroutput on
begin
for h in (select job from dba_jobs)
loop
dbms_output.put_line ('Eliminando Job '||h.job);
dbms_job.remove(h.job);
commit;
end loop;
end;
/