Elimina la tabla indicada de la papelera. El nombre de 
PURGE TABLE nombre_tabla; 
la tabla puede ser el nombre original o el renombrado. 
Elimina el índice indicado de la papelera. El nombre 
PURGE INDEX nombre_índice; 
del índice es el nombre original y no el renombrado. 
Elimina todos los objetos (del usuario que lanza la 
PURGE RECYCLEBIN;
orden) de la papelera. 
PURGE DBA_RECYCLEBIN; Elimina todos los objetos (de todos los usuarios) de la papelera. Solo un SYSDBA puede lanzar este comando. 
PURGE TABLESPACE  Elimina todos los objetos (del usuario) de la papelera nombre_tablespace;  que residan en el tablespace indicado. 
PURGE TABLESPACE  Elimina todos los objetos de la papelera que residan ennombre_tablespace USERS  el tablespace indicado y pertenezcan el usuario 
nombre_usuario;  indicado. 