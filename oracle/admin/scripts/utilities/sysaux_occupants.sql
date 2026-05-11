-- ------------------------------------------------------------------------------
-- File       : sysaux_occupants.sql
-- Purpose    : Oracle administration helper: sysaux occupants.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sysaux_occupants.sql
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
--v$sysaux_occupants
 set linesize 120
set pagesize 100

PROMPT
PROMPT Detalle de espacio utilizado en SYSAUX
PROMPT 

COLUMN "Item" FORMAT A25
COLUMN "Space Used (GB)" FORMAT 999.99
COLUMN "Schema" FORMAT A25
COLUMN "Move Procedure" FORMAT A40

SELECT	occupant_name "Item",
	space_usage_kbytes/1048576 "Space Used (GB)",
	schema_name "Schema",
	move_procedure "Move Procedure"
FROM v$sysaux_occupants
ORDER BY 1
/

PROMPT
PROMPT Dias de retención
PROMPT

select dbms_stats.get_stats_history_retention from dual;

PROMPT Ejemplo de modificacion de dias de retencion:
PROMPT exec dbms_stats.alter_stats_history_retention(10);
PROMPT
PROMPT Ejemplo de depuracion de estadisticas mayores a 10 dias:
PROMPT exec DBMS_STATS.PURGE_STATS(SYSDATE-10);
PROMPT
PROMPT Consulta de estadisticas disponibles:
PROMPT select dbms_stats.get_stats_history_availability from dual;
PROMPT
PROMPT Ejemplo depuracion awr snaps
PROMPT exec dbms_workload_repository.drop_snapshot_range(low_snap_id => 30876, high_snap_id=>40872);
PROMPT
PROMPT Modificacione retencion snapshots en minutos
PROMPT execute dbms_workload_repository.modify_snapshot_settings(retention => 4320);
PROMPT
PROMPT see the snapshots interval and retention period time
PROMPT select * from dba_hist_wr_control;
PROMPT