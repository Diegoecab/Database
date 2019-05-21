SELECT sess.username "Usuario", 
            sql.sql_text "Texto_SQL", 
            sort.blocks "Bloques"
FROM v$session sess, 
            v$sqltext sql,
            v$sort_usage sort
WHERE sess.serial#   = sort.session_num
AND       sort.sqladdr  = sql.address
AND       sort.sqlhash = sql.hash_value
AND       sort.blocks    > 200;