# oracle/admin diagnostics/ash

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `aas.sql` | Display Average active session for an specific interval time and it status based on cpu_count | `READ_ONLY` | `MI, SS` |
| `aash.sql` | Display Average active session (historyc view) for an specific interval time and it status based on cpu_count | `DESTRUCTIVE` | `HH24, MI, SS` |
| `aash_fore.sql` | Oracle diagnostic query/report helper: aash fore. | `READ_ONLY` | `variables` |
| `aash_l.sql` | Display Average active session (historyc view) for an specific interval time and it status based on cpu_count | `DESTRUCTIVE` | `HH24, MI, SS` |
| `ash_graph_waits.sql` | Oracle diagnostic query/report helper: ash graph waits. | `READ_ONLY` | `MI, SS, v_bars, v_days, v_graph, v_secs, variables` |
| `ash_hard_parse_events.sql` | Oracle diagnostic query/report helper: ash hard parse events. | `READ_ONLY` | `MI, SS, variables` |
| `ashtop_by_username.sql` | Oracle diagnostic query/report helper: ashtop by username. | `DESTRUCTIVE` | `MI, SS, variables` |
| `ashtop_peaks.sql` | Oracle diagnostic query/report helper: ashtop peaks. | `DESTRUCTIVE` | `MI, SS, variables` |
| `ashtop_sessions.sql` | Oracle diagnostic query/report helper: ashtop sessions. | `DESTRUCTIVE` | `HH24, MI, SERIAL, variables` |
| `ashtop_sql.sql` | Oracle diagnostic query/report helper: ashtop sql. | `DESTRUCTIVE` | `HH24, MI, variables` |
| `ashtoph.sql` | Oracle diagnostic query/report helper: ashtoph. | `DESTRUCTIVE` | `EVENT, HH24, MI, NAME_HASH, PROCEDURE_NAME, SS, block, file, variables` |
| `ashtoph_by_hour_username.sql` | Oracle diagnostic query/report helper: ashtoph by hour username. | `DESTRUCTIVE` | `HH24, MI, variables` |
| `ashtoph_by_username.sql` | Oracle diagnostic query/report helper: ashtoph by username. | `DESTRUCTIVE` | `HH24, MI, SS, variables` |
| `dataguard_restart.sql` | Oracle diagnostic query/report helper: dataguard restart. | `CHANGES` | `variables` |
| `dba_procedures.sql` | Oracle diagnostic query/report helper: dba procedures. | `DESTRUCTIVE` | `object_id, object_name, procedure_name, subprogram_id, variables` |
| `dictionary_fixed_obj_stats.sql` | Oracle diagnostic query/report helper: dictionary fixed obj stats. | `CHANGES` | `variables` |
| `ashrelated.sql` | Oracle diagnostic query/report helper: ashrelated. | `READ_ONLY` | `MI, SS, variables` |
| `fast_start_transactions.sql` | Oracle diagnostic query/report helper: fast start transactions. | `CHANGES` | `MI, NLS_DATE_FORMAT, SS, variables` |
| `gen_ash_global_report_text.sql` | oracle/admin diagnostics/ash helper: gen ash global report text. | `CHANGES` | `MI, _start, bdate, dbid, def_bdate, def_edate, edate, sid, sqlid` |
| `time_model_phases.sql` | Oracle diagnostic query/report helper: time model phases. | `REVIEW` | `variables` |
