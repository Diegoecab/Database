REM ======================================================================
REM recomp_synonyms.sql		Version 1.1	16 Enero 2009
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	Compila todos los sinonimos que estan invalidos o descompilados
REM
REM Dependencias:
REM	sys.obj$, sys.dependency$, sys.obj$, user$
REM
REM Notas:
REM 	Ejecutar con sys
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM 
REM ======================================================================
REM
declare 
cursor cur_syn is select do.name d_name, u.name owner 
from sys.obj$ do, sys.dependency$ d, sys.obj$ po, user$ u 
where P_OBJ#=po.obj#(+) 
and D_OBJ#=do.obj# 
and do.status=1 /*dependent is valid*/ 
and po.status=1 /*parent is valid*/ 
   and po.stime!=p_timestamp /*parent timestamp not match*/ 
and do.owner#=u.user# 
and do.type# = 5 
order by 2,1; 
v_syn_name obj$.name%TYPE; 
v_tab_own user$.name%TYPE; 
begin 
OPEN cur_syn; 
loop 
FETCH cur_syn INTO v_syn_name,v_tab_own; 
exit when cur_syn%notfound; 
if v_tab_own = 'PUBLIC'  then 
execute immediate 'alter public synonym "'||v_syn_name|| '" compile'; 
else 
execute immediate 'alter synonym '||v_tab_own||'.'||v_syn_name|| ' compile'; 
end if; 
end loop; 
CLOSE cur_syn; 
end; 
/
REM