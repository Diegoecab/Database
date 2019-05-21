SQL>set pages 50
SQL>set numwidth 18
SQL>set lines 132
SQL>set time on
18:04:54 SQL>
18:04:54 SQL>REM --Creación de una tabla de pruebas -DEPT
18:04:55 SQL>create table dept
18:04:55 2 as select *
18:04:55 3 from demo.departments;
Table created.
18:04:55 SQL>commit;
Commit complete.
18:04:55 SQL>REM --Crear otra tabla para almacenar los tiempos y SCN.
18:04:55 SQL>REM --Esta tabla se la usará para hacer Flashback.
18:04:56 SQL>create table save_date (fb_date date,fb_scn number);
Table created.
18:04:57 SQL>REM --Ver el contenido de la tabla de pruebas
18:04:57 SQL>select *from dept;

DEPARTMENT_ID   DEPARTMENT_NAME     MANAGER_ID    LOCATION_ID
--------------- ------------------- -----------   -----------
10              Administration      200                 1700
20              Marketing           201                 1800
30              Purchasing          114                 1700
40              Human Resources     203                 2400
50              Shipping            121                 1500
60              IT                  103                 1400
70              Public Relations    204                 2700
80              Sales               145                 2500
90              Executive           100                 1700
100             Finance             108                 1700
10 rows selected.

18:04:59 SQL>REM -Mostrar la última entrada de la tabla SMON_SCN_TIME
18:05:00 SQL>select to_char(max(time_dp),'MM/DD/YYYY HH24:MI:SS')timestamp,
18:05:00 2 max(scn_wrp *4294967295 +scn_bas)scn
18:05:00 3 from
18:05:00 4 sys.smon_scn_time
18:05:00 5 /

TIMESTAMP                          SCN
-------------------------------------
02/22/2004 18:03:07           9641769

18:05:01 SQL>REM --Ahora, esperar por un poco más de 5 minutos para 
18:05:01 SQL>REM --asegurarse que otro registro se almacene en
18:05:01 SQL>REM --la tabla smon_scn_time antes de crear
18:05:01 SQL>REM --la tabla DEPT con nuestros de datos de prueba.

18:11:10 SQL>REM --Verificar la nueva entrada en SMON_SCN_TABLE
18:11:16 SQL>select to_char(max(time_dp),'MM/DD/YYYYHH24:MI:SS')timestamp,
18:11:17 2 max(scn_wrp *4294967295 +scn_bas)scn
18:11:17 3 from
18:11:17 4 sys.smon_scn_time
18:11:17 5 /

TIMESTAMP                         SCN
------------------------------------
02/22/2004 18:08:25          9642837

18:11:18 SQL>REM --Guardar el actual timestamp y SCN en nuestra tabla.
18:11:21 SQL>insert into save_date
18:11:21 2 (select curr_date,curr_scn
18:11:21 3 from select sysdate curr_date from dual),
18:11:21 4 (select dbms_flashback.get_system_change_numbercurr_scn from dual)
18:11:21 5 );
1 row created.

18:11:21 SQL>commit;
Commit complete.

18:11:21 SQL>select to_char (fb_date,'DD-MON-YYYY:HH24:MI:SS')CURR_DATE,
18:11:21 2 fb_scn CURR_SCN
18:11:21 3 from save_date
18:11:21 4 ;

CURR_DATE                    CURR_SCN
-------------------------------------
22-FEB-2004:18:11:21         9643279

18:11:21 SQL>REM --En este momento hay un nuevo 
18:11:21 SQL>REM --valor en la tabla SMON_SCN_TIME
18:11:21 SQL>pause
18:11:24 SQL>REM --Vamos a simular un DELETE accidental en nuestra tabla.
18:11:24 SQL>pause
18:11:25 SQL>delete from dept;
27 rows deleted.

18:11:25 SQL>commit;
Commit complete.

18:11:29 SQL>REM --Usando Flashback para deshacer el cambio confirmado...
18:11:31 SQL>REM --1ro habilitar el modo flashback

18:11:32 SQL>declare
18:11:32 2 reco_date date;
18:11:32 3 begin
18:11:32 4
18:11:32 5 --Obtener la fecha a hacer flashback.
18:11:32 6 select fb_date into reco_date
18:11:32 7 from save_date;
18:11:32 8
18:11:32 9 --Ejecutar el flashback al tiempo almacenado
18:11:32 10 dbms_flashback.enable_at_time (reco_date);
18:11:32 11
18:11:32 12 end;
18:11:32 13 /
PL/SQL procedure successfully completed.

18:11:32 SQL>REM --Ahora estamos en el modo Flashback. Veremos que hay en DEPT

18:11:33 SQL>select *from dept;

DEPARTMENT_ID    DEPARTMENT_NAME     MANAGER_ID    LOCATION_ID
---------------- ------------------- ------------- -----------
10               Administration             200           1700
20               Marketing                  201           1800
30               Purchasing                 114           1700
40               Human Resources            203           2400
50               Shipping                   121           1500
60               IT                         103           1400
70               Public Relations           204           2700
80               Sales                      145           2500
90               Executive                  100           1700
100              Finance                    108           1700
10 rows selected.


