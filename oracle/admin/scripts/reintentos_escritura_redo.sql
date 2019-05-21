SELECT retries.value/entries.value||' %' AS  Indicador_de_Reintentos 
FROM v$sysstat retries, v$sysstat entries 
WHERE retries.name = 'redo buffer allocation retries' 
AND entries.name = 'redo entries';

/* Muestra Cuanto tiempo tuvo que esperar un usuario para almacenar una entrada en el Buffer Redo Log, 
debido a que el proceso LGWR no ha terminado aún de escribir el contenido del Buffer en el disco. (los Archivos Redo Log)*/
SELECT username usuario, seconds_in_wait tiempo_de_espeta, state estado
FROM v$session_wait, v$session
WHERE v$session_wait.sid = v$session.sid
AND event LIKE '%log buffer space%';