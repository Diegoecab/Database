prompt Query de Vista
set verify off
set long 10000
accept OWNER prompt 'Ingrese Owner de vista: '
accept VISTA prompt 'Ingrese Nombre de vista: '
select TEXT from dba_views where owner=upper('&OWNER') and view_name=upper('&VISTA');