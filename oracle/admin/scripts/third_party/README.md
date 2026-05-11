# oracle/admin third_party

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `waits.sql` | Displays information on all database session waits. | `CHANGES` | `-` |
| `waits1.sql` | Displays information on the current wait states for all active database sessions. | `CHANGES` | `MI, SS` |
| `create_sql_profile.sql` | Create SQL Profile based on Outline hints in V$SQL.OTHER_XML. | `CHANGES` | `category, child_no, force_matching, plan_hash_value, profile_name, sql_id` |
| `create_sql_profile_awr.sql` | Create SQL Profile based on Outline hints in V$SQL.OTHER_XML. | `CHANGES` | `category, child_no, force_matching, plan_hash_value, profile_name, sql_id` |
| `fix_sql_profile_hint.sql` | Replaces a hint in a sql profile. | `CHANGES` | `arg5, bad_hint, good_hint, profile_name` |
| `runstats.anon.sql` | This version of Tom Kyte's RUNSTATS uses an anonymous block | `DESTRUCTIVE` | `method1, method2` |
| `runstats_pkg.advanced.sql` | oracle/admin third_party helper: runstats pkg advanced. | `DESTRUCTIVE` | `mi, ss` |
| `runstats_pkg.gtt.sql` | oracle/admin third_party helper: runstats pkg gtt. | `DESTRUCTIVE` | `runid` |
| `runstats_pkg.simple.sql` | oracle/admin third_party helper: runstats pkg simple. | `DESTRUCTIVE` | `-` |
| `ash_log_file_sync.sql` | oracle/admin third_party helper: ash log file sync. | `READ_ONLY` | `-` |
| `ash_wait_chains.sql` | Display ASH wait chains (multi-session wait signature, a session | `READ_ONLY` | `MI, SS` |
| `ash_wait_chains2.sql` | Display ASH wait chains (multi-session wait signature, a session | `READ_ONLY` | `MI, SS` |
| `ashmem.sql` | oracle/admin third_party helper: ashmem. | `READ_ONLY` | `MI, SS` |
| `ashtop.sql` | Display top ASH time (count of ASH samples) grouped by your | `DESTRUCTIVE` | `MI, SS, minutes` |
| `asqlflame.sql` | oracle/admin third_party helper: asqlflame. | `READ_ONLY` | `-` |
| `asqlmon.sql` | Report SQL-monitoring-style drill-down into where in an execution plan the execution time is spent | `CHANGES` | `-` |
| `bash_wait_chains.sql` | Display ASH wait chains (multi-session wait signature, a session | `READ_ONLY` | `MI, SS, ashtable` |
| `bashtop.sql` | Display top ASH time (count of ASH samples) grouped by your | `DESTRUCTIVE` | `MI, SS, ashtable` |
| `bevent_hist.sql` | oracle/admin third_party helper: bevent hist. | `DESTRUCTIVE` | `MI, SS, ashtable` |
| `bevent_hist_micro.sql` | oracle/admin third_party helper: bevent hist micro. | `DESTRUCTIVE` | `ashtable` |
| `bshortmon_logfilesync.sql` | oracle/admin third_party helper: bshortmon logfilesync. | `READ_ONLY` | `-` |
| `btime_model_phases.sql` | oracle/admin third_party helper: btime model phases. | `READ_ONLY` | `-` |
| `create_ash_without_timestamps.sql` | oracle/admin third_party helper: create ash without timestamps. | `CHANGES` | `-` |
| `daplanline.sql` | Report response time consumption data from DBA_HIST_ACTIVE_SESS_HISTORY | `READ_ONLY` | `-` |
| `dash_wait_chains.sql` | Display ASH wait chains (multi-session wait signature, a session | `READ_ONLY` | `MI, SS` |
| `dash_wait_chains2.sql` | Display ASH wait chains (multi-session wait signature, a session | `READ_ONLY` | `MI, SS` |
| `dashtop.sql` | Display top ASH time (count of ASH samples) grouped by your | `DESTRUCTIVE` | `MI, SS` |
| `dasqlmon.sql` | Report SQL-monitoring-style drill-down into where in an execution plan the execution time is spent | `CHANGES` | `-` |
| `devent_hist.sql` | Display wait event duration histogram from DBA_HIST_ACTIVE_SESS_HISTORY | `DESTRUCTIVE` | `MI, SS` |
| `disk_rereads.sql` | oracle/admin third_party helper: disk rereads. | `READ_ONLY` | `-` |
| `event_hist.sql` | oracle/admin third_party helper: event hist. | `DESTRUCTIVE` | `MI, SS` |
| `event_hist_cell.sql` | oracle/admin third_party helper: event hist cell. | `DESTRUCTIVE` | `-` |
| `event_hist_micro.sql` | oracle/admin third_party helper: event hist micro. | `DESTRUCTIVE` | `-` |
| `evet_hist_cell.sql` | oracle/admin third_party helper: evet hist cell. | `DESTRUCTIVE` | `-` |
| `ash10.sql` | oracle/admin third_party helper: ash10. | `READ_ONLY` | `-` |
| `ash11.sql` | oracle/admin third_party helper: ash11. | `READ_ONLY` | `-` |
| `ash12a.sql` | oracle/admin third_party helper: ash12a. | `READ_ONLY` | `FROM_TIME, IN_CONNECTION_MGMT, TO_TIME, cols, from_time, to_time` |
| `ash13.sql` | oracle/admin third_party helper: ash13. | `READ_ONLY` | `FROM_TIME, TO_TIME, cols, from_time, to_time` |
| `ash13a.sql` | oracle/admin third_party helper: ash13a. | `READ_ONLY` | `FROM_TIME, TO_TIME, cols, from_time, to_time` |
| `ash2.sql` | oracle/admin third_party helper: ash2. | `READ_ONLY` | `FROM_TIME, IN_CONNECTION_MGMT, TO_TIME, cols, from_time, to_time` |
| `ash3.sql` | oracle/admin third_party helper: ash3. | `READ_ONLY` | `FROM_TIME, IN_CONNECTION_MGMT, TO_TIME, cols, from_time, to_time` |
| `ash5.sql` | oracle/admin third_party helper: ash5. | `READ_ONLY` | `-` |
| `ash7.sql` | oracle/admin third_party helper: ash7. | `READ_ONLY` | `-` |
| `ash8.sql` | oracle/admin third_party helper: ash8. | `READ_ONLY` | `-` |
| `ash9.sql` | oracle/admin third_party helper: ash9. | `READ_ONLY` | `-` |
| `gashtop.sql` | oracle/admin third_party helper: gashtop. | `READ_ONLY` | `-` |
| `gasqlmon.sql` | oracle/admin third_party helper: gasqlmon. | `READ_ONLY` | `-` |
| `gen_ash_report_html.sql` | oracle/admin third_party helper: gen ash report html. | `READ_ONLY` | `MI, _start, bdate, dbid, def_bdate, def_edate, edate, inst_id` |
| `gen_ash_report_text.sql` | oracle/admin third_party helper: gen ash report text. | `READ_ONLY` | `MI, _start, bdate, dbid, def_bdate, def_edate, edate, inst_id` |
| `old.event_hist_cell.sql` | oracle/admin third_party helper: old.event hist cell. | `DESTRUCTIVE` | `-` |
| `old_devent_hist.sql` | oracle/admin third_party helper: old devent hist. | `DESTRUCTIVE` | `-` |
| `perfsheet_ash.sql` | oracle/admin third_party helper: perfsheet ash. | `READ_ONLY` | `-` |
| `rowsource_events.sql` | Display top ASH time (count of ASH samples) grouped by | `READ_ONLY` | `-` |
| `sample_drift.sql` | oracle/admin third_party helper: sample drift. | `READ_ONLY` | `MI` |
| `shortmon.sql` | oracle/admin third_party helper: shortmon. | `READ_ONLY` | `arg4` |
| `shortmon_cell.sql` | oracle/admin third_party helper: shortmon cell. | `READ_ONLY` | `arg4` |
| `shortmon_logfilesync.sql` | oracle/admin third_party helper: shortmon logfilesync. | `READ_ONLY` | `-` |
| `shortmon_numblocks.sql` | oracle/admin third_party helper: shortmon numblocks. | `READ_ONLY` | `arg4` |
| `sqlid_activity.sql` | oracle/admin third_party helper: sqlid activity. | `READ_ONLY` | `MI, SS, bdate, dbid, def_bdate, def_edate, edate, inst_id, sqlid, sqlset_name` |
| `sqlid_plan_activity.sql` | oracle/admin third_party helper: sqlid plan activity. | `READ_ONLY` | `-` |
| `time_model.sql` | oracle/admin third_party helper: time model. | `READ_ONLY` | `IN_TABLESPACE_ENCRYPTION` |
| `w.sql` | oracle/admin third_party helper: w. | `READ_ONLY` | `filter` |
| `wsqlmon.sql` | Report SQL-monitoring-style drill-down into where in an execution plan the execution time is spent | `DESTRUCTIVE` | `-` |
| `01_sql_plan_layout_intro.sql` | oracle/admin third_party helper: 01 sql plan layout intro. | `CHANGES` | `-` |
| `02_advanced_rewrite.sql` | oracle/admin third_party helper: 02 advanced rewrite. | `CHANGES` | `user` |
| `02_badly_correlated.sql` | oracle/admin third_party helper: 02 badly correlated. | `DESTRUCTIVE` | `-` |
| `02_bind_peeking_nested_loops.sql` | this script demos how a "wrong" bind variable value | `DESTRUCTIVE` | `OPTIMIZER_INDEX_COST_ADJ, v1, v2, v3, v4, v5` |
| `02_bind_peeking_nested_loops_2.sql` | this script demos how a "wrong" bind variable value | `DESTRUCTIVE` | `OPTIMIZER_INDEX_COST_ADJ` |
| `02_bind_peeking_nested_loops_nohist.sql` | this script demos how a "wrong" bind variable value | `DESTRUCTIVE` | `OPTIMIZER_INDEX_COST_ADJ` |
| `02_bind_peeking_nested_loops_proc.sql` | this script demos how a "wrong" bind variable value | `DESTRUCTIVE` | `OPTIMIZER_INDEX_COST_ADJ` |
| `02_choosing_join_order.sql` | Advanced Oracle SQL Tuning demo script | `DESTRUCTIVE` | `NO_INVALIDATE, NUMBLKS, NUMROWS, arg1, bad_sqlid, good_plan_hash_value, good_sql_id, sql_fulltext, sql_handle_for_original` |
| `02_distinct_agg_transform.sql` | oracle/admin third_party helper: 02 distinct agg transform. | `DESTRUCTIVE` | `-` |
| `02_join_nested_loops.sql` | oracle/admin third_party helper: 02 join nested loops. | `READ_ONLY` | `-` |
| `02_leading_sq.sql` | oracle/admin third_party helper: 02 leading sq. | `READ_ONLY` | `-` |
| `02_outline_force_plan_from_cursor.sql` | oracle/admin third_party helper: 02 outline force plan from cursor. | `DESTRUCTIVE` | `outline_name_bad, outline_name_good` |
| `02_qt_troubleshooting.sql` | oracle/admin third_party helper: 02 qt troubleshooting. | `DESTRUCTIVE` | `-` |
| `02_sql_plan_baseline_from_cursor.sql` | oracle/admin third_party helper: 02 sql plan baseline from cursor. | `CHANGES` | `bad_sqlid, good_plan_hash_value, good_sql_id, sql_handle_for_original` |
| `02_sqlprofile_force_plan_with_custom_hints.sql` | oracle/admin third_party helper: 02 sqlprofile force plan with custom hints. | `DESTRUCTIVE` | `SCALE_ROWS, arg1, arg2, arg26, sql_fulltext` |
| `03_bitmap_star_transformation.sql` | oracle/admin third_party helper: 03 bitmap star transformation. | `CHANGES` | `-` |
| `03_constraints_not_null.sql` | oracle/admin third_party helper: 03 constraints not null. | `DESTRUCTIVE` | `-` |
| `03_index_density.sql` | oracle/admin third_party helper: 03 index density. | `CHANGES` | `-` |
| `03_index_inefficiency_1.sql` | oracle/admin third_party helper: 03 index inefficiency 1. | `DESTRUCTIVE` | `-` |
| `03_index_skip_scan.sql` | oracle/admin third_party helper: 03 index skip scan. | `DESTRUCTIVE` | `-` |
| `03_index_supporting_sorts.sql` | oracle/admin third_party helper: 03 index supporting sorts. | `DESTRUCTIVE` | `-` |
| `04_cbo_selectivity_decay.sql` | oracle/admin third_party helper: 04 cbo selectivity decay. | `DESTRUCTIVE` | `-` |
| `04_cbo_troubleshoot_1.sql` | oracle/admin third_party helper: 04 cbo troubleshoot 1. | `READ_ONLY` | `-` |
| `04_cbo_troubleshoot_2.sql` | oracle/admin third_party helper: 04 cbo troubleshoot 2. | `READ_ONLY` | `arg1, arg4, arg5488` |
| `04_cbo_troubleshoot_3.sql` | oracle/admin third_party helper: 04 cbo troubleshoot 3. | `READ_ONLY` | `SCALE_ROWS, arg1` |
| `04_cbo_troubleshoot_denormalized.sql` | oracle/admin third_party helper: 04 cbo troubleshoot denormalized. | `READ_ONLY` | `arg2, arg4` |
| `04_cbo_troubleshoot_save.sql` | oracle/admin third_party helper: 04 cbo troubleshoot save. | `READ_ONLY` | `arg5488` |
| `04_cbo_troubleshoot_setup.sql` | oracle/admin third_party helper: 04 cbo troubleshoot setup. | `DESTRUCTIVE` | `NO_INVALIDATE` |
| `ast_setup.sql` | oracle/admin third_party helper: ast setup. | `CHANGES` | `datafile_dir` |
| `ast_setup_schema.sql` | oracle/admin third_party helper: ast setup schema. | `DESTRUCTIVE` | `-` |
| `index_coalesce_candidate.sql` | oracle/admin third_party helper: index coalesce candidate. | `READ_ONLY` | `-` |
| `index_coalesce_candidate_detail.sql` | oracle/admin third_party helper: index coalesce candidate detail. | `READ_ONLY` | `-` |
| `index_compress_candidate.sql` | oracle/admin third_party helper: index compress candidate. | `READ_ONLY` | `-` |
| `index_range_scan_rereads.sql` | oracle/admin third_party helper: index range scan rereads. | `CHANGES` | `-` |
| `new_outer_join_and_or.sql` | oracle/admin third_party helper: new outer join and or. | `DESTRUCTIVE` | `arg1, arg2, arg64` |
| `scalar_subquery_in_where_clause.sql` | oracle/admin third_party helper: scalar subquery in where clause. | `CHANGES` | `arg2, prev_child_number, prev_sql_id` |
| `scalar_subquery_unnesting.sql` | oracle/admin third_party helper: scalar subquery unnesting. | `DESTRUCTIVE` | `-` |
| `soe_query.sql` | oracle/admin third_party helper: soe query. | `CHANGES` | `-` |
| `subquery_execution.sql` | oracle/admin third_party helper: subquery execution. | `READ_ONLY` | `-` |
| `test_index_coalesce_candidate.sql` | oracle/admin third_party helper: test index coalesce candidate. | `DESTRUCTIVE` | `-` |
| `use_concat.sql` | oracle/admin third_party helper: use concat. | `DESTRUCTIVE` | `-` |
| `awr_evh.sql` | oracle/admin third_party helper: awr evh. | `READ_ONLY` | `MI` |
| `awr_last.sql` | oracle/admin third_party helper: awr last. | `READ_ONLY` | `bid, dbid, eid, inst_num` |
| `awr_lasth.sql` | oracle/admin third_party helper: awr lasth. | `READ_ONLY` | `bid, dbid, eid, inst_num` |
| `awr_log_file_sync.sql` | oracle/admin third_party helper: awr log file sync. | `READ_ONLY` | `-` |
| `awr_mem_resize.sql` | oracle/admin third_party helper: awr mem resize. | `READ_ONLY` | `MI, SS` |
| `awr_procmem.sql` | oracle/admin third_party helper: awr procmem. | `READ_ONLY` | `MI` |
| `awr_sqlid.sql` | oracle/admin third_party helper: awr sqlid. | `READ_ONLY` | `-` |
| `awr_sqlstats.sql` | oracle/admin third_party helper: awr sqlstats. | `READ_ONLY` | `-` |
| `awr_sqlstats_per_exec.sql` | oracle/admin third_party helper: awr sqlstats per exec. | `CHANGES` | `-` |
| `awr_sqlstats_unstable.sql` | oracle/admin third_party helper: awr sqlstats unstable. | `READ_ONLY` | `sqlid` |
| `awr_sysmetric_history.sql` | oracle/admin third_party helper: awr sysmetric history. | `READ_ONLY` | `-` |
| `awr_sysmetric_summary.sql` | oracle/admin third_party helper: awr sysmetric summary. | `READ_ONLY` | `-` |
| `awr_sysstat.sql` | oracle/admin third_party helper: awr sysstat. | `READ_ONLY` | `MI, SS` |
| `awr_system_event.sql` | oracle/admin third_party helper: awr system event. | `READ_ONLY` | `-` |
| `create_event_histogram_view.sql` | oracle/admin third_party helper: create event histogram view. | `CHANGES` | `-` |
| `dbload.sql` | oracle/admin third_party helper: dbload. | `READ_ONLY` | `-` |
| `gen_awr_report.sql` | oracle/admin third_party helper: gen awr report. | `READ_ONLY` | `MI, SS, bid, dbid, eid` |
| `get_settings.sql` | oracle/admin third_party helper: get settings. | `READ_ONLY` | `-` |
| `other_xml.sql` | oracle/admin third_party helper: other xml. | `READ_ONLY` | `-` |
| `settings.sql` | oracle/admin third_party helper: settings. | `CHANGES` | `-` |
| `alter_all_indexes_degree.sql` | oracle/admin third_party helper: alter all indexes degree. | `CHANGES` | `-` |
| `ash_storage.sql` | oracle/admin third_party helper: ash storage. | `DESTRUCTIVE` | `-` |
| `badfetch.sql` | oracle/admin third_party helper: badfetch. | `READ_ONLY` | `-` |
| `cell.sql` | oracle/admin third_party helper: cell. | `READ_ONLY` | `-` |
| `cell_intrablock_chaining.sql` | oracle/admin third_party helper: cell intrablock chaining. | `DESTRUCTIVE` | `-` |
| `cell_scan_resulting_traffic.sql` | oracle/admin third_party helper: cell scan resulting traffic. | `DESTRUCTIVE` | `-` |
| `cellio.sql` | oracle/admin third_party helper: cellio. | `READ_ONLY` | `-` |
| `celliorm.sql` | Report Exadata cell IORM status from V$CELL_CONFIG | `READ_ONLY` | `-` |
| `cellpd.sql` | Report physical disk summary from V$CELL_CONFIG | `READ_ONLY` | `-` |
| `cellpdx.sql` | Report detailed physical disk info from V$CELL_CONFIG | `READ_ONLY` | `-` |
| `cellver.sql` | Report Exadata cell details from V$CELL_CONFIG | `READ_ONLY` | `-` |
| `comptype.sql` | oracle/admin third_party helper: comptype. | `READ_ONLY` | `-` |
| `cth.sql` | Display the "ASH for Storage Cells" info from V$CELL_THREAD_HISTORY | `READ_ONLY` | `-` |
| `default_flash_cache_for_user.sql` | oracle/admin third_party helper: default flash cache for user. | `CHANGES` | `-` |
| `bloom_minmax_storage_index.sql` | oracle/admin third_party helper: bloom minmax storage index. | `CHANGES` | `-` |
| `bloom_minmax_storage_index2.sql` | oracle/admin third_party helper: bloom minmax storage index2. | `CHANGES` | `-` |
| `bloom_minmax_storage_index3.sql` | oracle/admin third_party helper: bloom minmax storage index3. | `CHANGES` | `-` |
| `flash_cache_demos.sql` | oracle/admin third_party helper: flash cache demos. | `DESTRUCTIVE` | `begin_snap_id, end_snap_id, mysid` |
| `get_cust_name.sql` | oracle/admin third_party helper: get cust name. | `CHANGES` | `-` |
| `part_table.sql` | oracle/admin third_party helper: part table. | `CHANGES` | `ON` |
| `row_filtering.sql` | oracle/admin third_party helper: row filtering. | `CHANGES` | `mysid` |
| `soe_orders.sql` | oracle/admin third_party helper: soe orders. | `READ_ONLY` | `-` |
| `soe_orders_bloom_storidx.sql` | oracle/admin third_party helper: soe orders bloom storidx. | `CHANGES` | `-` |
| `soe_orders_index.sql` | oracle/admin third_party helper: soe orders index. | `READ_ONLY` | `-` |
| `disable_flash_cache_for_user.sql` | oracle/admin third_party helper: disable flash cache for user. | `CHANGES` | `-` |
| `enable_flash_cache_for_user.sql` | oracle/admin third_party helper: enable flash cache for user. | `CHANGES` | `-` |
| `esql.sql` | oracle/admin third_party helper: esql. | `READ_ONLY` | `-` |
| `exadisktopo.sql` | Report Exadata disk topology from ASM Diskgroup all the way to cell LUNs and Physical disks | `READ_ONLY` | `-` |
| `exadisktopo2.sql` | Report Exadata disk topology from cell LUNs and Physical disks all the way to ASM diskgroups | `READ_ONLY` | `-` |
| `exafriendly.sql` | This script is a collection of queries against ASH, which will | `READ_ONLY` | `ash, sqlid` |
| `exasnap.sql` | Display various Exadata IO efficiency metrics of a session | `READ_ONLY` | `asm_mirrors, blocksize, divisor, nothing, unit` |
| `exasnapper_install_latest.sql` | Install required objects for the Session Snapper for Exadata tool | `DESTRUCTIVE` | `INST, MI, SS, TIME, begin_snap_id, end_snap_id` |
| `exastat.py` | oracle/admin third_party helper: exastat. | `READ_ONLY` | `DEBUG, name, obj, timestamp, unit, value` |
| `exatest.sql` | oracle/admin third_party helper: exatest. | `DESTRUCTIVE` | `-` |
| `hcc_cu_size.sql` | oracle/admin third_party helper: hcc cu size. | `DESTRUCTIVE` | `-` |
| `hcc_cu_size_cellstats.sql` | oracle/admin third_party helper: hcc cu size cellstats. | `DESTRUCTIVE` | `-` |
| `in_memory_px_test.sql` | oracle/admin third_party helper: in memory px test. | `DESTRUCTIVE` | `-` |
| `io_optimized_sql.sql` | oracle/admin third_party helper: io optimized sql. | `READ_ONLY` | `-` |
| `ioeff.sql` | Display various Exadata IO efficiency metrics | `READ_ONLY` | `-` |
| `make_all_indexes_invisible.sql` | oracle/admin third_party helper: make all indexes invisible. | `CHANGES` | `-` |
| `make_all_indexes_visible.sql` | oracle/admin third_party helper: make all indexes visible. | `CHANGES` | `-` |
| `mon_topsql.sql` | This script can be used for getting an overview of your most | `READ_ONLY` | `days` |
| `mon_topsql2.sql` | oracle/admin third_party helper: mon topsql2. | `READ_ONLY` | `days, separator, weekdays` |
| `nls_smart_scan.sql` | oracle/admin third_party helper: nls smart scan. | `DESTRUCTIVE` | `-` |
| `smx.sql` | oracle/admin third_party helper: smx. | `READ_ONLY` | `-` |
| `topsql.sql` | oracle/admin third_party helper: topsql. | `READ_ONLY` | `-` |
| `setup_workload_index_control.sql` | oracle/admin third_party helper: setup workload index control. | `DESTRUCTIVE` | `schemaname` |
| `test_workload_index_control.sql` | oracle/admin third_party helper: test workload index control. | `DESTRUCTIVE` | `-` |
| `hot_blocks.sql` | Detects hot blocks. | `CHANGES` | `address` |
| `longops.sql` | oracle/admin third_party helper: longops. | `READ_ONLY` | `USERNAME` |
| `network_acls_ddl.sql` | Displays DDL for all network ACLs. | `CHANGES` | `MI, SS, TZM` |
| `nonshared.sql` | Print reasons for non-shared child cursors from v$sql_shared_cursor | `CHANGES` | `cmd` |
| `taln.sql` | oracle/admin third_party helper: taln. | `CHANGES` | `MI, SS, number, query` |
| `tun.sql` | Displays several performance indicators and comments on the value. | `CHANGES` | `-` |
| `undo.sql` | Displays undo information on relevant database sessions. | `CHANGES` | `-` |
