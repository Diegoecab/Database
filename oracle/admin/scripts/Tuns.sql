Set Pause    Off
Set Feedback Off
Set Time     Off
Set Echo     Off
Set Verify   Off
Set Pagesize 999
Set heading off
prompt ########################################################################
prompt #               Oracle Database Tuning Report                          #
prompt ########################################################################
prompt
Select 'Instancia: ' || value from v$parameter where name='db_name'
/
prompt
Select 'Servidor: ' || global_name from global_name
/
prompt
Column today format a50
Select 'Fecha de Este Reporte: '|| to_char(sysdate,'dd Month YYYY  HH24:MI') today from sys.dual;
prompt
Set heading on
prompt ########################################################################
prompt
prompt Memory Allocation Checks
prompt
prompt ########################################################################
prompt
Column libcache format 99.99 heading 'Library Cache Miss Ratio (%)'
prompt Library Cache Check 
prompt
prompt Objetivo:		<1% (Pins)
prompt
prompt Accion Correctiva:       Incrementar el parametro shared_pool_size.
prompt                          Escribir sentencias SQL identicas
prompt
Set heading on
select sum(reloads)/sum(pins) *100 libcache
from v$librarycache
/
prompt
prompt Detalle de los Gets y Pins en la Library Cache:
prompt
SELECT namespace "Area",
       gethitratio "Get Ratio",
       pinhitratio "Pin Ratio",
       reloads "Reloads"
FROM   v$librarycache
/
column pga format 999,999,999 heading 'Promedio de la Session PGA Memory'
prompt
prompt ########################################################################
prompt
prompt  UGA Memory
prompt
prompt  Accion:                 Se puede bajar la cantidad de 
prompt  .                       DB_FILES, LOG_FILES, OPEN_LINKS,
prompt  .                       y OPEN_CURSORS
prompt
select sum(value) "Session Memory"
from v$sesstat,v$statname
where name='session uga memory max'and
v$sesstat.statistic#=v$statname.statistic#
/
prompt
column ddcache1 format 99.99 heading 'Data Dictionary Cache Miss Ratio (%)'
column ddcache2 format 99.99 heading 'Data Dictionary Cache Entries use Ratio (%)'
column parameter format a25 heading 'Parametro'
prompt ########################################################################
prompt
prompt Data Dictionary Cache Check
prompt
prompt Objetivo:  		<10% (Misses) , >80% (Valid Entries)
prompt
prompt Accion:			Incrementar la shared_pool_size
prompt
select sum(getmisses)/sum(gets) * 100 ddcache1
from v$rowcache
/
prompt
select sum(usage)/sum(count) * 100 ddcache2
from v$rowcache
/
prompt
prompt Detalle de parámetro del INIT que no cumplen los objetivos:
prompt
SELECT parameter,
count "Cache Entries",
usage "Valid Entries",
gets "Requests",
getmisses "Cache Misses"
FROM v$rowcache
WHERE usage>(0.8*count) or
(getmisses/decode(gets,0,1))>0.10
/
prompt
column sess_mem heading "Session Memory (Bytes)" format 999,999,999
column sh_pool heading "Shared_Pool_Size (Bytes)" format 999,999,999
column name noprint
prompt ########################################################################
prompt
prompt Multi-Threaded Server Session Memory
prompt
prompt Objetivo:		Shared_pool_size at lease equal to maximum 
prompt .			session memory
prompt
prompt Corrective Action:	Increase shared_pool_size
prompt
select sum(value) sess_mem
	from v$sysstat
	where name='session memory'
/
prompt
select name,to_number(value) sh_pool
	from v$parameter
	where name='shared_pool_size'
/
prompt
column pct heading "Hit Ratio (%)" format 999.9
prompt ########################################################################
prompt
prompt Buffer Cache Hit Ratio
prompt
prompt Goal:			Above 60 to 70 percent
prompt
prompt Corrective Action:	Increase db_block_buffers
prompt

select (1- (sum(decode(a.name,'physical reads',value,0)))/
	(sum(decode(a.name,'db block gets',value,0)) +
	sum(decode(a.name,'consistent gets',value,0)))) * 100 pct
	from v$sysstat a
