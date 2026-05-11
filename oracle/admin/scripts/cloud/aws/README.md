# oracle/admin cloud/aws

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `alert_log.sql` | AWS/RDS/DMS Oracle administration helper: alert log. | `READ_ONLY` | `variables` |
| `aws.adump_xml_list.sql` | AWS/RDS/DMS Oracle administration helper: aws adump xml list. | `READ_ONLY` | `variables` |
| `aws.list_files_dir.sql` | AWS/RDS/DMS Oracle administration helper: aws list files dir. | `READ_ONLY` | `variables` |
| `aws_count_xml_os_files.sql` | AWS/RDS/DMS Oracle administration helper: aws count xml os files. | `READ_ONLY` | `variables` |
| `awsdms_support_collector_oracle.sql` | AWS/RDS/DMS Oracle administration helper: awsdms support collector oracle. | `DESTRUCTIVE` | `GRANTEE, MI, NULLABLE, OWNER, PARSING_SCHEMA_NAME, SS, TABLE_OWNER, X, Y, v_connector, v_days, v_owner, variables` |
| `create_directory.sql` | AWS/RDS/DMS Oracle administration helper: create directory. | `CHANGES` | `variables` |
| `list_file_content.sql` | AWS/RDS/DMS Oracle administration helper: list file content. | `REVIEW` | `variables` |
| `list_files_directory.sql` | AWS/RDS/DMS Oracle administration helper: list files directory. | `READ_ONLY` | `variables` |
| `partition_segments_boundaries_dms.sql` | AWS/RDS/DMS Oracle administration helper: partition segments boundaries dms. | `READ_ONLY` | `variables` |
| `rds.rds_file_util.listdir.sql` | AWS/RDS/DMS Oracle administration helper: rds rds file util listdir. | `READ_ONLY` | `variables` |
| `rds.rds_file_util.read_text_file.sql` | AWS/RDS/DMS Oracle administration helper: rds rds file util read text file. | `READ_ONLY` | `variables` |
| `modify_option_group.sh` | AWS/RDS/DMS Oracle administration helper: modify option group. | `DESTRUCTIVE` | `oracle` |
| `set_configuration.sql` | AWS/RDS/DMS Oracle administration helper: set configuration. | `CHANGES` | `variables` |
| `show_config.sql` | AWS/RDS/DMS Oracle administration helper: show config. | `CHANGES` | `variables` |
| `switch_logfile.sql` | AWS/RDS/DMS Oracle administration helper: switch logfile. | `CHANGES` | `variables` |
