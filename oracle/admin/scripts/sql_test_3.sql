set feedback off
begin
  for i in 1..100000 loop
execute immediate
        'insert into prueba_stb4 (numero) values (:id)'
     using ROUND(dbms_random.value(1,100000));
commit;
  end loop;
for i in 1..100000 loop
execute immediate
        'update prueba_stb4 set numero=123 where numero=:id'
     using ROUND(dbms_random.value(1,100000));
commit;
  end loop;
end;
/
