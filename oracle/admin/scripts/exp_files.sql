Select servername, db_sid, to_char(book_date,'YYYYMM') PERIOD, COUNT(1)
       FROM EXP_QUEUE Q, EXP_EOM_FILE E
    WHERE Q.JOB_ID=E.JOB_ID
GROUP BY servername, db_sid, to_char(book_date,'YYYYMM')
ORDER BY 3;