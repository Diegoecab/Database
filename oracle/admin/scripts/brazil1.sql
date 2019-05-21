col category_group for a70
col diff for 9999

 select x.*,
        (x.elap_mins - lag(elap_mins) over (partition by category_group order by  start_date)) diff  
   from (
SELECT   bps.book_date "BOOK_DATE"
	   , bps.period_process "PERIOD"
	   , pcm.category_group "CATEGORY_GROUP"
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
	 AND bps.book_date >=trunc(sysdate)-41
	 AND bps.period_process in ('P2')
	 AND pcm.category_group = 'Financial Processes High Priority (Smart II / PRR impact)'
--	 AND to_char(bps.book_date,'W') = 1
GROUP BY bps.book_date
	   , bps.period_process
	   , pcm.category_group
ORDER BY bps.book_date desc
        ) x        
 ORDER BY book_date
/