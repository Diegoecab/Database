CREATE extension pageinspect;

CREATE extension pg_freespacemap;
CREATE TABLE mytest(id int);
SELECT                       
       lp,                                  
       t_ctid AS ctid,
       t_xmin AS xmin,
       t_xmax AS xmax,
       (t_infomask & 128)::boolean AS xmax_is_lock,
       (t_infomask & 1024)::boolean AS xmax_committed,
       (t_infomask & 2048)::boolean AS xmax_rolled_back,
       (t_infomask & 4096)::boolean AS xmax_multixact,
       t_attrs[1] AS p_id,
       t_attrs[2] AS p_val
       FROM heap_page_item_attrs(
        get_raw_page('mytest', 0),                     
        'mytest'                                      
     ); 
INSERT INTO mytest (id) VALUES (100);

SELECT * FROM pg_freespace('mytest');
UPDATE mytest SET id=10;

SELECT                       
       lp,                                  
       t_ctid AS ctid,
       t_xmin AS xmin,
       t_xmax AS xmax,
       (t_infomask & 128)::boolean AS xmax_is_lock,
       (t_infomask & 1024)::boolean AS xmax_committed,
       (t_infomask & 2048)::boolean AS xmax_rolled_back,
       (t_infomask & 4096)::boolean AS xmax_multixact,
       t_attrs[1] AS p_id,
       t_attrs[2] AS p_val
       FROM heap_page_item_attrs(
        get_raw_page('mytest', 0),                     
        'mytest'                                      
     ); 
	 
SELECT * FROM pg_freespace('mytest');


SELECT relname, n_tup_upd, n_live_tup, n_dead_tup from pg_stat_user_tables;

UPDATE mytest SET id=300;

SELECT relname, n_tup_upd, n_live_tup, n_dead_tup from pg_stat_user_tables;

SELECT                       
       lp,                                  
       t_ctid AS ctid,
       t_xmin AS xmin,
       t_xmax AS xmax,
       (t_infomask & 128)::boolean AS xmax_is_lock,
       (t_infomask & 1024)::boolean AS xmax_committed,
       (t_infomask & 2048)::boolean AS xmax_rolled_back,
       (t_infomask & 4096)::boolean AS xmax_multixact,
       t_attrs[1] AS p_id,
       t_attrs[2] AS p_val
       FROM heap_page_item_attrs(
        get_raw_page('mytest', 0),                     
        'mytest'                                      
     ); 


VACUUM FULL ANALYZE; 

SELECT relname, n_tup_upd, n_live_tup, n_dead_tup from pg_stat_user_tables;


SELECT                       
       lp,                                  
       t_ctid AS ctid,
       t_xmin AS xmin,
       t_xmax AS xmax,
       (t_infomask & 128)::boolean AS xmax_is_lock,
       (t_infomask & 1024)::boolean AS xmax_committed,
       (t_infomask & 2048)::boolean AS xmax_rolled_back,
       (t_infomask & 4096)::boolean AS xmax_multixact,
       t_attrs[1] AS p_id,
       t_attrs[2] AS p_val
       FROM heap_page_item_attrs(
        get_raw_page('mytest', 0),                     
        'mytest'                                      
     ); 


--Tables Last Vacuumed
SELECT
schemaname, relname,last_vacuum, cast(last_autovacuum as date), cast(last_analyze as date), cast(last_autoanalyze as date),
pg_size_pretty(pg_total_relation_size(table_name)) as table_total_size
from pg_stat_user_tables a, information_schema.tables b where a.relname=b.table_name ORDER BY pg_total_relation_size(table_name) DESC limit 10;

