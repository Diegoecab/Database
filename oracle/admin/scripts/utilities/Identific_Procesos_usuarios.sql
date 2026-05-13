-- ------------------------------------------------------------------------------
-- File       : Identific_Procesos_usuarios.sql
-- Purpose    : Oracle administration helper: Identific Procesos usuarios.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @Identific_Procesos_usuarios.sql
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
/*Select para determinar el usuario que consume mas recursos. Hay que filtrar la busqueda por el numero de A.SPID*/
SELECT a.spid PROCESO_EN_SERVER, b.username USUARIO, b.SID, b.status ESTADO, b.machine, b.terminal, b.osuser
  FROM v$session b RIGHT JOIN v$process a ON a.addr = b.paddr


/*Procesos sin identificador de usuarios */
SELECT spid FROM v$process WHERE NOT EXISTS ( SELECT 1 FROM v$session WHERE paddr = addr); 
