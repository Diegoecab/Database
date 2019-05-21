--estad_v$sess_time_model.sql
col wait_class heading "Clase|Espera" for a8
col program heading "Programa" for a40
col osuser heading "Usuario|SO" for a13
col min heading "Tiempo|en|Minutos" for 99
col command_type heading "Tipo|de|Comando"
col username heading "Usuario"
col total_waits heading "Total|Waits"
set linesize 180
set feedback off
select  a.sid,
        b.username,
        a.wait_class,
        a.total_waits,
        round((a.time_waited / 100)/60,2) min
from    sys.v_$session_wait_class a,
        sys.v_$session b
where   b.sid = a.sid and
        b.username is not null and
        a.wait_class != 'Idle'
order by 5;