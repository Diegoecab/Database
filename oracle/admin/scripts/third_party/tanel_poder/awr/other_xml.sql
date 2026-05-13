-- ------------------------------------------------------------------------------
-- File       : other_xml.sql
-- Purpose    : oracle/admin third_party helper: other xml.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: other_xml.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

select
--      sql_id
--    , child_number
--    , plan_hash_value
     substr(extractvalue(value(d), '/hint'), 1, 100) as outline_hints
from
      xmltable('/*/outline_data/hint'
        passing (
           select
            xmltype(other_xml) as xmlval
           from
            dba_hist_sql_plan
           where
            sql_id = '&1'
           and  other_xml is not null
        )
) d
/
