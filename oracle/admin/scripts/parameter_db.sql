REM ======================================================================
REM v$parameter_db.sql		Version 1.1	19 Enero 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM Tomar los parametros mas relevantes en la base de datos
REM Dependencias:
REM	v$parameter
REM
REM Notas:
REM 	Ejecutar usuario dba
REM	Para todas las versiones <= 7
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set pagesize 1000
col value for a25
col name for a35
select name,
case name
when 'sga_target' then to_char(value/1024/1024)||'MB'
when 'shared_pool_size' then to_char(value/1024/1024)||'MB'
when 'sga_max_size' then to_char(value/1024/1024)||'MB'
when 'db_keep_cache_size' then to_char(value/1024/1024)||'MB'
when 'db_cache_size' then to_char(value/1024/1024)||'MB'
when 'db_32k_cache_size' then to_char(value/1024/1024)||'MB'
when 'pga_aggregate_target' then to_char(value/1024/1024)||'MB'
else to_char(value)
end "value", isdefault from V$PARAMETER
where name in ('sga_target','sga_max_size','shared_pool_size','pga_aggregate_target') 
  or name like '%cache%' 
  or name like '%urso%' 
  or name like '%ptimi%' 
and value <> '0' order by name;