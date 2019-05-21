REM	Script para ver las sesiones actuales en la base de datos
REM ======================================================================
REM sessions_db.sql		Version 1.1	29 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	
REM Dependencias:
REM	
REM
REM Notas:
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set pagesize 10000
col machine for a30
col program for a80
col sid for 9999
col last_act for 9999
col module for a80
col username for a21


set lines 400
set verify off

break on report
compute sum of num_user_sess active# inactive# on report
--compute sum of num_user_sess count_a count_i on report


select s.username,machine,module,action,s.osuser,sid,s.serial#,status,round(last_call_et/60) min_inac, s.program, 
(SELECT   DISTINCT sql_id
              FROM   v$sql
             WHERE   address =
                        (DECODE (RAWTOHEX (s.sql_address),
                                 '00', s.prev_sql_addr,
                                 s.sql_address)))
              sql_id, to_char(logon_time,'DD/MM HH24:MI:SS') logon_time
  , floor(last_call_et / 60) last_act,p.spid from v$session s ,v$process p where s.paddr = p.addr
 and s.username is not null and status = 'ACTIVE' 
 and s.username like upper('%&username%') order by 1,2,3,7;