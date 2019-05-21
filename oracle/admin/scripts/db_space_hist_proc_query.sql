--db_space_hist_proc_query.sql
/*
CREATE OR REPLACE procedure SYS.db_space_hist_proc as
begin
   -- Delete old records...
   delete from db_space_hist where timestamp > SYSDATE + 364;
   -- Insert current utilization values...
   insert into db_space_hist
	select sysdate, total_space,
	       total_space-nvl(free_space,0) used_space,
	       nvl(free_space,0) free_space,
	       ((total_space - nvl(free_space,0)) / total_space)*100 pct_inuse,
	       num_db_files
	from ( select sum(bytes)/1024/1024 free_space
	       from   sys.DBA_FREE_SPACE ) FREE,
	     ( select sum(bytes)/1024/1024 total_space,
	              count(*) num_db_files
	       from   sys.DBA_DATA_FILES) FULL;
   commit;
end;
/
*/
SELECT   TO_CHAR (TIMESTAMP, 'dd/mm/yyyy') TMSTAMP,
         ROUND (used_space / 1024, 1) used_space,
         ROUND (total_space / 1024, 1) total_space,
         ROUND (free_space / 1024, 1) free_space, pct_inuse, num_db_files
    FROM SYS.db_space_hist
ORDER BY TIMESTAMP;