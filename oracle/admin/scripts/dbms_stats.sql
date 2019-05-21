begin
dbms_stats.gather_table_stats
(ownname => 'GESTAR', 
tabname => 'SYS_FIELDS_56' , 
estimate_percent => 100,
method_opt => 'for all indexed columns size auto',
cascade=> true);
end;
/


BEGIN
   DBMS_STATS.gather_table_stats
                          (ownname               => 'AUDITAR',
                           tabname               => 'VENCIMIENTOS',
                           estimate_percent      => DBMS_STATS.auto_sample_size,
                           method_opt            => 'for all indexed columns size auto',
                           CASCADE               => TRUE
                          );
END;
/