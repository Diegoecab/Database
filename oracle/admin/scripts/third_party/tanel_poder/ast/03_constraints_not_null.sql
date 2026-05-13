-- ------------------------------------------------------------------------------
-- File       : 03_constraints_not_null.sql
-- Purpose    : oracle/admin third_party helper: 03 constraints not null.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: 03_constraints_not_null.sql
-- Parameters : Review script body before running.
-- Risk       : DESTRUCTIVE
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

DROP TABLE cons_demo;

CREATE TABLE cons_demo (owner varchar2(100), object_name varchar2(128));

INSERT /*+ APPEND */ INTO cons_demo SELECT owner, object_name FROM dba_objects;
COMMIT;

SELECT COUNT(*) FROM cons_demo;
@x

CREATE INDEX idx1_cons_demo ON cons_demo(owner);

SELECT COUNT(*) FROM cons_demo;
@x

SELECT /*+ INDEX(cons_demo cons_demo(owner)) */ COUNT(*) FROM cons_demo;

ALTER TABLE cons_demo MODIFY owner NOT NULL NOVALIDATE;

INSERT INTO cons_demo VALUES (null, 'x');

SELECT COUNT(*) FROM cons_demo;
@x

ALTER TABLE cons_demo MODIFY owner NULL;
--ALTER TABLE cons_demo MODIFY owner NOT NULL VALIDATE;
--ALTER TABLE cons_demo MODIFY owner NOT NULL DEFERRABLE INITIALLY DEFERRED VALIDATE;
ALTER TABLE cons_demo MODIFY owner NOT NULL DEFERRABLE VALIDATE;

SELECT COUNT(*) FROM cons_demo;
@x


DROP TABLE cons_demo2;

CREATE TABLE cons_demo2 AS SELECT * FROM scott.emp;

ALTER TABLE cons_demo2 ADD CONSTRAINT c2 CHECK (SAL > 500);

SELECT * FROM cons_demo2 WHERE sal = 100;

@x