18:11:33 SQL>REM --Cómo insertar estos datos de flashback en la tabla DEPT?
18:11:34 SQL>REM --Se puede hacer de dos maneras diferentes
18:11:34 SQL>REM --1.Abrir un cursor mientras se está en el modo flashback
18:11:34 SQL>REM --finalizar el modo flashback(para habilitar sentencias DML)
18:11:34 SQL>REM --Obtener e insertar los datos desde el cursor:

18:11:36 SQL>declare
18:11:36 2 cursor fb_cur
18:11:36 3 is
18:11:36 4 select *
18:11:36 5 from dept;
18:11:36 6
18:11:36 7 dept_fb_rec dept%rowtype;
18:11:36 8
18:11:36 9 begin
18:11:36 10 --Abrir el cursos para obtener los datos de DEPT
18:11:36 11 open fb_cur;
18:11:36 12
18:11:36 13 --Ahora finalizar el modo flashback.----Esto es requerido
18:11:36 14 --Los datos están almacenados en el cursor
18:11:36 15 dbms_flashback.disable;
18:11:36 16
18:11:36 17 --Leer el cursor
18:11:36 19 loop
18:11:36 20 fetch fb_cur into dept_fb_rec;
18:11:36 21 exit when fb_cur%notfound;
18:11:36 22 insert into dept
18:11:36 23 values (dept_fb_rec.department_id,
18:11:36 24 dept_fb_rec.department_name,
18:11:36 25 dept_fb_rec.manager_id,
18:11:36 26 dept_fb_rec.location_id);
18:11:36 27 end loop;
18:11:36 28
18:11:36 29 --Cerrar el cursor y confirmar la transacción
18:11:36 30 close fb_cur;
18:11:36 31 commit;
18:11:36 32
18:11:36 33 end;
18:11:36 34 /
PL/SQL procedure successfully completed.

18:11:36 SQL>REM --Verificar el contenido de la tabla DEPT
18:11:38 SQL>select *from dept;

DEPARTMENT_ID    DEPARTMENT_NAME     MANAGER_ID    LOCATION_ID
---------------- ------------------- ------------- -----------
10               Administration             200           1700
20               Marketing                  201           1800
30               Purchasing                 114           1700
40               Human Resources            203           2400
50               Shipping                   121           1500
60               IT                         103           1400
70               Public Relations           204           2700
80               Sales                      145           2500
90               Executive                  100           1700
100              Finance                    108           1700
10 rows selected.

18:11:39 SQL>REM -hemos recuperado los datos.

18:11:40 SQL>REM -Vamos a eliminar devuelta los datos de DEPT para ver la otra 
18:11:40 SQL>REM -alternativa de recuperación por flashback
18:11:41 SQL>delete from dept;
27 rows deleted.

18:11:41 SQL>commit;
Commit complete.

18:11:41 SQL>REM -2.para esta segunda alternativa
18:11:41 SQL>REM -no es necesario deshabilitar flashback.
18:11:41 SQL>REM -Crear otra tabla utilizando el comando COPY de SQL*PLUS

18:11:42 SQL>declare
18:11:42 2 reco_date date;
18:11:42 3 begin
18:11:42 4
18:11:42 5 --Obtener los datos del tiempo de flashback
18:11:42 6 select fb_date into reco_date
18:11:42 7 from save_date;
18:11:42 8
18:11:42 9 -- Ejecutar el flashback en el tiempo
18:11:42 10 dbms_flashback.enable_at_time (reco_date);
18:11:42 11
18:11:42 20 end;
18:11:42 21 /
PL/SQL procedure successfully completed.

18:11:42 SQL>
18:11:43 SQL>REM -Verificar los datos en la tabla dept
18:11:44 SQL>select *from dept;

DEPARTMENT_ID    DEPARTMENT_NAME     MANAGER_ID LOCATION_ID
---------------- ------------------- ---------- -----------
10               Administration             200        1700
20               Marketing                  201        1800
30               Purchasing                 114        1700
40               Human Resources            203        2400
50               Shipping                   121        1500
60               IT                         103        1400
70               Public Relations           204        2700
80               Sales                      145        2500
90               Executive                  100        1700
100              Finance                    108        1700
10 rows selected.

18:11:44 SQL>REM -Usar el comando COPY de SQL*PLUS
18:11:44 SQL>REM -de la tabla DEPT del flashback a una llamada OLD_DEPT
18:11:45 SQL>copy to kirti/kirti@OR92 -
18:11:45 >create old_dept -
18:11:45 >using -
18:11:45 >select *-
18:11:45 >from dept;
Array fetch/bind size is 15.(arraysize is 15)
Will commit when done.(copycommit is 0)
Maximum long size is 80.(long is 80)
Table OLD_DEPT created.
27 rows selected from DEFAULT HOST connection.
27 rows inserted into OLD_DEPT.
27 rows committed into OLD_DEPT at kirti@OR92.

