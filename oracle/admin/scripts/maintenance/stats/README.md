# oracle/admin maintenance/stats

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `AnalyzeNonShared.sql` | Oracle database maintenance helper: AnalyzeNonShared. | `READ_ONLY` | `variables` |
| `analyzed_tables.sql` | Oracle database maintenance helper: analyzed tables. | `READ_ONLY` | `variables` |
| `dba_tables_last_analyzed.sql` | Oracle database maintenance helper: dba tables last analyzed. | `READ_ONLY` | `variables` |
| `exec_stats_stale.sh` | Oracle database maintenance helper: exec stats stale. | `CHANGES` | `ORACLE_HOME, ORACLE_SID, ORAENV_ASK, PATH, STALE_STATS, arg1, arg2` |
| `select_AnalyzeTableChainedRows.sql` | Oracle database maintenance helper: select AnalyzeTableChainedRows. | `CHANGES` | `variables` |
