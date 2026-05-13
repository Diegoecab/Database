-- ------------------------------------------------------------------------------
-- File       : drop_context_queue_tables.sql
-- Purpose    : Oracle administration helper: drop context queue tables (1).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @drop_context_queue_tables (1).sql
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
SQL> alter session set events '25475 trace name context forever, level 2';

Session altered.

SQL> execute DBMS_RULE_ADM.DROP_EVALUATION_CONTEXT ('PORTAL.AQ$_WWSBR_EVENT_Q_TABLE_V',TRUE);

PL/SQL procedure successfully completed.

SQL> commit;

Commit complete.



alter session set events '25475 trace name context forever, level 2';

exec DBMS_RULE_ADM.DROP_RULE_SET('WWSRC_EVENT_Q_N');

exec DBMS_RULE_ADM.DROP_RULE_SET('WWSBR_EVENT_Q_N');
                                    

exec DBMS_RULE_ADM.DROP_RULE_SET('WWSRC_EVENT_Q_R');

exec DBMS_RULE_ADM.DROP_RULE_SET('WWSBR_EVENT_Q_R');

exec DBMS_RULE_ADM.DROP_RULE_SET('AQ$_WWSRC_EVENT_Q_TABLE_V');

exec DBMS_RULE_ADM.DROP_RULE('AQ$_WWSRC_EVENT_Q_TABLE_V');



commit;



'execute dbms_aqadm.DROP_QUEUE_TABLE(queue_table=>'''||object_name||''',force=>TRUE)'

select 'execute dbms_aqadm.DROP_QUEUE_TABLE(queue_table=>'''||table_name||''',force=>TRUE);' from user_Tables where table_name like 'AQ%'

select 'DROP TABLE PORTAL.'||table_name||' CASCADE CONSTRAINTS ;' from user_Tables where table_name like 'AQ%'

select 'DROP TABLE PORTAL.'||table_name||' CASCADE CONSTRAINTS ;' from user_Tables;


alter session set events '25475 trace name context forever, level 2';
ALTER SESSION SET EVENTS '10851 trace name context forever, level 2';