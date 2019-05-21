REM	Script para ver todas las dependencias de todos los objetos de un esquema en particular
REM ======================================================================
REM user_deps_obj_x.sql		Version 1.1	21 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM Detectar dependencias
REM Dependencias:
REM	
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM

SELECT a.object_type, a.object_name, b.owner dep_owner, b.object_type dep_obj_type, b.object_name dep_obj_name,
       b.object_id dep_obj_id, b.status dep_obj_status
  FROM SYS.dba_objects a,
       SYS.dba_objects b,
       (SELECT     object_id, referenced_object_id
              FROM public_dependency
        WHERE object_id in
                      (SELECT object_id
                         FROM SYS.dba_objects
                        WHERE owner = :OWNER
                        )) c
 WHERE a.object_id = c.object_id
   AND b.object_id = c.referenced_object_id
   AND a.owner = '&owner'
   AND b.owner = a.owner
   AND a.object_name = '&OBJ'
   AND b.object_name = a.object_name
   and b.owner <> a.owner /* Dependencia de owner distinto al consultado */;