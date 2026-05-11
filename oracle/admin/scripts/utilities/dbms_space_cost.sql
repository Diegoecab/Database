-- ------------------------------------------------------------------------------
-- File       : dbms_space_cost.sql
-- Purpose    : Oracle administration helper: dbms space cost (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_space_cost (1).sql
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
--CREATE_TABLE_COST

SET SERVEROUTPUT ON

DECLARE
v_used_bytes NUMBER(10);
v_Allocated_Bytes NUMBER(10);
v_type sys.create_table_cost_columns;
BEGIN
v_Type := sys.create_table_cost_columns
(
sys.create_table_cost_colinfo('NUMBER',9),
sys.create_table_cost_colinfo('VARCHAR2',50),
sys.create_table_cost_colinfo('VARCHAR2',15),
sys.create_table_cost_colinfo('DATE',NULL),
sys.create_table_cost_colinfo('DATE',NULL)
);

DBMS_SPACE.CREATE_TABLE_COST('USERS',v_Type,100000000,7,v_used_Bytes,v_Allocated_Bytes);

DBMS_OUTPUT.PUT_LINE('Used Bytes: ' || TO_CHAR(v_used_Bytes));
DBMS_OUTPUT.PUT_LINE('Allocated Bytes: ' || TO_CHAR(v_Allocated_Bytes));

END;
/



--CREATE_INDEX_COST

SET SERVEROUTPUT ON

DECLARE
v_used_bytes NUMBER(10);
v_Allocated_Bytes NUMBER(10);
BEGIN

DBMS_SPACE.CREATE_INDEX_COST
(
'CREATE INDEX SAMPLE_IND_1 ON SAMPLE(User_ID) ',
v_used_Bytes,
v_Allocated_Bytes
);

DBMS_OUTPUT.PUT_LINE('Used Bytes: ' || TO_CHAR(v_used_Bytes));
DBMS_OUTPUT.PUT_LINE('Allocated Bytes: ' || TO_CHAR(v_Allocated_Bytes));

END;
/