PROMPT Ejecutar con SYS as sysdba
select 
kghlushrpool, 
kghlurcr, 
kghlutrn, 
kghlufsh, 
kghluops, 
kghlunfu, 
kghlunfs 
from 
sys.x$kghlu 
where 
inst_id = userenv('Instance') 
/
