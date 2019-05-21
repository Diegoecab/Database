set feedback off
begin
  for i in 1..100000 loop
execute immediate
        'insert into prueba_stb3 (numero) values (:id)'
     using ROUND(dbms_random.value(1,100000));
commit;
  end loop;
for i in 1..100000 loop
execute immediate
        'delete from prueba_stb3 where numero= :id'
     using ROUND(dbms_random.value(1,100000));
commit;
  end loop;
end;
/
