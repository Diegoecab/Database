--v$session_wait.sql
set pagesize 100
col wait_class heading "Clase|Espera" for a15
col program heading "Programa" for a40
col osuser heading "Usuario|SO" for a13
col min heading "Tiempo|en|Minutos" for 999
col command_type heading "Tipo|de|Comando" for a13
col username heading "Usuario" for a15
col event heading "Event" for a30
col total_waits heading "Total|Waits"
col min_act heading "Sess|Act|Min"
col sid for 999999
col module for a10
set linesize 180
set feedback off
SELECT DISTINCT DECODE (command_type,
                        3, 'SELECT',
                        2, 'INSERT',
                        6, 'UPDATE',
                        7, 'DELETE',
                        26, 'LOCK_TABLE',
                        35, 'ALTER DATABASE',
                        42, 'ALTER SESSION',
                        44, 'COMMIT',
                        45, 'ROLLBACK',
                        46, 'SAVEPOINT',
                        47, 'BEGIN/DECLARE',
						189, 'MERGE'
                       ) command_type, c.state, c.seconds_in_wait,
                c.SID, b.username, c.wait_class, c.event, h.sql_id,
                c.seconds_in_wait / 60 MIN, ROUND (last_call_et / 60) min_act
           FROM SYS.v_$session b, SYS.v_$session_wait c, SYS.v_$sql h
          WHERE c.SID = b.SID
            AND b.username IS NOT NULL
            AND c.wait_class != 'Idle'
            AND h.address =
                   (DECODE (RAWTOHEX (b.sql_address),
                            '00', b.prev_sql_addr,
                            b.sql_address
                           )
                   )
       ORDER BY 7
/

prompt
prompt v$session_wait_class: Waits in session 
prompt v$session_wait_history: History waits in sessions
prompt v$session_wait: Current sessions waits
prompt