# oracle/admin performance/sql_tuning

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `Check_stale_stats.sql` | oracle/admin performance/sql_tuning helper: Check stale stats. | `CHANGES` | `OBJLIST, OPTIONS, OWNNAME` |
| `LCObjectsStats.sql` | Oracle SQL performance and tuning helper: LCObjectsStats. | `READ_ONLY` | `variables` |
| `Runstats.sql` | oracle/admin performance/sql_tuning helper: Runstats. | `DESTRUCTIVE` | `-` |
| `SQLStats.sql` | Oracle SQL performance and tuning helper: SQLStats. | `READ_ONLY` | `variables` |
| `TrendSGAstats.sql` | Oracle SQL performance and tuning helper: TrendSGAstats. | `CHANGES` | `mi, variables` |
| `awr_plan_change_date.sql` | Oracle SQL performance and tuning helper: awr plan change date. | `READ_ONLY` | `DiffPerc, DiffSec, NDays, username, variables` |
| `awr_plan_change_sqlid.sql` | Oracle SQL performance and tuning helper: awr plan change sqlid. | `READ_ONLY` | `NDays, sql_id, variables` |
| `awr_stats_hist.sql` | Oracle SQL performance and tuning helper: awr stats hist. | `READ_ONLY` | `begin_snap, bid, dbid, eid, end_snap, max_snap_time, mi, num_days, ss, stat_filter_id, stat_filter_name, stat_input, stat_search, variables` |
| `cdb_resource_plans.sql` | Oracle SQL performance and tuning helper: cdb resource plans. | `READ_ONLY` | `variables` |
| `cdb_resource_profile_directives.sql` | Oracle SQL performance and tuning helper: cdb resource profile directives. | `READ_ONLY` | `variables` |
| `cdb_rsrc_plan.sql` | Oracle SQL performance and tuning helper: cdb rsrc plan. | `CHANGES` | `variables` |
| `check_stale_stats_schema.sql` | Oracle SQL performance and tuning helper: check stale stats schema. | `READ_ONLY` | `OBJLIST, OPTIONS, OWNER, OWNNAME, variables` |
| `citi_stats_logs.sql` | Oracle SQL performance and tuning helper: citi stats logs. | `READ_ONLY` | `runs, variables` |
| `citi_stats_schema.sql` | Oracle SQL performance and tuning helper: citi stats schema. | `CHANGES` | `MI, SS, days, schema_name, variables` |
| `coe_xfr_sql_profile.sql` | oracle/admin performance/sql_tuning helper: coe xfr sql profile. | `DESTRUCTIVE` | `other_xml, plan_hash_value, signature, sql_id, sql_text` |
| `coe_xfr_sql_profile_b470201rk883h_-1.sql` | oracle/admin performance/sql_tuning helper: coe xfr sql profile b470201rk883h 1. | `DESTRUCTIVE` | `B1, B2, B3, B4, B5` |
| `coe_xfr_sql_profile_b470201rk883h_2766146777.sql` | oracle/admin performance/sql_tuning helper: coe xfr sql profile b470201rk883h 2766146777. | `DESTRUCTIVE` | `B1, B2, B3, B4, B5, arg1, arg2, arg3, signature` |
| `coe_xfr_sql_profile_djxz0dq464m6h_-1.sql` | oracle/admin performance/sql_tuning helper: coe xfr sql profile djxz0dq464m6h 1. | `DESTRUCTIVE` | `B1, B2, B3, B4, B5` |
| `create_profile.sql` | Oracle SQL performance and tuning helper: create profile. | `CHANGES` | `variables` |
| `create_sql_profile_copy.sql` | Oracle SQL performance and tuning helper: create sql profile copy. | `CHANGES` | `category, child_no_from, child_no_to, force_matching, sql_id_from, sql_id_to, variables` |
| `dba_hist_sql_plan.sql` | Oracle SQL performance and tuning helper: dba hist sql plan. | `DESTRUCTIVE` | `variables` |
| `dba_profiles.sql` | Oracle SQL performance and tuning helper: dba profiles. | `READ_ONLY` | `profile, variables` |
| `dba_rsrc_plan_directives.sql` | Oracle SQL performance and tuning helper: dba rsrc plan directives. | `CHANGES` | `variables` |
| `dba_rsrc_plans.sql` | Oracle SQL performance and tuning helper: dba rsrc plans. | `READ_ONLY` | `variables` |
| `dba_sql_plan_baselines.sql` | Oracle SQL performance and tuning helper: dba sql plan baselines. | `READ_ONLY` | `variables` |
| `dba_sql_profiles.sql` | oracle/admin performance/sql_tuning helper: dba sql profiles. | `READ_ONLY` | `days` |
| `dba_tab_modifications_stats.sql` | Oracle SQL performance and tuning helper: dba tab modifications stats. | `CHANGES` | `diff_days, num_rows, owner, pctmod, size_mb, variables` |
| `dbms.sqltune.cancel_tuning_task.sql` | Oracle SQL performance and tuning helper: dbms sqltune cancel tuning task. | `CHANGES` | `TTASK, variables` |
| `dbms.sqltune.execute_tuning_task.sql` | Oracle SQL performance and tuning helper: dbms sqltune execute tuning task. | `CHANGES` | `TTASK, variables` |
| `dbms.sqltune.interrupt_tuning_task.sql` | Oracle SQL performance and tuning helper: dbms sqltune interrupt tuning task. | `CHANGES` | `TTASK, variables` |
| `dbms.sqltune.reset_tuning_task.sql` | Oracle SQL performance and tuning helper: dbms sqltune reset tuning task. | `CHANGES` | `TTASK, variables` |
| `dbms.sqltune.resume_tuning_task.sql` | Oracle SQL performance and tuning helper: dbms sqltune resume tuning task. | `CHANGES` | `TTASK, variables` |
| `dbms_sqltune.create_sqlset.sql` | Oracle SQL performance and tuning helper: dbms sqltune create sqlset. | `CHANGES` | `SqlSNAME, Username, bsnap, days, descr, endsnap, petime, pschema, psql, psqlid, variables` |
| `dbms_sqltune.create_tuning_task.sql` | oracle/admin performance/sql_tuning helper: dbms sqltune create tuning task. | `READ_ONLY` | `DROPJOB, EJECJOB, TSQLID, TTASKDESC, TTASKNAME, TTIME, USERNAME, bnd` |
| `dbms_sqltune.drop_sqlset.sql` | Oracle SQL performance and tuning helper: dbms sqltune drop sqlset. | `DESTRUCTIVE` | `SQLSNAME, USERN, variables` |
| `dbms_sqltune.import_sql_profile.sql` | Oracle SQL performance and tuning helper: dbms sqltune import sql profile. | `READ_ONLY` | `arg1, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg2, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg3, arg30, arg31, arg32, arg4, arg5, arg6, arg7, arg741, arg8, arg9, variables` |
| `dbms_sqltune_example.sql` | oracle/admin performance/sql_tuning helper: dbms sqltune example. | `DESTRUCTIVE` | `empno` |
| `dbms_sqltune_report_x.sql` | Oracle SQL performance and tuning helper: dbms sqltune report x. | `READ_ONLY` | `TTASK, variables` |
| `dbms_stats.report_col_usage.sql` | Oracle SQL performance and tuning helper: dbms stats report col usage. | `READ_ONLY` | `OWNER, TABLE, variables` |
| `dbms_stats.sql` | Oracle SQL performance and tuning helper: dbms stats. | `REVIEW` | `variables` |
| `dbms_stats_gather_table_stats_param.sql` | Oracle SQL performance and tuning helper: dbms stats gather table stats param. | `CHANGES` | `variables` |
| `dbms_stats_table.sql` | Oracle SQL performance and tuning helper: dbms stats table. | `CHANGES` | `cascade, estimate_percent, owner, table_name, variables` |
| `dbms_stats_toma_estadisticas.sql` | Oracle SQL performance and tuning helper: dbms stats toma estadisticas. | `CHANGES` | `variables` |
| `dbms_stats_toma_estadisticas_schedule_10g.sql` | Oracle SQL performance and tuning helper: dbms stats toma estadisticas schedule 10g. | `CHANGES` | `variables` |
| `dbs_stats_delete.sql` | Oracle SQL performance and tuning helper: dbs stats delete. | `DESTRUCTIVE` | `job_id, variables` |
| `dc_clone_sql_profile.sql` | Oracle SQL performance and tuning helper: dc clone sql profile. | `CHANGES` | `CURSOR_SHARING, variables` |
| `delete_table_stats.sql` | Oracle SQL performance and tuning helper: delete table stats. | `DESTRUCTIVE` | `variables` |
| `exadata_system_stats_gather.sql` | Oracle SQL performance and tuning helper: exadata system stats gather. | `CHANGES` | `variables` |
| `explain_plan.sql` | Oracle SQL performance and tuning helper: explain plan (1). | `READ_ONLY` | `SQL, variables` |
| `gather_table_stats.sql` | Oracle SQL performance and tuning helper: gather table stats. | `CHANGES` | `variables` |
| `get_ddl_profile.sql` | Oracle SQL performance and tuning helper: get ddl profile. | `CHANGES` | `PROFILE, variables` |
| `get_execplan.sql` | Oracle SQL performance and tuning helper: get execplan. | `READ_ONLY` | `CUST_CREDIT_LIMIT, variables` |
| `index_monitoring_usage.sql` | oracle/admin performance/sql_tuning helper: index monitoring usage. | `CHANGES` | `-` |
| `io_stats_db.sql` | oracle/admin performance/sql_tuning helper: io stats db. | `READ_ONLY` | `-` |
| `logmnr_stats.sql` | Oracle SQL performance and tuning helper: logmnr stats. | `READ_ONLY` | `variables` |
| `monitoreo_uso_temporal.sql` | Oracle SQL performance and tuning helper: monitoreo uso temporal. | `READ_ONLY` | `variables` |
| `monitoring_indexes.sql` | Oracle SQL performance and tuning helper: monitoring indexes. | `READ_ONLY` | `variables` |
| `monitoring_indexes_gowner_aeliminar.sql` | Oracle SQL performance and tuning helper: monitoring indexes gowner aeliminar. | `READ_ONLY` | `variables` |
| `monitoring_indexes_owner.sql` | Oracle SQL performance and tuning helper: monitoring indexes owner. | `READ_ONLY` | `OWNER, variables` |
| `monitoring_indexes_owner_aeliminar.sql` | Oracle SQL performance and tuning helper: monitoring indexes owner aeliminar. | `READ_ONLY` | `OWNER, variables` |
| `monitoring_indexes_x.sql` | Oracle SQL performance and tuning helper: monitoring indexes x. | `READ_ONLY` | `INDEX_NAME, OWNER, variables` |
| `nomonitoring_indexes_owner.sql` | Oracle SQL performance and tuning helper: nomonitoring indexes owner. | `READ_ONLY` | `OWNER, variables` |
| `plan_change.sql` | oracle/admin performance/sql_tuning helper: plan change. | `READ_ONLY` | `DiffPerc, DiffSec, minutes` |
| `plan_table_awr_sqlid.sql` | Oracle SQL performance and tuning helper: plan table awr sqlid. | `READ_ONLY` | `variables` |
| `plan_table_awr_sqlid_hash.sql` | Oracle SQL performance and tuning helper: plan table awr sqlid hash. | `READ_ONLY` | `PLAN_HASH, SQLID, variables` |
| `plan_table_object.sql` | Oracle SQL performance and tuning helper: plan table object. | `READ_ONLY` | `OBJECT, variables` |
| `plan_table_sqlid.sql` | Oracle SQL performance and tuning helper: plan table sqlid. | `READ_ONLY` | `variables` |
| `plan_x_sqlid.sql` | oracle/admin performance/sql_tuning helper: plan x sqlid. | `READ_ONLY` | `MI` |
| `profiles_dif_nodefault.sql` | oracle/admin performance/sql_tuning helper: profiles dif nodefault. | `READ_ONLY` | `PROFILE` |
| `publish_pending_stats.sql` | Oracle SQL performance and tuning helper: publish pending stats. | `CHANGES` | `variables` |
| `report_sql_monitor_active.sql` | Oracle SQL performance and tuning helper: report sql monitor active. | `READ_ONLY` | `spool, variables` |
| `report_sql_monitor_ash_top.sql` | Oracle SQL performance and tuning helper: report sql monitor ash top. | `READ_ONLY` | `MI, SS, variables` |
| `report_sql_monitor_sqlid.sql` | Oracle SQL performance and tuning helper: report sql monitor sqlid. | `READ_ONLY` | `variables` |
| `reset_table_stats.sql` | Oracle SQL performance and tuning helper: reset table stats. | `DESTRUCTIVE` | `mi, ss, variables` |
| `rsrc_plan.sql` | Oracle SQL performance and tuning helper: rsrc plan. | `READ_ONLY` | `variables` |
| `scheduler_stats.sql` | Oracle SQL performance and tuning helper: scheduler stats. | `READ_ONLY` | `MI, variables` |
| `set_optimizer_pending_stats_true.sql` | Oracle SQL performance and tuning helper: set optimizer pending stats true. | `CHANGES` | `variables` |
| `set_pending_stats_off.sql` | Oracle SQL performance and tuning helper: set pending stats off. | `CHANGES` | `variables` |
| `show_pending_stats.sql` | Oracle SQL performance and tuning helper: show pending stats. | `CHANGES` | `variables` |
| `show_public_stats.sql` | Oracle SQL performance and tuning helper: show public stats. | `READ_ONLY` | `variables` |
| `spb.set_my_plan.sql` | Oracle SQL performance and tuning helper: spb set my plan. | `DESTRUCTIVE` | `ENABLED, variables` |
| `spb.set_my_plan_notstored.sql` | Oracle SQL performance and tuning helper: spb set my plan notstored. | `DESTRUCTIVE` | `ENABLED, for_sqlid, new_phv, new_plan_sqlid, variables` |
| `spb_example_plan_stability.sql` | Oracle SQL performance and tuning helper: spb example plan stability. | `DESTRUCTIVE` | `CASCADE, ENABLED, FORMAT, variables` |
| `sql_monitor.sql` | Oracle SQL performance and tuning helper: sql monitor. | `READ_ONLY` | `variables` |
| `sql_plan.sql` | Oracle SQL performance and tuning helper: sql plan. | `READ_ONLY` | `variables` |
| `sql_plan_statistics_all.sql` | Oracle SQL performance and tuning helper: sql plan statistics all. | `DESTRUCTIVE` | `variables` |
| `sql_profile_hints.sql` | Oracle SQL performance and tuning helper: sql profile hints. | `READ_ONLY` | `sqlprofilename, variables` |
| `sqlplan_list.sql` | Oracle SQL performance and tuning helper: sqlplan list. | `READ_ONLY` | `variables` |
| `sqlstats_unshared.sql` | Oracle SQL performance and tuning helper: sqlstats unshared. | `READ_ONLY` | `variables` |
| `stats_autotask_check.sql` | Oracle SQL performance and tuning helper: stats autotask check. | `DESTRUCTIVE` | `WINDOW_GROUP_NAME, mi, variables` |
| `stats_dbas_package.sql` | Oracle SQL performance and tuning helper: stats dbas package. | `CHANGES` | `variables` |
| `stats_io.sql` | Oracle SQL performance and tuning helper: stats io. | `READ_ONLY` | `variables` |
| `stats_io_csv.sql` | Oracle SQL performance and tuning helper: stats io csv. | `DESTRUCTIVE` | `_connect_identifier, _date, _user, variables` |
| `stats_io_fs_mes.sql` | Oracle SQL performance and tuning helper: stats io fs mes. | `CHANGES` | `mi, ss, variables` |
| `stats_io_fs_sem.sql` | Oracle SQL performance and tuning helper: stats io fs sem. | `CHANGES` | `mi, ss, variables` |
| `stats_obj_hist.sql` | Oracle SQL performance and tuning helper: stats obj hist. | `READ_ONLY` | `partition_name, schema_name, table_name, variables` |
| `stats_rpt.sql` | Oracle SQL performance and tuning helper: stats rpt. | `CHANGES` | `MI, SS, variables` |
| `stats_rpt_schema.sql` | Oracle SQL performance and tuning helper: stats rpt schema. | `READ_ONLY` | `schema_name, variables` |
| `stats_schema_exec.sql` | Oracle SQL performance and tuning helper: stats schema exec. | `CHANGES` | `OWNER, variables` |
| `stats_schema_stale.sql` | Oracle SQL performance and tuning helper: stats schema stale. | `REVIEW` | `owner, variables` |
| `stats_schema_stale_exec.sql` | Oracle SQL performance and tuning helper: stats schema stale exec. | `CHANGES` | `OWNER, variables` |
| `stats_table_exec.sql` | Oracle SQL performance and tuning helper: stats table exec. | `CHANGES` | `OWNER, POR, TABLE, variables` |
| `tabla_stats.sql` | Oracle SQL performance and tuning helper: tabla stats. | `CHANGES` | `ESTIMATE_PERCENT, METHOD_OPT, MI, OWNNAME, SS, TABNAME, variables` |
| `tune_set_awr.sql` | Oracle SQL performance and tuning helper: tune set awr. | `CHANGES` | `name, schema, snap_begin, snap_end, variables` |
| `tune_set_awr_cron.sql` | Oracle SQL performance and tuning helper: tune set awr cron. | `CHANGES` | `name, schema, snap_begin, snap_end, variables` |
| `tune_set_capture.sql` | Oracle SQL performance and tuning helper: tune set capture. | `REVIEW` | `name, schema, variables` |
| `tune_set_create.sql` | Oracle SQL performance and tuning helper: tune set create. | `CHANGES` | `description, name, variables` |
| `tune_set_delete.sql` | Oracle SQL performance and tuning helper: tune set delete. | `DESTRUCTIVE` | `name, variables` |
| `tune_set_load.sql` | Oracle SQL performance and tuning helper: tune set load. | `CHANGES` | `name, schema, variables` |
| `tune_set_load_cron.sql` | Oracle SQL performance and tuning helper: tune set load cron. | `CHANGES` | `name, schema, variables` |
| `tune_set_select.sql` | Oracle SQL performance and tuning helper: tune set select. | `READ_ONLY` | `name, variables` |
| `tune_task_create.sql` | Oracle SQL performance and tuning helper: tune task create. | `CHANGES` | `plan, schema, sql_id, variables` |
| `tune_task_create_awr.sql` | Oracle SQL performance and tuning helper: tune task create awr. | `CHANGES` | `end_snap, schema, sql_id, start_snap, variables` |
| `tune_task_create_sqlset.sql` | Oracle SQL performance and tuning helper: tune task create sqlset. | `CHANGES` | `schema, sqlset, variables` |
| `tune_task_exec.sql` | Oracle SQL performance and tuning helper: tune task exec. | `CHANGES` | `task, variables` |
| `tune_task_report.sql` | Oracle SQL performance and tuning helper: tune task report. | `READ_ONLY` | `task, taskname, variables` |
| `tune_task_reset.sql` | Oracle SQL performance and tuning helper: tune task reset. | `REVIEW` | `task, variables` |
| `tuning_stats.sql` | Oracle SQL performance and tuning helper: tuning stats. | `READ_ONLY` | `PINS, variables, xxv1, xxv2, xxv3` |
| `unstable_plans.sql` | Oracle SQL performance and tuning helper: unstable plans. | `READ_ONLY` | `min_etime, min_stddev, variables` |
| `work_areas_stats.sql` | oracle/admin performance/sql_tuning helper: work areas stats. | `CHANGES` | `-` |
