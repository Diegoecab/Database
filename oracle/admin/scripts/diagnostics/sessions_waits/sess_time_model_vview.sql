-- ------------------------------------------------------------------------------
-- File       : sess_time_model_vview.sql
-- Purpose    : Oracle diagnostic query/report helper: v$sess time model (1).
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @v$sess_time_model (1).sql
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
--estad_v$sess_time_model.sql
col wait_class heading "Clase|Espera" for a8
col program heading "Programa" for a40
col osuser heading "Usuario|SO" for a13
col min heading "Tiempo|en|Minutos" for 99
col command_type heading "Tipo|de|Comando"
col username heading "Usuario"
col total_waits heading "Total|Waits"
set linesize 180
set feedback off
select  a.sid,
        b.username,
        a.wait_class,
        a.total_waits,
        round((a.time_waited / 100)/60,2) min
from    sys.v_$session_wait_class a,
        sys.v_$session b
where   b.sid = a.sid and
        b.username is not null and
        a.wait_class != 'Idle'
order by 5;