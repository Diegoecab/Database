REM Detalles de parametro optimizer_index_cost_adj
REM ======================================================================
REM param_optimizer_index_cost_adj.sql		Version 1.1	29 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM
REM Notas:
REM
REM Precauciones:
REM	
REM ======================================================================
REM

optimizer_index_cost_adj

Con ayuda de este par�metro podemos hacer que las decisiones de acceso del optimizador hacia los datos favorezcan el uso de �ndices antes que del uso de Full table scan.

Este par�metro permite agregar un factor de ponderaci�n al enfoque basado en costes cuando se realiza la evaluaci�n de los �ndices 