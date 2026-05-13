-- ------------------------------------------------------------------------------
-- File       : ssl_client_verify.sql
-- Purpose    : postgres security helper: ssl client verify.
-- Engine     : postgres
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: ssl_client_verify.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--current
create extension sslinfo;
select ssl_is_used();

--all sessions

select datname,
	usename,
	ssl,
	client_addr
from pg_stat_ssl inner join
	pg_stat_activity on pg_stat_ssl.pid = pg_stat_activity.pid
where ssl is true and usename<>'rdsadmin';
