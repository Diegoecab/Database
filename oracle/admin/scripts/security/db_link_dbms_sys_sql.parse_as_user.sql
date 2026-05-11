-- ------------------------------------------------------------------------------
-- File       : db_link_dbms_sys_sql.parse_as_user.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: db link dbms sys sql parse as user.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @db_link_dbms_sys_sql.parse_as_user.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
declare
uid number;

pass varchar(50) := '05BE3869C7C6812D21BAE482717B98242B';
host varchar(50) := 'CDWDEV';
sqltext varchar2(1000) :='CREATE DATABASE LINK "CORDW.DCS.CITICORP.COM" CONNECT TO "EXT$CO_AML" IDENTIFIED BY VALUES '''||pass||''' USING '''||host||'''';

myint integer;
begin
select user_id into uid from all_users where username like 'EXT$COMN_AML';
myint:=sys.dbms_sys_sql.open_cursor();
sys.dbms_output.put_line(sqltext);
sys.dbms_sys_sql.parse_as_user(myint,sqltext,dbms_sql.native,UID);
sys.dbms_sys_sql.close_cursor(myint);
end ;
/
