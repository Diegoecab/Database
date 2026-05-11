-- ------------------------------------------------------------------------------
-- File       : partition_segments_boundaries_dms.sql
-- Purpose    : postgres storage helper: partition segments boundaries dms.
-- Engine     : postgres
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: partition_segments_boundaries_dms.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
select nt,max(code),count(*)
                                from (SELECT code, Ntile(4) over(ORDER BY code) nt FROM articles3)st
                                group by nt
                                order by nt;
