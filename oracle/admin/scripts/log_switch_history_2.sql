alter session set nls_language=spanish;

select a.*,round((total*bytes)/1024/1024/1024,1) "total gb" from (
select   trunc (first_time) "date", to_char (first_time, 'dy') "day",
         count (1) total,
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
           where first_time > to_date('01/04/2010','dd/mm/yyyy')
group by trunc (first_time), to_char (first_time, 'dy')
order by 1
) a , v$log b;


