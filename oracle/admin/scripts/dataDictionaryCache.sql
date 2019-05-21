gets = # numero de solicitudes para el objeto 
getmisses = # numero de solicitudes para el objeto que fueron rechazadas Objetivo reducir el valor de rcradio a un valor inferior a 1

tarea: ajustar el valor del parametro SHARED_POOL_SIZE en el init.ora, incrementandolo en pequeñas cantidades.

SELECT SUM(GETS) HITS, SUM(GETMISSES) LIBMISS, SUM(GETMISSES)/SUM(GETS) RCRATIO FROM V$ROWCACHE ;
