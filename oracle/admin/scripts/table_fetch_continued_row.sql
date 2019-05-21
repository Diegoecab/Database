/*Script para ver las migraciones de registros ...*/
col table_fetch_continued_row form 999,999,999,999 head 'Chained Fetches'
col datetime head ' Date      Time'
accept num_days default 2 prompt 'Enter the Number of Days to search on: ' select
datetime,
       table_fetch_continued_row
  from (select to_char(snap_time,'yyyy-mm-dd HH24')||':00' datetime,

               case
                   when ts.startup_time = lag(startup_time,1,null) over
                                             (partition by startup_time
                                                  order by snap_time)
                        then value - lag(value,1,null) over
                                        (partition by startup_time
                                             order by snap_time)
                   when lag(startup_time,1,null) over

                           (partition by startup_time
                                order by snap_time) is null
                        then lag(value,1,null) over
                                (partition by startup_time
                                     order by snap_time)
                   else value
               end as table_fetch_continued_row
          from perfstat.stats$sysstat a,
               perfstat.stats$snapshot ts

         where snap_time > sysdate - &num_days
           and a.snap_id = ts.snap_id
           and a.name = 'table fetch continued row')
 where table_fetch_continued_row is not null
/

/* Ver chaineds / Migrac. en systema */

SELECT a.name, b.value
  FROM v$statname a, v$mystat b
 WHERE a.statistic# = b.statistic#
   AND lower(a.name) = 'table fetch continued row';


/* Ver cantidad de migrated or truly chained en tabla */


ANALYZE TABLE tabla COMPUTE STATISTICS;

SELECT chain_cnt
  FROM user_tables
 WHERE table_name = 'TABLA';



/* Al levantar la instancia :*/

SELECT 'Chained or Migrated Rows = '||value
  FROM v$sysstat
 WHERE name = 'table fetch continued row';

/* Cantidad Registros migrados en una tabla */

ANALYZE TABLE tabla COMPUTE STATISTICS;

SELECT chain_cnt,
       round(chain_cnt/num_rows*100,2) pct_chained,
       avg_row_len, pct_free , pct_used
  FROM user_tables
WHERE table_name = 'TABLA';


(PCT_CHAINED - Porcentaje)




/* Soluciones :


1)  Verificar cuantos registros por bloque tiene la tabla */
SELECT dbms_rowid.rowid_block_number(rowid) "Block-Nr", count(*) "Rows"
  FROM TABLA
GROUP BY dbms_rowid.rowid_block_number(rowid) order by 1;

/* 2) Move de tabla. Se puede especificar nuevos parametros de storage */

ALTER TABLE TABLA MOVE
   PCTFREE 20
   PCTUSED 40
   STORAGE (INITIAL 20K
            NEXT 40K
            MINEXTENTS 2
            MAXEXTENTS 20
            PCTINCREASE 0);

/* Volver a  ver los registros por bloque */

SELECT dbms_rowid.rowid_block_number(rowid) "Block-Nr", count(*) "Rows"
  FROM TABLA
GROUP BY dbms_rowid.rowid_block_number(rowid) order by 1;

/* 3) Rebuild de indices de la tabla */

ALTER INDEX INDICE REBUILD;

/* Estadísticas para la tabla ...*/

dbms_stats....

ANALYZE TABLE tabla COMPUTE STATISTICS;



/* Nuevo select de registros migrados ..*/

SELECT chain_cnt,
       round(chain_cnt/num_rows*100,2) pct_chained,
       avg_row_len, pct_free , pct_used
  FROM user_tables
WHERE table_name = 'TABLA';




/* Detectar todas las tablas con registros migrados ...

1_ Crear tabla donde se guardarán los datos . Ejemplo CHAINED_ROWS */
cd $ORACLE_HOME/rdbms/admin
sqlplus scott/tiger
@utlchain.sql


/*2_ Analyze de las tablas ...*/

SELECT 'ANALYZE TABLE '||table_name||' LIST CHAINED ROWS INTO CHAINED_ROWS;'
  FROM user_tables
/

/* Ver resultados ...*/

SELECT owner_name,
       table_name,
       count(head_rowid) row_count
  FROM chained_rows
GROUP BY owner_name,table_name
/



/* Conclusiones : */

La migración de registros, es causado normalmente por las operaciones UPDATE.

El encadenamiento de registros, normalmente es causado por los Inserts.

La migracion - encadenamiento de registros reduce la performance de I/O

Para diagnosticar migracion - encadenamiento se utiliza el comando Analyze, y la vista V$SYSSTAT

Para eliminar la migracion - encadenamiento se usa mas PCTFREE usando ALTER TABLE MOVE.


Tarda aprox 1.5 min en una tabla de 10000000 de registros (1,1 GB)