/
prompt
prompt ########################################################################
prompt
prompt Disk I/O Checks
prompt
prompt ########################################################################
column name print
column name heading "Data File" format a45
column phyrds heading "Reads" format 999,999,999
column phywrts heading "Writes" format 999,999,999
prompt ########################################################################
prompt
prompt Disk Activity Check
prompt
prompt Goal:			Balance Load Between Disks
prompt
prompt Corrective Action:	Transfer files, reduce other loads to disks,
prompt .			striping disks, separating data files and redo
prompt .			logs
prompt
drop table tot_read_writes;

create table tot_read_writes
 as select sum(phyrds) phys_reads, sum(phywrts) phys_wrts
      from v$filestat;

prompt ' Disk I/O s by Datafile '
column name format a40;
column phyrds format 999,999,999;
column phywrts format 999,999,999;
column read_pct format 999.99;         
column write_pct format 999.99;        
 
select name, phyrds, phyrds * 100 / trw.phys_reads read_pct, 
       phywrts,  phywrts * 100 / trw.phys_wrts write_pct
from  tot_read_writes trw, v$datafile df, v$filestat fs
where df.file# = fs.file# 
order by phyrds desc
/
prompt
prompt ########################################################################
prompt
prompt Oracle Contention Checks
prompt
prompt ########################################################################
column class heading "Class" format a20
column count heading "Counts" format 999,999,999
column gets heading "Total Gets" format 999,999,999,999
column "Ratio" format 99.99999
column name format a40
prompt
prompt Rollback Segment Contention
prompt
prompt Goal:			Measured Counts < 1% of total gets
prompt .			(the choice of Oracle column names makes it
prompt .			impossible to do this calculation for you)
prompt
prompt Corrective Action:	Add more rollback segments
prompt
select sum(value) gets
	from v$sysstat
	where name in ('db block gets','consistent gets')
/
prompt
select class,count
	from v$waitstat
	where class in ('system undo header','system undo block',
	  'undo header','undo block')

/
prompt    
prompt    Estadisticas sobre las transacciones en tablas
prompt 
prompt    Goal:    'transaction tables consistent reads' < 10% 'consistent changes'
prompt
prompt    Description: 'transaction tables consistent reads': # undo records aplicados
prompt                                                      sobre la rbs transact. table
prompt                 'consistent changes': Lectura de vieja version del bloque (buffer+rbs)
prompt
prompt
prompt    Corrective Action:      Agregar mas rollback segment
prompt
select substr(name,1,60) estadistica,
decode(name,'transaction tables consistent read rollbacks',value*100,value) valor
from v$sysstat
where 
name in ('consistent changes','transaction tables consistent read rollbacks')
/
prompt
prompt    Goal:   'transaction tables consistent reads - undo records applied'
prompt               < 0.1% 'consistent gets' 
prompt   
prompt    Description:  'transaction tables consistent reads - undo records applied': 
prompt                    # veces que las transacciones en tablas hicieron rollback
prompt                  
prompt    Corrective Action:      Agregar mas rollback segment
prompt
select substr(name,1,60) estadistica,
decode(name,'transaction tables consistent reads - undo records applied',value*100,value) valor
from v$sysstat
where
name in ('transaction tables consistent reads - undo records applied','consistent gets')
/
prompt
prompt    Detalle de contención del Rollback Segments:
prompt
prompt    Goal:    Ratio < 0.01 
prompt
prompt
prompt    Corrective Action:	Agregar mas rollbacks segments
prompt
select name, waits, gets, waits/gets "Ratio"
  from v$rollstat a, v$rollname b
