select n_tup_upd + n_tup_ins + n_tup_del as n_changes from pg_stat_user_tables  where relname = 'YOUR_TABLE';
