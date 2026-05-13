-- ------------------------------------------------------------------------------
-- File       : dbms_advisor_create_task.sql
-- Purpose    : Oracle administration helper: dbms advisor create task.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_advisor_create_task.sql
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
--var := '&EJECJOB';
--dbms_advisor_create_task.sql

accept taskname prompt 'Task Name:	'
accept taskdesc prompt 'Task Description:	'
accept numDaysToRetain prompt 'numDaysToRetain:	'
accept timelimit prompt 'Time limit (mins): '
accept advtype prompt 'AdvType [TABLESPACE,TABLE,INDEX,SCHEMA]: '
accept tbsname prompt 'TbsName: '
accept scheman prompt 'SchemaName: '
accept tablen prompt 'Tables [TABLE1,TABLE2...]: '
accept indexn prompt 'Indexes [INDEX1,INDEX2...]: '

  
DECLARE 
taskname varchar2(100);
taskdesc varchar2(128);
task_id number;
object_id number;
timeLimit varchar2(25);
numDaysToRetain varchar2(25);
objectName varchar2(100);
objectType varchar2(100);
advtype varchar2(100);
tbsname varchar2(100);

BEGIN
taskname := '&taskname';
taskdesc :='&taskdesc';
timeLimit := '&timelimit';
numDaysToRetain :='&numDaysToRetain';
advtype :='&advtype';
tbsname :='&tbsname';


dbms_advisor.create_task('Segment Advisor','&taskname','&taskdesc',NULL);
dbms_advisor.create_object('&taskname', '&advtype', '&tbsname', ' ', ' ', NULL, object_id);
dbms_advisor.set_task_parameter('&taskname', 'RECOMMEND_ALL', 'TRUE');
dbms_advisor.set_task_parameter('&taskname', 'TIME_LIMIT', timeLimit);
dbms_advisor.set_task_parameter('&taskname', 'DAYS_TO_EXPIRE', numDaysToRetain);
END;
/ 
 
 --Execute task script   Return to Top 
 
DECLARE 
taskname varchar2(100);
BEGIN
taskname := '&taskname';
dbms_advisor.reset_task('&taskname');
dbms_advisor.execute_task('&taskname');
END;
/ 

PROMPT
PROMPT View results: dbms_space_recommendations
PROMPT