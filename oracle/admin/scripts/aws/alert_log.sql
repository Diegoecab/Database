select message_text from ALERTLOG where rownum<=10 order by indx;
SELECT text FROM table(rdsadmin.rds_file_util.read_text_file('BDUMP','alert_ORCL.log')) where rownum<=10;

