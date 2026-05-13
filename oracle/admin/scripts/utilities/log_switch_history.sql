REM	Ver cantidad de switch logfile
REM ======================================================================
REM log_switch_history.sql		Version 1.1	18 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	Ejemplos
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
set pages 1000
set lines 150
set verify off
set feed off

Break on total on report 
compute avg max min of total on report
col date for a10
col "day" for a10
col 0hs for 999
col 1hs for 999
col 2hs for 999
col 3hs for 999
col 4hs for 999
col 5hs for 999
col 6hs for 999
col 7hs for 999
col 8hs for 999
col 9hs for 999
col 10hs for 999
col 11hs for 999
col 12hs for 999
col 13hs for 999
col 14hs for 999
col 15hs for 999
col 16hs for 999
col 17hs for 999
col 18hs for 999
col 19hs for 999
col 20hs for 999
col 21hs for 999
col 22hs for 999
col 23hs for 999
col total for 99999
alter session set nls_date_format='dd/mm/yyyy';
select   trunc (first_time) "date", to_char (first_time, 'dy') "day",
         count (1) "total",
         sum (decode (to_char (first_time, 'hh24'), '00', 1, 0)) "0hs",
         sum (decode (to_char (first_time, 'hh24'), '01', 1, 0)) "1hs",
         sum (decode (to_char (first_time, 'hh24'), '02', 1, 0)) "2hs",
         sum (decode (to_char (first_time, 'hh24'), '03', 1, 0)) "3hs",
         sum (decode (to_char (first_time, 'hh24'), '04', 1, 0)) "4hs",
         sum (decode (to_char (first_time, 'hh24'), '05', 1, 0)) "5hs",
         sum (decode (to_char (first_time, 'hh24'), '06', 1, 0)) "6hs",
         sum (decode (to_char (first_time, 'hh24'), '07', 1, 0)) "7hs",
         sum (decode (to_char (first_time, 'hh24'), '08', 1, 0)) "8hs",
         sum (decode (to_char (first_time, 'hh24'), '09', 1, 0)) "9hs",
         sum (decode (to_char (first_time, 'hh24'), '10', 1, 0)) "10hs",
         sum (decode (to_char (first_time, 'hh24'), '11', 1, 0)) "11hs",
         sum (decode (to_char (first_time, 'hh24'), '12', 1, 0)) "12hs",
         sum (decode (to_char (first_time, 'hh24'), '13', 1, 0)) "13hs",
         sum (decode (to_char (first_time, 'hh24'), '14', 1, 0)) "14hs",
         sum (decode (to_char (first_time, 'hh24'), '15', 1, 0)) "15hs",
         sum (decode (to_char (first_time, 'hh24'), '16', 1, 0)) "16hs",
         sum (decode (to_char (first_time, 'hh24'), '17', 1, 0)) "17hs",
         sum (decode (to_char (first_time, 'hh24'), '18', 1, 0)) "18hs",
         sum (decode (to_char (first_time, 'hh24'), '19', 1, 0)) "19hs",
         sum (decode (to_char (first_time, 'hh24'), '20', 1, 0)) "20hs",
         sum (decode (to_char (first_time, 'hh24'), '21', 1, 0)) "21hs",
         sum (decode (to_char (first_time, 'hh24'), '22', 1, 0)) "22hs",
         sum (decode (to_char (first_time, 'hh24'), '23', 1, 0)) "23hs"
    from v$log_history
	where first_time > trunc(sysdate) - nvl(to_char('&days'),50000)
group by trunc (first_time), to_char (first_time, 'dy')
order by 1
/


