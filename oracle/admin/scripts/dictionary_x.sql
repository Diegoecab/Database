col event for a80
col wait_class for a30
set linesize 180
set verify off
accept TABLA prompt 'Ingrese %table_name%:  '
select table_name from dictionary where UPPER(table_name) like upper('%&TABLA%');