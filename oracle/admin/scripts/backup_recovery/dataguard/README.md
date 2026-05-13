# oracle/admin backup_recovery/dataguard

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `active_dataguard.sql` | Oracle Data Guard administration helper: active dataguard. | `DESTRUCTIVE` | `variables` |
| `archive_dest.sql` | Oracle Data Guard administration helper: archive dest. | `READ_ONLY` | `variables` |
| `archive_dest_status.sql` | Oracle Data Guard administration helper: archive dest status(1). | `READ_ONLY` | `variables` |
| `archived_log.sql` | Oracle Data Guard administration helper: archived log. | `READ_ONLY` | `variables` |
| `archived_log_gap.sql` | Oracle Data Guard administration helper: archived log gap. | `READ_ONLY` | `variables` |
| `archived_log_scn.sql` | Oracle Data Guard administration helper: archived log scn. | `READ_ONLY` | `variables` |
| `archived_log_sequence_scn.sql` | Oracle Data Guard administration helper: archived log sequence scn. | `READ_ONLY` | `sequence, variables` |
| `archivelog_cascade.sql` | Oracle Data Guard administration helper: archivelog cascade(1). | `CHANGES` | `COMPRESSION, DB_UNIQUE_NAME, DG_CONFIG, SERVICE, VALID_FOR, variables` |
| `clear_logfile_standby_dataguard.sql` | Oracle Data Guard administration helper: clear logfile standby dataguard. | `CHANGES` | `TYPE, variables` |
| `control_dataguard.sql` | Oracle Data Guard administration helper: control dataguard. | `READ_ONLY` | `variables` |
| `dataguard_archivelogs_sent_duplicates.sql` | Oracle Data Guard administration helper: dataguard archivelogs sent duplicates. | `READ_ONLY` | `MI, SS, variables` |
| `dataguard_db_role.sql` | Oracle Data Guard administration helper: dataguard db role. | `READ_ONLY` | `variables` |
| `dataguard_healthcheck_primary.sql` | Oracle Data Guard administration helper: dataguard healthcheck primary. | `CHANGES` | `MI, SS, TARGET, dbname, tstamp, variables` |
| `dataguard_healthcheck_standby.sql` | Oracle Data Guard administration helper: dataguard healthcheck standby. | `DESTRUCTIVE` | `dbname, tstamp, variables` |
| `dataguard_redo_per_second_mbps_bandwidth.sql` | Oracle Data Guard administration helper: dataguard redo per second mbps bandwidth. | `READ_ONLY` | `MI, SS, hour, variables` |
| `dataguard_stats.sql` | Oracle Data Guard administration helper: dataguard stats. | `READ_ONLY` | `variables` |
| `dataguard_status.sql` | Oracle Data Guard administration helper: dataguard status. | `CHANGES` | `MI, SS, variables` |
| `dataguard_status_lag.sql` | Oracle Data Guard administration helper: dataguard status lag. | `READ_ONLY` | `variables` |
| `dataguard_stby_received_applied.sql` | Oracle Data Guard administration helper: dataguard stby received applied. | `READ_ONLY` | `variables` |
| `dba_registered_archived_log.sql` | Oracle Data Guard administration helper: dba registered archived log. | `CHANGES` | `mi, ss, variables` |
| `delete_archivelog.sh` | Oracle Data Guard administration helper: delete archivelog. | `DESTRUCTIVE` | `BASEDIR, DEFAULT_OUTPUT_LOG, FREQ, LOG, ORACLE_SID, ORAENV_ASK, PATH, PROGRAM, SCRIPT_NAME, arg1, arg8` |
| `diff_archivelogs_gap.sql` | Oracle Data Guard administration helper: diff archivelogs gap. | `READ_ONLY` | `variables` |
| `managed_standby.sql` | Oracle Data Guard administration helper: managed standby. | `READ_ONLY` | `variables` |
| `prueba_StandBy.sh` | Oracle Data Guard administration helper: prueba StandBy. | `DESTRUCTIVE` | `ORACLE_SID` |
| `reco_log_standby_past_gap.12.1.sh` | Oracle Data Guard administration helper: reco log standby past gap 12 1(1). | `READ_ONLY` | `MI, SS` |
| `reco_log_standby_past_gap.12.2.sh` | Oracle Data Guard administration helper: reco log standby past gap 12 2(1). | `READ_ONLY` | `-` |
| `recreate_standby_logfiles.sql` | Oracle Data Guard administration helper: recreate standby logfiles. | `DESTRUCTIVE` | `variables` |
| `remove_applied_archivelog.sh` | This script will remove the applied archivelogs into a standby databases. | `DESTRUCTIVE` | `LAST_DAYS, LAST_DAYS_QUERY, LD_LIBRARY_PATH, NOTIF_ERROR, ORACLE_HOME, ORACLE_SID, SEQ, arg1, arg2` |
| `snapshot_standby_database_flashback.sql` | Oracle Data Guard administration helper: snapshot standby database flashback. | `DESTRUCTIVE` | `variables` |
| `standby_clear_logfiles.sql` | Oracle Data Guard administration helper: standby clear logfiles. | `CHANGES` | `TYPE, variables` |
| `standby_log.sql` | Oracle Data Guard administration helper: standby log. | `READ_ONLY` | `variables` |
| `standby_missing_datafiles_restore.sql` | Oracle Data Guard administration helper: standby missing datafiles restore. | `DESTRUCTIVE` | `variables` |
