-- ------------------------------------------------------------------------------
-- File       : sample_drift.sql
-- Purpose    : oracle/admin third_party helper: sample drift.
-- Engine     : oracle/admin
-- Category   : third_party
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: sample_drift.sql
-- Parameters : MI
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

-- check if there's sample time drift in ASH (should be every 1 seconds)
-- it makes sense to run this only on active systems where every sample there
-- are some active sessions seen

select 
    to_char(sample_time,'YYYYMMDD HH24:MI')
  , sample_time-lag(sample_time) over(order by sample_time) delta
from (select distinct sample_time from v$active_session_history)
/


