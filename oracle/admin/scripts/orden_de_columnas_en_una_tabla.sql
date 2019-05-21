El orden de las columnas de una tabla puede tener un impacto sobre el rendimiento. Hay dos factores a considerar:

En primer lugar, las filas en Oracle se almacenan como una fila de cabecera seguida de la columna de datos. La fila de cabecera contiene un byte de bandera, un byte de bloqueo y un contador de columnas, y luego para cada columna está la longitud de la columna seguido por la columna de datos. Para acceder al valor de cualquier fila/columna, Oracle tiene que examinar en primer lugar la longitud de bytes de todas las columnas anteriores. Esta es una operación muy rápida y eficiente, pero se hace con tanta frecuencia que, sin embargo, sí tiene un impacto en el rendimiento.

En el siguiente ejemplo, vamos a crear una tabla de 10 columnas e insertaremos las filas suficientes para llenar una sola base de datos de 2K. A continuación, vamos a comparar el tiempo de respuesta sobre varios accesos en la primera columna y la última columna.

    SQL> create table small (

      2    n0 number,

      3    n1 number,

      4    n2 number,

      5    n3 number,

      6    n4 number,

      7    n5 number,

      8    n6 number,

      9    n7 number,

     10    n8 number,

     11    n9 number

     12  ) pctfree 0;

    Table created.

    SQL> begin

      2    for i in 1..78 loop

      3      insert into small values (0,0,0,0,0,0,0,0,0,0);

      4    end loop;

      5  end;

      6  /

    PL/SQL procedure successfully completed.

    SQL> set timing on

    SQL> declare

      2    n number;

      3  begin

      4    for i in 1..1000000 loop

      5      select sum(n0) into n from small;

      6    end loop;

      7  end;

      8  /

    PL/SQL procedure successfully completed.

    Elapsed: 00:07:437.30

    SQL> declare

      2    n number;

      3  begin

      4    for i in 1..1000000 loop

      5      select sum(n9) into n from small;

      6    end loop;

      7  end;

      8 /

    PL/SQL procedure successfully completed. 

    Elapsed: 00:08:482.13

Esto demuestra que tomó un 10% más de tiempo para acceder a la 10ma columna de la tabla de lo que lo hizo para acceder a la 1ra columna. El principio es simple. Coloque las columnas a las que más accede en el principio de la tabla. Recuerde que los valores de la columna por regla general, se acceden con más frecuencia por la cláusula WHERE, que por un select-list. Sin embargo, los valores de columnas que aparecen en el manejo de predicados importantes pueden ser accedidos relativamente con poca frecuencia si la tabla es consistentemente accedida por una clave a través de un índice en esa columna. Particularmente, las columnas con claves primarias son rara vez las más accedidas de la tabla, y normalmente no sería la primer columna de la tabla.

El segundo aspecto a tener en cuenta en relación al orden de las columnas de una tabla para cuidar la performance es la posición de las columnas que suelen contener NULLs. Oracle normalmente requiere un byte para representar cada NULL, excepto que no almacene NULLs en una fila de datos. Esto puede ser demostrado de la siguiente manera.

    SQL> create table null_order (

      2    column1 number,

      3    column2 number,

      4    column3 number

      5  );

    Table created.

    SQL> insert into null_order (column2) values (0);

    1 row created.

    SQL> select header_file, header_block from dba_segments

      2  where segment_name = ‘NULL_ORDER’ and owner = user;

    HEADER_FILE HEADER_BLOCK

    ———– ————

              3        50010

    SQL> alter system dump datafile 3 block 50011;

    System altered.

La primera y tercera columnas de la una fila de este cuadro son NULL. El siguiente extracto del bloque volcado muestra cómo se representan: 

    block_row_dump:

    tab 0, row 0, @0×7b2

    tl: 6 fb: –H-FL– lb: 0×1 cc: 2

    col  0: *NULL*

    col  1: [ 1]  80

    end_of_block_dump

El NULL en la primera columna se almacena explícitamente y aumenta en un byte la longitud del registro. Pero el NULL de la tercera columna no necesita ser almacenada explícitamente porque no existen posteriores valores no nulos en la fila. Al leer una fila de la tabla, Oracle es capaz de inferir que cualquier columna que no está representada explícitamente debe contener NULLs.

Colocar las columnas que suelen contener NULLs al final de la tabla, minimiza la longitud media de la fila y optimiza la densidad de datos de la tabla, lo que obviamente, beneficia la performance. Este tipo de ordenamiento de  columnas  también minimiza el número de bytes de longitud de la columna por las que deben transitar para acceder a los valores no nulos de las columnas. Esto también  beneficia el rendimiento como se explico más arriba.