--dba_tab_comments_x
set pages 1000
set verify off
set heading on
accept OWNER prompt 'Ingrese Owner: '
accept TABLA prompt 'Ingrese Tabla: '
select owner,table_name,table_type,comments from dba_tab_comments where owner=upper('&OWNER') and table_name=upper('&TABLA');