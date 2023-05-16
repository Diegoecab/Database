select name, setting, source, context, min_val, max_val, boot_val from pg_settings where name like 'autovacuum%';
