# postgres storage

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `create_big_table.sql` | postgres storage helper: create big table. | `DESTRUCTIVE` | `text` |
| `create_big_table2.sql` | postgres storage helper: create big table2. | `CHANGES` | `text` |
| `create_big_table3.sql` | postgres storage helper: create big table3. | `DESTRUCTIVE` | `text` |
| `create_big_table4.sql` | postgres storage helper: create big table4. | `DESTRUCTIVE` | `text` |
| `create_big_table6.sql` | postgres storage helper: create big table6. | `DESTRUCTIVE` | `text` |
| `create_large_table.sql` | postgres storage helper: create large table. | `CHANGES` | `text` |
| `create_part_table.sql` | postgres storage helper: create part table. | `DESTRUCTIVE` | `regclass` |
| `db_size.sql` | postgres storage helper: db size. | `READ_ONLY` | `-` |
| `describe_table.sql` | postgres storage helper: describe table. | `READ_ONLY` | `-` |
| `last_modified_date_table.sql` | postgres storage helper: last modified date table. | `READ_ONLY` | `-` |
| `lob_columns.sql` | postgres storage helper: lob columns. | `READ_ONLY` | `-` |
| `lob_size.sql` | postgres storage helper: lob size. | `READ_ONLY` | `-` |
| `partition_segments_boundaries_dms.sql` | postgres storage helper: partition segments boundaries dms. | `READ_ONLY` | `-` |
| `partitioned_table_create.sql` | postgres storage helper: partitioned table create. | `CHANGES` | `-` |
| `partitions_by_table.sql` | postgres storage helper: partitions by table. | `READ_ONLY` | `-` |
| `pg_freespace.sql` | postgres storage helper: pg freespace. | `READ_ONLY` | `-` |
| `pg_size_pretty.sql` | postgres storage helper: pg size pretty. | `READ_ONLY` | `tabletest` |
| `pg_tablespace.sql` | postgres storage helper: pg tablespace. | `READ_ONLY` | `-` |
| `pg_tablespace_size.sql` | postgres storage helper: pg tablespace size. | `READ_ONLY` | `-` |
| `rds_temp_tablespace_usage.sql` | postgres storage helper: rds temp tablespace usage. | `READ_ONLY` | `-` |
| `size_by_schema.sql` | postgres storage helper: size by schema. | `READ_ONLY` | `bigint` |
| `table_size.sql` | postgres storage helper: table size. | `READ_ONLY` | `-` |
| `test_loadtable.sql` | postgres storage helper: test loadtable. | `CHANGES` | `-` |
