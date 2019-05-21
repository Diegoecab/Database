connect pepe/pepe
set timing on
alter session set events '10046 trace name context forever, level 8';
declare v_id test2.id%type;
begin
for i in 1..25 loop
select max(id) into v_id from test;
end loop;
end;
/
exit