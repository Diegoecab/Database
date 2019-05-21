REM	Script para obtener todos los privilegios de sistema
REM ======================================================================
REM system_privilege_map.sql		Version 1.1	10 Enero 2011
col name for a100
SELECT   NAME
    FROM SYS.system_privilege_map
   WHERE 1 = 1
ORDER BY 1;