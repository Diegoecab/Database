Este script permite determinar cu�nta memoria est� siendo usada por los objetos de tipo funcion, procedimiento, y paquete. El resultado de la ejecuci�n de este script se debe entender en Bytes.

SELECT SUM(sharable_mem)as cantidad_memoria
FROM V$DB_OBJECT_CACHE
WHERE type in ('FUNCTION', 'PROCEDURE', 'PACKAGE', 'PACKAGE BODY')

