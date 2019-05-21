/*
Ejemplo: pepito

1)  primeras 2 letras, la primera Mayuscula 
=> Pe
2)  Caracter #
=>#
3)  cantidad de letras * PI (3.141592) = 6* (3.141592) = 18849552 (sin separador decimal)
            Sumatoria desde la derecha a la izquiera, salteando 1 numero -> 2+5+4+8=19 (se toma siempre los ultimos 2 digitos, para el caso de que diera 3 o mas)
            Sumatoria desde la derecha a la izquiera, salteando 1 numero -> 5+9+8+1=23 (se toma siempre los ultimos 2 digitos, para el caso de que diera 3 o mas)
=>2319
4)  ultimos dos caracteres ascii (siempre minuscula) a Decimal (www.asciitable.com) => to => 116 + 111 

=> 227

Resultado ==> Pe#2319227
*/
set verify off
set serveroutput on
declare 
v_in number;
v_in_impar number := 0;
v_in_par number := 0;
user varchar2(100) := '&1';
return varchar2(100);
return2 varchar2(100);
last_chars varchar2(100);
part1 varchar2 (2);
begin
dbms_output.put_line('##########################################');
if user = '' or length(user) < 2 then
dbms_output.put_line('ERROR => Number of characters less than 2');
goto fin;
end if;

select initcap(substr(user,1,2)) into part1 from dual;
select ((length(user))*3.141592) into return from dual;
select replace(to_char(return),'.',null) into return2 from dual;
select length(replace(to_char(return),'.',null)) into v_in from dual;
select substr (user,((length(user)) - 1),2) into last_chars from dual;

for r in reverse 1 .. v_in loop
 if MOD(r,2) = 0 then
    select v_in_par + (substr(return2,r,1)) into v_in_par from dual;
 else
    select v_in_impar + (substr(return2,r,1)) into v_in_impar from dual;
 end if;
end loop;

v_in_par := substr(v_in_par, (length(v_in_par))-1, 2);
v_in_impar := substr(v_in_impar, (length(v_in_par)-1), 2);

select 
    ascii(substr (lower(user),((length(user)) - 1),1))
    + 
    ascii(substr (lower(user),((length(user))),1)) into last_chars from dual;
    
dbms_output.put_line(part1||'#'||v_in_impar||v_in_par||last_chars);
<<fin>>
dbms_output.put_line('##########################################');
end;
/