where a.usn = b.usn
/
prompt
column name heading "Latch Type" format a30
column "miss_ratio" format 9999.99
column "immediate_miss_ratio" format 9999.99
column tipo_latch format a40
column avg_free_size format 999,999,999.99
column free_space format 999,999,999.99
column max_free_size format 999,999,999.99
column request_failures format 999,999,999.99
column request_misses format 999,999,999.99
column last_failure_size format 999,999,999.99
prompt ########################################################################
prompt Latch Contention Analysis
prompt
prompt   Detalle de contencion por Latches
prompt
prompt Goal:			< 1% miss/get(miss_ratio) 
prompt .			< 1% immediate miss/get(immediate_miss_ratio)
prompt                               solo para redo copy
prompt
prompt Corrective Action(REDO):	Redo allocation-  decrease log_small_entry_
prompt 				  max_size
prompt 	 			Redo copyIncrease log_simultaneous_copies
prompt                  (Buffers): Si se dispone de multiprocesadores 
prompt				   aumentar db_block_lru_latches
prompt                  (Shared Pool): Hacer flush de shared pool. Pinn de objetos
prompt                                 mas usados. Achicar tamaño shared pool.
prompt
select substr(l.name,1,30) name,
  (misses/(gets+.001))*100 "miss_ratio",
  (immediate_misses/(immediate_gets+.001))*100 "immediate_miss_ratio"
  from v$latch l, v$latchname ln
 where l.latch# = ln.latch#
 and (
  (misses/(gets+.001))*100 > .2
 or
  (immediate_misses/(immediate_gets+.001))*100 > .2
 )
 order by 2;
prompt
prompt   Detalle de latches misses y sleeps
prompt
select a.name, a.gets gets,
       a.misses*100/decode(a.gets,0,1,a.gets) miss,
       to_char(a.spin_gets*100/decode(a.misses,0,1,a.misses),'990.99')||chr(10)||
       to_char(a.sleep6*100/decode(a.misses,0,1,a.misses),'90.9') cspins,
       to_char(a.sleep1*100/decode(a.misses,0,1,a.misses),'990.9') ||chr(10)||
       to_char(a.sleep7*100/decode(a.misses,0,1,a.misses),'90.9') csleep1,
       to_char(a.sleep2*100/decode(a.misses,0,1,a.misses),'90.9') ||chr(10)||
       to_char(a.sleep8*100/decode(a.misses,0,1,a.misses),'90.9') csleep2,
       to_char(a.sleep3*100/decode(a.misses,0,1,a.misses),'90.9') ||chr(10)||
       to_char(a.sleep9*100/decode(a.misses,0,1,a.misses),'90.9') csleep3,
       to_char(a.sleep4*100/decode(a.misses,0,1,a.misses),'90.9') ||chr(10)||
       to_char(a.sleep10*100/decode(a.misses,0,1,a.misses),'90.9') csleep4,
       to_char(a.sleep5*100/decode(a.misses,0,1,a.misses),'90.9') ||chr(10)||
       to_char(a.sleep6*100/decode(a.misses,0,1,a.misses),'90.9') csleep5
from v$latch a
where a.misses <> 0
order by 2 desc
/
prompt
prompt    Detalle de latches que estan provocando contencion en este momento
prompt 
select name tipo_latch ,count(*) cantidad from v$session_wait sw,v$latch l
where event='latch free' and sw.p2=l.latch# group by name
/
prompt
prompt    Fragmentacion
prompt
prompt        Paquetes o Codigo que se flushea para hacer espacio
prompt        
select ksmlrcom "Tipo Estructura",ksmlrsiz "Tamaño",ksmlrhon "Objeto",
ksmlrnum "# Obj Flush"
from x$ksmlru
where ksmlrsiz>5000
/
prompt
prompt        Parametros de la area reservada de la Shared Pool
prompt
prompt        Goal:                   REQUEST_MISSES=0
prompt        .                       REQUEST_FAILURES=0
prompt        .                       LAST_FAILURE_SIZE>shared_pool_reserved_min_alloc
prompt        .                       AVG_FREE_SIZE>shared_pool_reserved_min_alloc
prompt             Bajar, si:         FREE_SPACE=>50 % shared_pool_reserved_size
prompt             .                  REQUEST_MISSES=0
prompt             Subir, si:         REQUEST_FAILURES>0
prompt             .                  LAST_FAILURE_SIZE>shared_pool_reserved_size
prompt             .                  MAX_FREE_SIZE<shared_pool_reserved_min_alloc
prompt             .                          
select avg_free_size,free_space,request_failures,request_misses,last_failure_size
from v$shared_pool_reserved
/
select max_free_size from v$shared_pool_reserved
/
prompt
column protocol heading "Protocol" format a15
column pct heading "Percent Busy" format 999.99999
prompt ########################################################################
prompt MTS Dispatcher Contention
prompt
prompt Goal:			< 50%
prompt
prompt Corrective Action:	Add dispatcher processes
prompt
select network protocol,sum(busy)*100/(sum(busy)+sum(idle)) pct
	from v$dispatcher
	group by network
