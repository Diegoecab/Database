-- ------------------------------------------------------------------------------
-- File       : archivelog_cascade.sql
-- Purpose    : Oracle Data Guard administration helper: archivelog cascade(1).
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @archivelog_cascade(1).sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
En ibsve:
alter system set fal_server=ibsdrvz,DTVPRDCS sid='*' scope=both;
alter system set log_archive_config='DG_CONFIG=(DTVPRDCS,ibsdrvz,ibsve,D1,veoggp)' sid='*' scope=both;


En ibsdrvz (sid DTVPRDCS):
alter system set log_archive_dest_10='SERVICE=ibsve LGWR ASYNC COMPRESSION=ENABLE VALID_FOR=(STANDBY_LOGFILES,STANDBY_ROLE) DB_UNIQUE_NAME=ibsve';
alter system set log_archive_dest_state_10='ENABLE';

