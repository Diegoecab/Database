-- ------------------------------------------------------------------------------
-- File       : indices_cache.sql
-- Purpose    : Oracle administration helper: indices cache.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @indices_cache.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
/*optimizer_index_caching es un parametro con un valor de porcentaje que varía desde 0 a 100*/

/*http://www.dba-oracle.com/oracle_tips_blocksizes-.htm

Los indices en tablespaces con blocksize grandes mejoran el rendimiento*/

/* Deberiamos crear un index buffer separado*/


/* Dar memoria al 32k de cache buffer*/
alter system set db_32k_cache_size = 100m;

/* Crear tablespace con 32 K de blocksize*/

create tablespace index_ts_32k blocksize 32k;


/* Mover los índices al tablespace de 32 K
( Esto no ocaciona interrupcion en las actuales consultas, se reconstruye los indices como segmentos temporales
y se asegura de que el nuevo índice es utilizable antes de eliminar el indice anterior*/

alter index cust_idx rebuild online tablespace index_ts_32k;

/* Consulta para ver los índices en el buffer de indices*/ 

select
   value - blocks optimizer_index_caching
from
   v$parameter p,
   dba_segments s
where
   name = 'db_32k_cache_size'
and
   tablespace_name = 'INDEX_TS_32K';

