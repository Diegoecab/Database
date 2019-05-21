SELECT tablespace_name, current_users "Usuarios", 
max_sort_blocks  "Mayor_consumo_bloques"
FROM v$sort_segment;

SELECT user, tablespace, blocks
FROM v$sort_usage
ORDER BY blocks;