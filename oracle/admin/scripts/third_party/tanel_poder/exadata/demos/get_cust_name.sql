-- ------------------------------------------------------------------------------
-- File       : get_cust_name.sql
-- Purpose    : oracle/admin third_party helper: get cust name.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: get_cust_name.sql
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

CREATE OR REPLACE FUNCTION get_cust_name (id IN NUMBER) RETURN VARCHAR2 
    AUTHID CURRENT_USER
AS
    n VARCHAR2(1000); 
BEGIN 
    SELECT /*+ FULL(c) */ cust_first_name||' '||cust_last_name INTO n 
    FROM soe.customers c
    WHERE customer_id = id; 
    RETURN n; 
END;
/

