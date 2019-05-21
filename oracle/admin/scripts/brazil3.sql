set pagesize 30
col category_name for a30
col PROCEDURE_NAME for a55

select * from 
 (
 select x.*,
        lag(elap_mins) over (partition by category_name, procedure_name order by  start_date) prev,
        (x.elap_mins - lag(elap_mins) over (partition by category_name, procedure_name order by  start_date)) diff  
   from (
          SELECT   bps.book_date       "BOOK_DATE"                                                           
                 , bps.period_process  "PERIOD"
                 , pcm.category_name   "CATEGORY_NAME"                                         
                 , bps.procedure_name  "PROCEDURE_NAME"                                 
                 , to_char(min(bps.start_date),'DD-MON-YY HH24:MI') "START_DATE"
                 , to_char(max(bps.ended_date),'DD-MON-YY HH24:MI') "END_DATE"
                 , round((max(bps.ended_date)-min(bps.start_date))*24*60,2) "ELAP_MINS"
              FROM brfc_sa.bi_plans_process_status bps                                 
                 , brfc_sa.plans_category_mapping pcm                                  
                 , brfc_sa.category_group_timeline tml                                 
             WHERE bps.status_flag = 'C'                                               
               AND bps.periodicity = 'D'                                               
               AND bps.category_name <> '00 BLANK'                                     
               AND bps.category_name = pcm.category_name                               
               AND bps.book_date >= sysdate-&days_ago
               AND bps.period_process in ('P2')                                        
               AND pcm.category_name like '%&CATEGORY_NAME%'                       
          GROUP BY bps.book_date                                                       
                 , bps.period_process
                 , pcm.category_name                                                  
                 , bps.procedure_name                                                  
          ORDER BY pcm.category_name, bps.procedure_name, bps.book_date desc
         ) x
 )
where round(diff)  !=0
 ORDER BY procedure_name, book_date, start_date desc;
