Hard Parse, Soft Parse & �Softer� Soft Parse

Procesamiento de una consulta:

1) Validaci�n Sint�ctica
2) Validaci�n Sem�ntica
3) Optimizaci�n
4) Generaci�n del QEP (Query Execution Plan)
5) Ejecuci�n del QEP (Query Execution Plan)

El punto 1 al 4 forma parte del Parseo de la consulta, mientras que el punto 5 es la propia ejecuci�n.

Cuando ejecutamos una consulta, siempre se realizan, como m�nimo, los pasos 1 y 2. Luego de ejecutarse estos pasos, Oracle transforma la consulta en un valor hash y la env�a a la Shared Pool y en la Library Cache se busca si existe alguna consulta con el mismo valor hash (si alguna sesi�n ya la utiliz� en algun momento). En caso de que exista, se compara el texto de la consulta con la que se encontr� en la Library Cache para validar si son exactamente iguales (este paso adicional se realiza porque puede llegar a haber varias consultas con el mismo valor hash); en caso de que lo sean, se procede a ejecutar esa consulta. Esto es lo que llamamos un Soft Parse. Si la consulta no existe, Oracle realiza los pasos 3 y 4. Esto es conocido como un Hard Parse. El Hard Parse es muy costoso para Oracle Server ya que implica realizar varios latches (loqueos) en la SGA y consume mucha CPU.
Como bien sabemos, cada consulta que ejecutamos implica la utilizaci�n de un cursor (un cursor es un espacio de memoria destinado a la ejecuci�n de nuestra consulta). Lo ideal, es que nuestra aplicaci�n abra los cursores que vaya a utilizar, ejecute las sentencias x veces y luego los cierre. Muchas aplicaciones como Forms no suelen ejecutar los cursores de esta forma, lo que implica que no podamos reutilizar los cursores y siempre tengamos que abrir nuevamente los que ya ejecutamos.
Para reducir �ste problema, podemos utilizar el par�metro de inicializaci�n SESSION_CACHED_CURSORS que nos va a permitir realizar un "Softer" Soft Parse. Si setemos el par�metro en 100, Oracle mantendr� 100 cursores abiertos para que los podamos reutilizar y evitarnos tener que abrirlos cada vez. Este espacio de memoria destinado al manejo de cursores, se mantiene con una lista LRU.
Oracle recomiendo que el par�metro se setee en una primera instancia en 50 e ir monitoreandolo para verificar si conviene incrementar su valor. Este par�metro debe setearse considerando el valor de OPEN_CURSORS.

select to_char(100 * sess / calls, '999999999990.00') || '%' cursor_cache_hits,
       to_char(100 * (calls - sess - hard) / calls, '999990.00') || '%' soft_parses,
       to_char(100 * hard / calls, '999990.00') || '%' hard_parses
from ( select value calls from v$sysstat where name = 'parse count (total)' ),
     ( select value hard from v$sysstat where name = 'parse count (hard)' ),
     ( select value sess from v$sysstat where name = 'session cursor cache hits' ) ;

CURSOR_CACHE_HITS SOFT_PARSES HARD_PARSES
----------------- ----------- -----------
        59.11%      39.49%       1.39%


select
'session_cached_cursors'  parameter,
lpad(value, 5)  value,
decode(value, 0, '  n/a', to_char(100 * used / value, '990') || '%')  usage
from
( select
    max(s.value)  used
  from
    sys.v_$statname  n,
    sys.v_$sesstat  s
  where
    n.name = 'session cursor cache count' and
    s.statistic# = n.statistic#
),
( select
    value
  from
    sys.v_$parameter
  where
    name = 'session_cached_cursors'
)
union all
select
'open_cursors',
lpad(value, 5),
to_char(100 * used / value,  '990') || '%'
from
( select
    max(sum(s.value))  used
  from
    sys.v_$statname  n,
    sys.v_$sesstat  s
  where
    n.name in ('opened cursors current', 'session cursor cache count') and
    s.statistic# = n.statistic#
  group by
    s.sid
),
( select
    value
  from
    sys.v_$parameter
  where
    name = 'open_cursors'
) ;

PARAMETER              VALUE           USAGE
---------------------- --------------- -----
session_cached_cursors   100            100%
open_cursors             300             57%



Si el valor del SESSION_CACHED_CURSORS se encuentra en el 100%, deber�amos incrementar el valor del par�metro con normalidad.