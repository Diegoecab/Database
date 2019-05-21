alter system set use_stored_outlines = TEST_OUTLINES_MIGRACIONES;
alter system flush shared_pool;
set timing on
alter session set events '10046 trace name context forever, level 8';
begin
  for i in 1..2000000 loop
     execute immediate
        'select id1 from migraciones_registros where id1 = :id'
     using ROUND(dbms_random.value(1,2000000));
  end loop;
end;
/