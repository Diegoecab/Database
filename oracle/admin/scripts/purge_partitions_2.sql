--purge_partitions_2.sql

declare
  l_aux varchar2(400);
  l_owner varchar2(400) := 'MYA02';
  l_table varchar2(400) := 'MYA_SEGUIMIENTOS_AUX';
begin 

FOR(to_date('''||'27/01/2020'||''',''dd-mm-yyyy''))' ;

  for rec in (select to_char(trunc(fecha_log),'dd-mm-rrrr') fecha_log
                from mya02.mya_seguimientos_aux
               where fecha_log < sysdate - 150)
  loop
    
    execute immediate 'ALTER TABLE "'||l_owner||'"."'||l_table||'" DROP PARTITION FOR(to_date('''||rec.fecha_log||''',''dd-mm-yyyy''))' ;
    l_aux :='ALTER TABLE "'||l_owner||'"."'||l_table||'" DROP PARTITION FOR(to_date('''||rec.fecha_log||''',''dd-mm-yyyy''))';
    dbms_output.put_line(l_aux);


  end loop;               

end;



/*
declare
PART_DOESNT_EXIST EXCEPTION;
PRAGMA EXCEPTION_INIT(PART_DOESNT_EXIST, -2149);
begin
:::::
EXCEPTION
            WHEN PART_DOESNT_EXIST THEN
DBMS_OUTPUT.PUT_LINE ('No existe particion blah blah');
end;
/
*/