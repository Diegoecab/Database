# oracle/admin diagnostics/sessions_waits

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `DBA_HIST_ACTIVE_SESS_HISTORY_temp.sql` | Oracle diagnostic query/report helper: DBA HIST ACTIVE SESS HISTORY temp. | `DESTRUCTIVE` | `days, gb, variables` |
| `DBA_HIST_ACTIVE_SESS_HISTORY_temp_avg_hour.sql` | Oracle diagnostic query/report helper: DBA HIST ACTIVE SESS HISTORY temp avg hour. | `DESTRUCTIVE` | `variables` |
| `SessionesConsumenMuchaPGA.sql` | Oracle diagnostic query/report helper: SessionesConsumenMuchaPGA. | `READ_ONLY` | `variables` |
| `active_session_history.sql` | Oracle diagnostic query/report helper: active session history. | `READ_ONLY` | `session_id, username, variables` |
| `active_session_history_active_sessions_count.sql` | Oracle diagnostic query/report helper: active session history active sessions count. | `READ_ONLY` | `variables` |
| `active_session_history_gc_buffer.sql` | Oracle diagnostic query/report helper: active session history gc buffer. | `READ_ONLY` | `variables` |
| `active_session_history_wait.sql` | Oracle diagnostic query/report helper: active session history wait. | `DESTRUCTIVE` | `variables` |
| `active_sessions_sql.sql` | oracle/admin diagnostics/sessions_waits helper: active sessions sql. | `READ_ONLY` | `-` |
| `audit_trail_session_ex.sql` | Oracle diagnostic query/report helper: audit trail session ex. | `READ_ONLY` | `MI, SS, end_date, start_date, variables` |
| `audit_trail_session_logon_denied_write_alertlog.sql` | Oracle diagnostic query/report helper: audit trail session logon denied write alertlog. | `CHANGES` | `mi, ss, variables` |
| `buffer_busy_waits.sql` | Oracle diagnostic query/report helper: buffer busy waits. | `READ_ONLY` | `variables` |
| `cpu_usage-per_second-per-session.sql` | Oracle diagnostic query/report helper: cpu usage per second per session. | `READ_ONLY` | `MI, days, variables` |
| `cur_sessions.sql` | oracle/admin diagnostics/sessions_waits helper: cur sessions. | `READ_ONLY` | `-` |
| `db_wait_class.sql` | Oracle diagnostic query/report helper: db wait class. | `READ_ONLY` | `variables` |
| `db_wait_class_ratio.sql` | Oracle diagnostic query/report helper: db wait class ratio. | `READ_ONLY` | `variables` |
| `db_wait_class_ratio_hour.sql` | Oracle diagnostic query/report helper: db wait class ratio hour. | `READ_ONLY` | `variables` |
| `db_wait_time_ratio.sql` | Oracle diagnostic query/report helper: db wait time ratio. | `READ_ONLY` | `MI, SS, variables` |
| `dba_audit_session.sql` | Oracle diagnostic query/report helper: dba audit session. | `READ_ONLY` | `days, os_username, returncode, username, variables` |
| `dba_audit_session_count.sql` | Oracle diagnostic query/report helper: dba audit session count. | `READ_ONLY` | `ACTION_NAME, variables` |
| `dba_audit_session_x.sql` | Oracle diagnostic query/report helper: dba audit session x. | `READ_ONLY` | `days, usuario, variables` |
| `dba_datapump_sessions_longops.sql` | Oracle diagnostic query/report helper: dba datapump sessions longops. | `READ_ONLY` | `variables` |
| `dba_hist_active_sess_history.sql` | Oracle diagnostic query/report helper: dba hist active sess history. | `READ_ONLY` | `variables` |
| `dba_hist_active_sess_history_pga.sql` | Oracle diagnostic query/report helper: dba hist active sess history pga. | `DESTRUCTIVE` | `days, min_pga, sqlid, variables` |
| `dba_hist_active_sess_history_pga2.sql` | Oracle diagnostic query/report helper: dba hist active sess history pga2. | `READ_ONLY` | `MI, SS, variables` |
| `dba_hist_waitstat.sql` | oracle/admin diagnostics/sessions_waits helper: dba hist waitstat. | `READ_ONLY` | `days, wait_class` |
| `dbms_metadata.session_transform.sql` | Oracle diagnostic query/report helper: dbms metadata session transform. | `CHANGES` | `variables` |
| `exa.io.wait_event.sql` | Oracle diagnostic query/report helper: exa io wait event. | `READ_ONLY` | `variables` |
| `itl_waits.sql` | Oracle diagnostic query/report helper: itl waits. | `READ_ONLY` | `variables` |
| `kill_session_batch.sql` | Oracle diagnostic query/report helper: kill session batch. | `DESTRUCTIVE` | `username, variables` |
| `kill_session_batch2.sql` | Oracle diagnostic query/report helper: kill session batch2. | `DESTRUCTIVE` | `variables` |
| `kill_session_sqlid.sql` | Oracle diagnostic query/report helper: kill session sqlid. | `DESTRUCTIVE` | `sqlid, variables` |
| `kill_session_sqlid_sqltext_all_dbs.sh` | Oracle diagnostic query/report helper: kill session sqlid sqltext all dbs. | `DESTRUCTIVE` | `ORACLE_HOME, ORACLE_SID, ORAENV_ASK, PATH, arg8, mi, ss` |
| `library_cache_pin_wait.sql` | Oracle diagnostic query/report helper: library cache pin wait. | `READ_ONLY` | `variables` |
| `msession.sql` | Oracle diagnostic query/report helper: msession. | `READ_ONLY` | `variables` |
| `open_cursor_sess.sql` | Oracle diagnostic query/report helper: open cursor sess. | `READ_ONLY` | `variables` |
| `pga_by_session.sql` | Oracle diagnostic query/report helper: pga by session. | `READ_ONLY` | `variables` |
| `porcentaje_uso_cached_session.sql` | oracle/admin diagnostics/sessions_waits helper: porcentaje uso cached session. | `READ_ONLY` | `-` |
| `ps_mon_sessions.sql` | Oracle diagnostic query/report helper: ps mon sessions. | `CHANGES` | `bdate, edate, mi, spool_name, variables` |
| `px_session.sql` | Oracle diagnostic query/report helper: px session. | `READ_ONLY` | `variables` |
| `sess.sql` | Oracle diagnostic query/report helper: sess. | `READ_ONLY` | `variables` |
| `sess_io.sql` | Oracle diagnostic query/report helper: sess io. | `READ_ONLY` | `variables` |
| `sess_optimizer_env.sql` | Oracle diagnostic query/report helper: sess optimizer env. | `READ_ONLY` | `sid, variables` |
| `sess_time_model.sql` | Oracle diagnostic query/report helper: sess time model. | `READ_ONLY` | `sid, username, variables` |
| `sess_time_model_cpu.sql` | Oracle diagnostic query/report helper: sess time model cpu. | `DESTRUCTIVE` | `variables` |
| `sess_time_model_cpu_vview.sql` | Oracle diagnostic query/report helper: v$sess time model cpu (1). | `DESTRUCTIVE` | `variables` |
| `sess_time_model_io.sql` | Oracle diagnostic query/report helper: sess time model io. | `DESTRUCTIVE` | `variables` |
| `sess_time_model_io_vview.sql` | Oracle diagnostic query/report helper: v$sess time model io (1). | `DESTRUCTIVE` | `variables` |
| `sess_time_model_vview.sql` | Oracle diagnostic query/report helper: v$sess time model (1). | `READ_ONLY` | `variables` |
| `session.sql` | oracle/admin diagnostics/sessions_waits helper: session. | `DESTRUCTIVE` | `MI, SS, sid, status, username` |
| `session_connect_info.sql` | Oracle diagnostic query/report helper: session connect info. | `READ_ONLY` | `variables` |
| `session_cpu.sql` | Oracle diagnostic query/report helper: session cpu. | `READ_ONLY` | `variables` |
| `session_event.sql` | Oracle diagnostic query/report helper: session event. | `READ_ONLY` | `SID, variables` |
| `session_hash.sql` | Oracle diagnostic query/report helper: session hash. | `READ_ONLY` | `HASH, variables` |
| `session_longops.sql` | Oracle diagnostic query/report helper: session longops. | `READ_ONLY` | `sid, variables` |
| `session_sid.sql` | Oracle diagnostic query/report helper: session sid. | `READ_ONLY` | `SID, variables` |
| `session_sid_pid_process.sql` | Oracle diagnostic query/report helper: session sid pid process. | `DESTRUCTIVE` | `serial, sid, variables` |
| `session_trace_file.sql` | oracle/admin diagnostics/sessions_waits helper: session trace file. | `READ_ONLY` | `-` |
| `session_wait.sql` | Oracle diagnostic query/report helper: session wait. | `DESTRUCTIVE` | `variables` |
| `session_wait_class.sql` | Oracle diagnostic query/report helper: session wait class. | `READ_ONLY` | `sid, variables` |
| `session_wait_history.sql` | Oracle diagnostic query/report helper: session wait history. | `READ_ONLY` | `event, variables` |
| `session_wait_latch.sql` | Oracle diagnostic query/report helper: session wait latch. | `DESTRUCTIVE` | `variables` |
| `session_wait_sess.sql` | Oracle diagnostic query/report helper: session wait sess. | `READ_ONLY` | `variables` |
| `session_wait_vview.sql` | Oracle diagnostic query/report helper: v$session wait (1). | `READ_ONLY` | `variables` |
| `sessions.sql` | Oracle diagnostic query/report helper: sessions (2). | `READ_ONLY` | `variables` |
| `sessions1.sql` | Oracle diagnostic query/report helper: sessions1. | `READ_ONLY` | `variables` |
| `sessions_db.sql` | oracle/admin diagnostics/sessions_waits helper: sessions db. | `DESTRUCTIVE` | `-` |
| `sessions_db_active.sql` | oracle/admin diagnostics/sessions_waits helper: sessions db active. | `DESTRUCTIVE` | `MI, SS` |
| `sessions_db_active_hist.sql` | Oracle diagnostic query/report helper: sessions db active hist. | `DESTRUCTIVE` | `HH24, MI, variables` |
| `sessions_db_by_users.sql` | Oracle diagnostic query/report helper: sessions db by users. | `DESTRUCTIVE` | `variables` |
| `sessions_db_x.sql` | oracle/admin diagnostics/sessions_waits helper: sessions db x. | `READ_ONLY` | `username` |
| `sessions_degree.sql` | Oracle diagnostic query/report helper: sessions degree. | `READ_ONLY` | `variables` |
| `sessions_jobs.sql` | Oracle diagnostic query/report helper: sessions jobs. | `READ_ONLY` | `variables` |
| `sessions_locks.sql` | Oracle diagnostic query/report helper: sessions locks. | `DESTRUCTIVE` | `variables` |
| `sessions_locks_history.sql` | Oracle diagnostic query/report helper: sessions locks history. | `DESTRUCTIVE` | `MI, SS, days, variables` |
| `sesstat.sql` | oracle/admin diagnostics/sessions_waits helper: sesstat. | `READ_ONLY` | `-` |
| `sesstat_CPU.sql` | oracle/admin diagnostics/sessions_waits helper: sesstat CPU. | `READ_ONLY` | `-` |
| `sesstat_dblink.sql` | oracle/admin diagnostics/sessions_waits helper: sesstat dblink. | `READ_ONLY` | `-` |
| `sesstat_parse.sql` | Oracle diagnostic query/report helper: sesstat parse. | `READ_ONLY` | `variables` |
| `sqlsession.sql` | Oracle diagnostic query/report helper: sqlsession. | `READ_ONLY` | `variables` |
| `sysmetric_history_db_wait_time_ratio.sql` | Oracle diagnostic query/report helper: sysmetric history db wait time ratio. | `READ_ONLY` | `_Average, _standard_deviation, mi, variables` |
| `top_activity_wait.sql` | Script To Get Cpu Usage And Wait Event Information In Oracle Database | `READ_ONLY` | `MI` |
| `top_activity_wait_h.sql` | Script To Get Cpu Usage And Wait Event Information In Oracle Database | `READ_ONLY` | `MI` |
| `top_activity_wait_h_hour.sql` | Script To Get Cpu Usage And Wait Event Information In Oracle Database | `READ_ONLY` | `-` |
| `top_activity_wait_hour.sql` | Script To Get Cpu Usage And Wait Event Information In Oracle Database | `READ_ONLY` | `-` |
| `top_activity_wait_js.sql` | Script To Get Cpu Usage And Wait Event Information In Oracle Database | `READ_ONLY` | `MI` |
| `top_activity_wait_secs.sql` | Script To Get Cpu Usage And Wait Event Information In Oracle Database | `READ_ONLY` | `SAMPLE_TIME` |
| `top_sessions.sql` | Oracle diagnostic query/report helper: top sessions (1). | `CHANGES` | `mi, ss, variables` |
| `top_sessions_n.sql` | Oracle diagnostic query/report helper: top sessions n. | `CHANGES` | `mi, ss, variables` |
| `trace_de_session.sql` | Oracle diagnostic query/report helper: trace de session. | `CHANGES` | `variables` |
| `undo_sessions.sql` | Oracle diagnostic query/report helper: undo sessions. | `READ_ONLY` | `variables` |
| `uso_temp_session.sql` | oracle/admin diagnostics/sessions_waits helper: uso temp session. | `READ_ONLY` | `-` |
| `wait_events.sql` | Oracle diagnostic query/report helper: wait events. | `READ_ONLY` | `variables` |
| `wait_events_1.sql` | Oracle diagnostic query/report helper: wait events 1. | `READ_ONLY` | `variables` |
| `wait_sessions.sql` | Oracle diagnostic query/report helper: wait sessions. | `READ_ONLY` | `variables` |
| `wait_time_detail_10g.sql` | Oracle diagnostic query/report helper: wait time detail 10g. | `READ_ONLY` | `mi, variables` |
