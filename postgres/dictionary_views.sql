pg_class
--catalogs tables and most everything else that has columns or is otherwise similar to a table
pg_stat_activity
--one row per server process, showing information related to the current activity of that process.
pg_stat_statements
--The statistics gathered by the module are made available via a view named pg_stat_statements. This view contains one row for each distinct combination of database ID, user ID, query ID and whether it's a top-level statement or not (up to the maximum number of distinct statements that the module can track)
pg_settings
