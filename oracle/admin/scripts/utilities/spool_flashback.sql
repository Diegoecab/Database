-- ------------------------------------------------------------------------------
-- File       : spool_flashback.sql
-- Purpose    : Oracle administration helper: spool flashback.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @spool_flashback.sql
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
Table created.
Commit complete.
1 row created.
1 row created.
1 row created.
Commit complete.
Table created.

     DEPARTMENT_ID DEPARTMENT_NAME                                                                                     
------------------ ----------------------------------------------------------------------------------------------------
        MANAGER_ID        LOCATION_ID
------------------ ------------------
                 1 TECNOLOGIA                                                                                          
                 1                  1
                                                                                                                                    
                 2 SOPORTE                                                                                             
                 2                  2
                                                                                                                                    
                 3 RRHH                                                                                                
                 3                  3
                                                                                                                                    


3 rows selected.

TIMESTAMP                          SCN
------------------- ------------------
12/10/2007 13:46:18            1904216


1 row selected.

TIMESTAMP                         SCN
------------------ ------------------
12/10/200713:46:18            1904216


1 row selected.
PL/SQL procedure successfully completed.

CURR_DATE                      CURR_SCN
-------------------- ------------------
10-DEC-2007:13:50:29            1904346


1 row selected.
3 rows deleted.
Commit complete.
PL/SQL procedure successfully completed.


no rows selected.
PL/SQL procedure successfully completed.


no rows selected.
0 rows deleted.
Commit complete.
PL/SQL procedure successfully completed.


no rows selected.

          COUNT(*)
------------------
                 0


1 row selected.
old: insert into dept
select *
from dept
as of scn &&fb_scn
new: insert into dept
select *
from dept
as of scn 1904346
ORA-01466: unable to read data - table definition has changed
Commit complete.
