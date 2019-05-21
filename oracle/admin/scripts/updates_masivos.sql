Modificar millones de registros de una tabla

Suele ocurrir, que la soluci�n que se utiliza es realizar un simple UPDATE. Si hablamos de performance, la ejecuci�n de �sta sentencia puede tener un gran impacto en la base de datos. Porqu�? porque principalmente, generamos much�simos bytes de redo y undo.

Si tengo que modificar millones de datos de una tabla, optar�a por NO modificarlos.
Implementar�a la siguiente estrategia.

Veamos un ejemplo:

Supongamos que tenemos una tabla llamada TEST que contiene 5 millones de registros, una primary key y un �ndice �nico:


SQL_9iR2> CREATE TABLE test NOLOGGING PARALLEL 4 AS
  2  SELECT level id, 'nom_'||level nom
  3  FROM dual
  4  CONNECT BY level <= 5000000 ;

Table created.

Elapsed: 00:00:16.06

SQL_9iR2> ALTER TABLE test ADD CONSTRAINT test_id_pk PRIMARY KEY (id) NOLOGGING PARALLEL 4 ;

Table altered.

Elapsed: 00:00:14.03

SQL_9iR2> CREATE UNIQUE INDEX test_id_nom_uq ON test(id,nom) NOLOGGING PARALLEL 4 ;

Index created.

SQL_9iR2> SELECT *
  2  FROM test
  3  WHERE rownum <= 10 ;

        ID NOM
---------- --------------
     37011 nom_37011
     37012 nom_37012
     37013 nom_37013
     37014 nom_37014
     37015 nom_37015
     37016 nom_37016
     37017 nom_37017
     37018 nom_37018
     37019 nom_37019
     37020 nom_37020

10 rows selected.


Si nosotros quisi�ramos modificar los datos de la columna NOM, no vamos a utilizar la cl�usula UPDATE, sino que vamos a realizar los siguientes pasos:

1) Lo primero que vamos a hacer es crear una tabla con las modificaciones que queremos realizar. En nuestro caso dijimos que vamos a modificar la columna NOM. Fijense que cuando cre� la tabla, esa columna est� en min�sculas. El cambio que vamos a realizar es colocar el contenido en may�sculas:


SQL_9iR2> CREATE TABLE test_nueva NOLOGGING PARALLEL 4 AS
  2  SELECT id, UPPER(nom) nom
  3  FROM test ;

Table created.

Elapsed: 00:00:03.05


Como podemos observar, lo que hice fue colocar en el SELECT los cambios que quer�a realizar. En s�lo 3 segundos tenemos nuestra tabla nueva creada y con los cambios realizados.

2)Agregamos las constraints a la nueva tabla y sus respectivos �ndices:


SQL_9iR2> ALTER TABLE test_nueva ADD CONSTRAINT test_id_pk_2 PRIMARY KEY(id) NOLOGGING PARALLEL 4 ;

Table altered.

Elapsed: 00:00:22.05

SQL_9iR2> CREATE UNIQUE INDEX test_id_nom_uq_2 ON test_nueva(id,nom) NOLOGGING PARALLEL 4 ;

Index created.

Elapsed: 00:00:20.03


3) Dropeamos la tabla TEST:


SQL_9iR2> DROP TABLE test ;

Table dropped.

Elapsed: 00:00:00.02


4) Modificamos el nombre de la tabla TEST_NUEVA, las constraints e �ndices:


SQL_9iR2> ALTER TABLE test_nueva RENAME TO test ;

Table altered.

Elapsed: 00:00:00.03

SQL_9iR2> ALTER INDEX test_id_nom_uq_2 RENAME TO test_id_nom_uq ;

Index altered.

Elapsed: 00:00:00.02

SQL_9iR2> ALTER TABLE test RENAME CONSTRAINT test_id_pk_2 TO test_id_pk ;

Table altered.

Elapsed: 00:00:00.02


5) Por �ltimo, granteamos los permisos que ten�amos en la tabla vieja a la nueva tabla.

Para crear los objetos de �ste ejemplo, utilic� las cl�usulas NOLOGGING y PARALLEL. La cl�usula NOLOGGING la utilic� para generar muy poco redo y nada de undo.
La cl�usula PARALLEL la utilic� para paralelizar (a trav�s de 4 CPU's en nuestro ejemplo) las operaciones que ejecutamos sobre los objetos.
En caso de que queramos volver a colocar la tabla en modo LOGGING y NOPARALLEL, ejecutar�amos...


SQL_9iR2> ALTER TABLE test LOGGING NOPARALLEL ;

Table altered.

Elapsed: 00:00:00.01


C�mo quedaron los datos de nuestra tabla? Veamos algunos registros...


SQL_9iR2> SELECT *
  2  FROM test
  3  WHERE rownum <= 10 ;

        ID NOM
---------- --------------
     37011 NOM_37011
     37012 NOM_37012
     37013 NOM_37013
     37014 NOM_37014
     37015 NOM_37015
     37016 NOM_37016
     37017 NOM_37017
     37018 NOM_37018
     37019 NOM_37019
     37020 NOM_37020

10 rows selected.


Como podemos observar, realizamos las modificaciones que necesit�bamos sin tener un impacto en la performance del sistema.