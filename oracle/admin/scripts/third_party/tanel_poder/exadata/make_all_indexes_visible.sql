-- ------------------------------------------------------------------------------
-- File       : make_all_indexes_visible.sql
-- Purpose    : oracle/admin third_party helper: make all indexes visible.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: make_all_indexes_visible.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

DECLARE
    cmd VARCHAR2(1000);
BEGIN
    FOR i IN (SELECT owner,index_name FROM dba_indexes WHERE table_owner = '&1' AND table_owner NOT IN('SYS', 'SYSTEM')) LOOP
        cmd := 'ALTER INDEX '||i.owner||'.'||i.index_name||' VISIBLE';
        DBMS_OUTPUT.PUT_LINE(cmd);
        EXECUTE IMMEDIATE cmd;
    END LOOP;
END;
/