18:11:45 SQL>REM -Verificar los datos en la tabla OLD_DEPT.
18:11:48 SQL>select *from old_dept;
select *from old_dept
*
ERROR at line 1:
ORA-01466:unable to read data -table definition has changed

18:11:48 SQL>REM -Oops!!! Qué es esto?
18:11:50 SQL>REM -Todavía estamos en modo flashback
18:11:50 SQL>REM -Los datos estarán visibles cuando salga del modo flashback

18:11:51 SQL>exec dbms_flashback.disable;
PL/SQL procedure successfully completed.

18:11:51 SQL>REM -volver a ver OLD_DEPT ahora...
18:11:56 SQL>select *from old_dept;

DEPARTMENT_ID  DEPARTMENT_NAME  MANAGER_ID LOCATION_ID
-------------- ---------------- ---------- -----------
10             Administration          200        1700
20             Marketing               201        1800
30             Purchasing              114        1700
40             Human Resources         203        2400
50             Shipping                121        1500
60             IT                      103        1400
70             Public Relations        204        2700
80             Sales                   145        2500
90             Executive               100        1700
100            Finance                 108        1700
10 rows selected.

18:11:57 SQL>REM -Ahora estos datos pueden ser insertados ennuestra tabla

=================================================================
18:11:58 SQL>REM -
18:11:58 SQL>REM -En Oracle 9i Rel 2, hay una variante para esto
18:11:58 SQL>REM -No es necesario entrar en un modo flashback
18:11:58 SQL>REM -No hay que tener privilegios de ejecución en DBMS_FLASHBACK.
18:11:58 SQL>REM -Directamente se utiliza la opción "AS OF"
=================================================================
18:11:58 SQL>conn sys/sys as sysdba
Connected.

18:11:58 SQL>revoke execute on dbms_flashback from kirti;
Revoke succeeded.

18:12:03 SQL>conn kirti/kirti
Connected.

18:12:04 SQL>REM -Nueva sintaxis de flashback para Oracle 9i Rel 2
18:12:04 SQL>
18:12:04 SQL>/*
18:12:04 DOC>------------Ejemplos-------------------------------
18:12:04 DOC>select *
18:12:04 DOC>from dept
18:12:04 DOC>as of scn 1234;
18:12:04 DOC>
18:12:04 DOC>select *
18:12:04 DOC>from dept
18:12:04 DOC>as of timestamp to_timestamp('02/10/200315:10:05','MM/DD/YYYY HH24:MI:SS');
18:12:04 DOC>--------------------------------------------------*/
18:12:04 SQL>REM -No están permitidas las subconsultas en esta sintaxis
18:12:04 SQL>REM -Pero es posible utilizar variables

18:12:07 SQL>col fbscn noprint new_value fb_scn
18:12:07 SQL>col timestamp noprint new_value fb_timestamp

18:12:07 SQL>select fb_scn fbscn,
18:12:07 2 to_char(fb_date,'MM/DD/YYYY HH24:MI:SS')timestamp
18:12:07 3 from save_date
18:12:07 4 /

18:12:07 SQL>REM -Ahora tenemos los valores de SCN y timestamp en variables

18:12:08 SQL>select *
18:12:08 2 from dept
18:12:08 3 as of timestampto_timestamp('&&fb_timestamp','MM/DD/YYYY HH24:MI:SS');
old 3:as of timestamp to_timestamp('&&fb_timestamp','MM/DD/YYYY HH24:MI:SS')
new 3:as of timestamp to_timestamp('02/22/2004 18:11:21','MM/DD/YYYY HH24:MI:SS')

DEPARTMENT_ID  DEPARTMENT_NAME  MANAGER_ID  LOCATION_ID
------- ---------------- ----------- ----------------------------
10             Administration           200        1700
20             Marketing                201        1800
30             Purchasing               114        1700
40             Human Resources          203        2400
50             Shipping                 121        1500
60             IT                       103        1400
70             Public Relations         204        2700
80             Sales                    145        2500
90             Executive                100        1700
100            Finance                  108        1700
10 rows selected.

18:12:09 SQL>REM -Oracle 9i R2 ofrece la siguiente sintaxis para operaciones 18:12:09 SQL>REM - DML con las consultas Flashback.

18:12:09 SQL>/*
18:12:09 DOC>----------------Ejemplo-----------------------------
18:12:09 DOC>insert into dept
18:12:09 DOC>select *
18:12:09 DOC>from dept
18:12:09 DOC>as of scn <variable>;
18:12:09 DOC>----=---------------------------------------------*/

18:12:09 SQL>REM -Verificar el ROWCOUNT de la tabla DEPT
18:12:10 SQL>
18:12:10 SQL>select count(*)
18:12:10 2 from dept
18:12:10 3 ;
COUNT(*)
------------------
0

18:12:11 SQL>insert into dept
18:12:11 2 select *
18:12:11 3 from dept
18:12:11 4 as of scn &&fb_scn
18:12:11 5 ;
old 4:as of scn &&fb_scn
new 4:as of scn 9643279
27 rows created.

18:12:11 SQL>commit;
Commit complete.

18:12:11 SQL>REM -Se han recuperado los datos de la tabla DEPT.

