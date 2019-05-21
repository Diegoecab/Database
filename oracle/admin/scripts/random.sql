connect pepe/pepe
set timing on
alter session set events '10046 trace name context forever, level 8';
begin
  for i in 1..2000000 loop
     execute immediate
        'select nombre2 from test where id = :id'
     using ROUND(dbms_random.value(1,2000000));
  end loop;
end;
/
exit