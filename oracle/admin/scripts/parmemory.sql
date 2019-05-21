set pagesize 100
col tipo format a 10
 col name format a25
col value format a10

 select 'Data Buffers' tipo, name, value, '9i' since 
 from v$parameter 
 where name in ('db_keep_cache_size', 'db_recycle_cache_size','db_cache_size',  'db_2k_cache_size','db_2k_cache_size','db_4k_cache_size','db_8k_cache_size', 'db_16k_cache_size','db_32k_cache_size') 
 union all
 select 'Data Buffers' tipo, name, value, '9i deprecated' 
 from v$parameter 
 where name in ('db_block_buffer') -- buffer keep y recycle keep
union all
 select 'Data Buffers' tipo, name, value, '10g' 
 from v$parameter 
 where name in ('__db_cache_size','__java_pool_size','__shared_pool_size', '__large_pool_size') -- buffer keep y recycle keep
union all
 select 'Variable Size', name, value , '8i'
 from v$parameter 
 where name in ( 'large_pool_size','java_pool_size','shared_pool_size',
 'sort_area_size','hash_area_size') 
 union all
 select 'Redo Buffers', name, value , '8i'
 from v$parameter 
 where name = 'log_buffer'
 union all
 select 'Otros', name, value, '9i' 
 from v$parameter 
 where name in ('workarea_size_policy') 
union all
 select 'Otros', name, value,  '9i dedicated - 10g all'
 from v$parameter 
 where name in ('pga_aggregate_target') 
union all
 select 'Otros', name, value,  '10g'
 from v$parameter 
 where name in ('sga_target') 
 order by 1,2;