/
prompt
column wait heading "Average Wait Per Request (1/100 sec)" format 9,999.99
column sh_proc heading "Shared Server Processes" format 99
column max_srv heading "MTS_MAX_SERVERS" format 99
prompt ########################################################################
prompt
prompt Shared Server Process Contention
prompt
prompt Goal:			Shared processes less that MTS_MAX_SERVERS
prompt
prompt Corrective Action:	Alter MTS_MAX_SERVERS
prompt
select decode(totalq,0,'No Requests',wait/totalq || '1/100 sec')
"Average wait per request"
from v$queue
where type='COMMON'
/
prompt
select count(*) "Shared Server Processes"
from v$shared_server
where status !='QUIT'
/
prompt
select name,to_number(value) "MTS_MAX_SERVERS"
        from v$parameter
        where name='mts_max_servers'
/
prompt
column value heading "Requests" format 999,999,999
column name noprint
prompt ########################################################################
prompt Redo Log Buffer Space Contention
prompt
prompt Goal:			Near 0
prompt
prompt Corrective Action:	Increase size of redo log buffer
prompt
select name,value
	from v$sysstat
	where name='redo log space requests'
/
column name print
prompt
column value heading "Number" format 999,999,999
column name heading "Type" format a15
prompt ########################################################################
prompt Sort Memory Contention
prompt
prompt Goal:			Mimimize sorts to disk
prompt
prompt Corrective Action:	Increase sort-area-size
prompt
select name,value
	from v$sysstat
	where name in ('sorts (memory)','sorts (disk)')
/
prompt
column class heading "Class" format a20
column count heading "Counts" format 999,999,999
column gets heading "Total Gets" format 999,999,999,999
prompt ########################################################################
prompt Free List Contention
prompt
prompt Goal:			Number of counts less that 1% of total gets
prompt
prompt Corrective Action:	Increase free lists (per table)
prompt
select sum(value) gets
	from v$sysstat
	where name in ('db block gets','consistent gets')
/
prompt
select class,count
	from v$waitstat
	where class='free list'
/
prompt
column event format a30
column avg_wait format 999999999.99
column avg_timeouts format 999999999.99
column avg_avgwait format 999999999.99
prompt ########################################################################
prompt Session Event Contention
prompt
prompt Goal:                    Average wait = 0 
prompt
select substr(event,1,30) event,
       avg(total_waits) avg_wait, avg(total_timeouts) avg_timeouts,
       avg(average_wait) avg_avgwait
from   v$session_event
where  average_wait > 0
group by event
order by 4 desc
/
rem spool off
prompt ########################################################################
prompt  Fragmentación
prompt
--select substr(tablespace_name,1,25) "Tablespace Name",
--       block_id "Block",
--       blocks "Número de bloques",
--       substr(segment_name,1,25) "Segment_Name"
--  from sys.dba_extents
--  order by block_id
--/  
prompt ########################################################################
prompt Redo Log Buffer Contention
prompt
prompt Goal:                    Near = 0 
prompt
prompt Corrective Action:	Increase log_buffers
prompt
prompt
select name,value
from   v$sysstat
where name = 'redo log space requests'
/
prompt ########################################################################
prompt Llamadas recursivas
prompt
prompt Objetivo :     Lo minimo posible.Ejecutar este script cada 10/20 Min.
prompt
col value for 999,999,999,999
select name,value
  from v$sysstat 
 where name = 'recursive calls'
/
