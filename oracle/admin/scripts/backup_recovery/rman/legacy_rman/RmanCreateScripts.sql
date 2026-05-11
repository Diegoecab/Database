-- ------------------------------------------------------------------------------
-- File       : RmanCreateScripts.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: RmanCreateScripts.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @RmanCreateScripts.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
RMAN

Creacion de Script:


create script Back_Full comment "Backup Full" {backup database;}


Reemplazar Script:


replace script Back_Full comment "Backup Full" {backup database;}




Listar Scripts:


list all script names;


Ejecutar scripts:

RUN { EXECUTE SCRIPT
full_backup
; }


Ver script:


Print script "Back_Full";


Eliminar script:

DELETE SCRIPT 'full_backup';


Ejecutar script al momento de ejecutar RMAN


rman TARGET SYS/oracle@trgt CATALOG rman/cat@catdb SCRIPT 'full_backup';