\d pg_settings;
select name, setting, unit from pg_settings where name like '%plan%';