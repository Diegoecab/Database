-- ------------------------------------------------------------------------------
-- File       : sharedserver.sql
-- Purpose    : Oracle administration helper: sharedserver.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sharedserver.sql
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
prompt Dispatcher % busy Rate
prompt Si es mayor a 50% agregar un nuevo dispatcher.
-- alter system set dispatchers='(PROTOCOL=TCP)(DIS=3)' scope=memory;
select name ,busy, idle, round((busy/(busy+idle))*100,0) "% of time busy"   from v$dispatcher;

prompt Average Wait Time
select decode(sum(totalq),0,'No Responses', round(sum(wait)/sum(totalq)),0) 
from v$queue q, v$dispatcher d
where q.type= 'DISPATCHER'
and q.paddr=d.paddr;


prompt
prompt if all servers are > 50% BUSY and MTS_MAX_SERVERS has been reached then
prompt you may need more shared server processes
prompt - remember that these values are since instance startup
prompt

show parameter mts_max_servers;

select name, status, requests,messages,bytes, breaks, round((busy /(busy + idle)) * 100,0) "% of time busy" 
from v$shared_server;

prompt
prompt
prompt if average wait time per request is steadily increasing and MTS_MAX_SERVERS has
prompt been reached then you may need more shared server processes
prompt

select decode(totalq, 0, 'No Requests', round(wait/totalq,0) || ' hundreths of seconds') as "AVERAGE WAIT TIME PER REQUEST"
from v$queue
where type = 'COMMON';