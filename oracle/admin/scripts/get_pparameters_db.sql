REM ======================================================================
REM enable_block_change_tracking.sql		Version 1.1	19 Enero 2010
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
col value for a30
col display_value for a30
col name for a80
set lines 400

select name,value,case name
when 'sga_target' then value/1024/1024
when 'shared_pool_size' then value/1024/1024
when 'sga_max_size' then value/1024/1024
when 'db_keep_cache_size' then value/1024/1024
when 'db_cache_size' then value/1024/1024
when 'db_32k_cache_size' then value/1024/1024
when 'pga_aggregate_target' then value/1024/1024
end "MB" from V$PARAMETER
where name in ('sga_target','sga_max_size','shared_pool_size','pga_aggregate_target') 
  or name like '%cache%' 
  or name like '%urso%' 
  or name like '%ptimi%' 
and value <> '0' order by name;