

declare
nval number;
nval2 number:=1;

begin

for r in 1..50000000 loop
select power(
	(mod( (DBMS_RANDOM.VALUE(0,100000000000)/(DBMS_RANDOM.VALUE(1,100000000000))), DBMS_RANDOM.VALUE(0,100000000000)/(DBMS_RANDOM.VALUE(1,100000000000)) ))
,-1
 )+nval2 into nval from dual;

select ((nval-nval2)) into nval2 from dual;

end loop;
end;
/
