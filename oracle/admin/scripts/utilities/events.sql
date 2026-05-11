-- ------------------------------------------------------------------------------
-- File       : events.sql
-- Purpose    : Oracle administration helper: events (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @events (1).sql
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
SET SERVEROUTPUT ON
DECLARE
l_level NUMBER;
BEGIN
        FOR l_event IN 10000..10999
        LOOP
            dbms_system.read_ev (l_event,l_level);
            IF l_level > 0 THEN
                dbms_output.put_line ('Event '||TO_CHAR (l_event)||
                ' is set at level '||TO_CHAR (l_level));
            END IF;
        END LOOP;
END;
/