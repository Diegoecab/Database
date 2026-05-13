-- ------------------------------------------------------------------------------
-- File       : flashback.sql
-- Purpose    : Oracle administration helper: flashback.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @flashback.sql
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
You can enable Flashback Database using the following steps:

   1.

      Make sure the database is in archive mode.
       
   2.

      Configure the recovery area by setting the two parameters: 

    *

      db_recovery_file_dest
       
    *

      db_recovery_file_dest_size 

   3.

      Open the database in MOUNT EXCLUSIVE mode and turn on the flashback feature: 

    SQL> STARTUP MOUNT EXCLUSIVE;
    SQL> ALTER DATABASE FLASHBACK ON;

   4.

      Set the Flashback Database retention target: 

     db_flashback_retention_target

   5.

      Determine if Flashback Database is enabled: 

    SQL> select flashback_on
          2  from   v$database;

           FLASHBACK_ON
           ------------
           YES