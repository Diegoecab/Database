# oracle/admin platform/rac

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `AnalyzeNonSharedRAC.sql` | Oracle RAC or cluster administration helper: AnalyzeNonSharedRAC. | `READ_ONLY` | `variables` |
| `CandidateSearch10RAC.sql` | Oracle RAC or cluster administration helper: CandidateSearch10RAC. | `READ_ONLY` | `variables` |
| `CurrentSQLRAC.sql` | Oracle RAC or cluster administration helper: CurrentSQLRAC. | `READ_ONLY` | `variables` |
| `CursorInfoRAC.sql` | Oracle RAC or cluster administration helper: CursorInfoRAC. | `READ_ONLY` | `variables` |
| `LibCacheOverview10gRAC.sql` | Oracle RAC or cluster administration helper: LibCacheOverview10gRAC. | `READ_ONLY` | `mi, ss, variables, x_1time_sum, x_1time_ttl, x_KGH, x_bc_size, x_jp_size, x_lp_size, x_other_size, x_ra, x_sgasize, x_sp_free_chks, x_sp_no_kept_chks, x_sp_no_obj, x_sp_no_pins, x_sp_no_stmts, x_sp_other, x_sp_size, x_sp_sz_kept_chks, x_sp_sz_pins, x_sp_used, x_sp_used_per, x_sp_used_run, x_sp_used_shr, x_sp_vers, x_str_size, x_tot_lc, x_trend_4031, x_trend_rs, x_trend_rs_size, x_trend_size` |
| `LibCacheOverview9iRAC.sql` | Oracle RAC or cluster administration helper: LibCacheOverview9iRAC. | `READ_ONLY` | `mi, ss, variables, x_1time_sum, x_1time_ttl, x_bc_size, x_jp_size, x_lp_size, x_other_size, x_sgasize, x_sp_free_chks, x_sp_no_kept_chks, x_sp_no_obj, x_sp_no_pins, x_sp_no_stmts, x_sp_other, x_sp_size, x_sp_sz_kept_chks, x_sp_sz_pins, x_sp_used, x_sp_used_per, x_sp_used_run, x_sp_used_shr, x_sp_vers, x_tot_lc, x_trend_4031, x_trend_rs, x_trend_rs_size, x_trend_size` |
| `ReservedAnalysisRAC.sql` | Oracle RAC or cluster administration helper: ReservedAnalysisRAC. | `READ_ONLY` | `variables` |
| `SGAComponents11gRAC.sql` | Oracle RAC or cluster administration helper: SGAComponents11gRAC. | `READ_ONLY` | `mi, ss, variables` |
| `SGAComponentsRAC.sql` | Oracle RAC or cluster administration helper: SGAComponentsRAC. | `READ_ONLY` | `mi, ss, variables` |
| `SGAParametersRAC.sql` | Oracle RAC or cluster administration helper: SGAParametersRAC. | `READ_ONLY` | `variables` |
| `SGAStatRAC.sql` | Oracle RAC or cluster administration helper: SGAStatRAC. | `READ_ONLY` | `PLW_STR_NEW_LEN_VEC, mi, ss, variables` |
| `block_change_tracking.sql` | Oracle RAC or cluster administration helper: block change tracking. | `READ_ONLY` | `variables` |
| `check_oracle_instant_nagios` | Nagios health check for Oracle instance cache and wait metrics. | `READ_ONLY` | `ADDRESS, CONNECT_DATA, DESCRIPTION, ERRORS, PROTOCOL, SID, arg1` |
| `cluster_parameters.sql` | Oracle RAC or cluster administration helper: cluster parameters. | `CHANGES` | `ADDRESS, HOST, PORT, PROTOCOL, variables` |
| `cluvfy.comp.ocr.status.sh` | Oracle RAC or cluster administration helper: cluvfy comp ocr status. | `REVIEW` | `-` |
| `commands_summary.sh` | Oracle RAC or cluster administration helper: commands summary. | `DESTRUCTIVE` | `-` |
| `crs.cluster.check.all.sh` | Oracle RAC or cluster administration helper: crs cluster check all. | `REVIEW` | `-` |
| `crs.cluster.check.sh` | Oracle RAC or cluster administration helper: crs cluster check. | `REVIEW` | `-` |
| `crs.cluster.enable.sh` | Oracle RAC or cluster administration helper: crs cluster enable. | `REVIEW` | `-` |
| `crs.cluster_mode_status.sh` | Oracle RAC or cluster administration helper: crs cluster mode status. | `REVIEW` | `-` |
| `crs.cluster_state.sh` | Oracle RAC or cluster administration helper: crs cluster state. | `REVIEW` | `-` |
| `crs.cluster_status.sh` | Oracle RAC or cluster administration helper: crs cluster status. | `REVIEW` | `-` |
| `crs.cluster_status_crs.sh` | Oracle RAC or cluster administration helper: crs cluster status crs. | `REVIEW` | `-` |
| `crs.cluster_stop.sh` | Oracle RAC or cluster administration helper: crs cluster stop. | `REVIEW` | `-` |
| `crs.cluster_stop_all.sh` | Oracle RAC or cluster administration helper: crs cluster stop all. | `REVIEW` | `-` |
| `crs.cluster_stop_crs.sh` | Oracle RAC or cluster administration helper: crs cluster stop crs. | `REVIEW` | `-` |
| `crs.local_stop.sh` | Oracle RAC or cluster administration helper: crs local stop. | `REVIEW` | `-` |
| `crs.query.softwareversion.sh` | Oracle RAC or cluster administration helper: crs query softwareversion. | `REVIEW` | `-` |
| `crs.resource.profile.sh` | Oracle RAC or cluster administration helper: crs resource profile. | `REVIEW` | `-` |
| `crs.status.resource_database.sh` | Oracle RAC or cluster administration helper: crs status resource database. | `REVIEW` | `-` |
| `crs.version.sh` | Oracle RAC or cluster administration helper: crs version. | `REVIEW` | `-` |
| `crs.votedisk.move.sh` | Oracle RAC or cluster administration helper: crs votedisk move. | `REVIEW` | `-` |
| `crsctl.config.crs.sh` | Oracle RAC or cluster administration helper: crsctl config crs. | `REVIEW` | `-` |
| `crsctl.ons.status.sh` | Oracle RAC or cluster administration helper: crsctl ons status. | `REVIEW` | `-` |
| `crsctl.query.css.votedisk.sh` | Oracle RAC or cluster administration helper: crsctl query css votedisk. | `REVIEW` | `-` |
| `crsctl.start.res.init.sh` | Oracle RAC or cluster administration helper: crsctl start res init. | `REVIEW` | `-` |
| `crsctl.stat.res.sh` | Oracle RAC or cluster administration helper: crsctl stat res. | `REVIEW` | `-` |
| `crsctl.votedisk.replce.sh` | Oracle RAC or cluster administration helper: crsctl votedisk replce. | `REVIEW` | `-` |
| `dbms_system.trace.sql` | oracle/admin platform/rac helper: dbms system.trace. | `READ_ONLY` | `SSERIAL, SSID` |
| `diff_parameters_rac.sql` | Oracle RAC or cluster administration helper: diff parameters rac. | `READ_ONLY` | `variables` |
| `enable_db_block_change_tracking.sql` | oracle/admin platform/rac helper: enable db block change tracking. | `CHANGES` | `-` |
| `exec_all.sql` | Oracle RAC or cluster administration helper: exec all. | `CHANGES` | `MI, SS, dbname, err, nls_lang, numero_cambio, usuario, variables` |
| `instalacion_oracle_garba.sql` | oracle/admin platform/rac helper: instalacion oracle garba. | `REVIEW` | `-` |
| `listnodes.sh` | Oracle RAC or cluster administration helper: listnodes. | `REVIEW` | `-` |
| `loksRAC9i.sql` | Oracle RAC or cluster administration helper: loksRAC9i. | `DESTRUCTIVE` | `variables` |
| `nls_database_parameters_character_Set.sql` | Oracle RAC or cluster administration helper: nls database parameters character Set. | `READ_ONLY` | `variables` |
| `oclumon.dumpnodeview.last.sh` | Oracle RAC or cluster administration helper: oclumon dumpnodeview last. | `REVIEW` | `-` |
| `ocrcheck.config.sh` | Oracle RAC or cluster administration helper: ocrcheck config. | `REVIEW` | `-` |
| `ocrcheck.local.sh` | Oracle RAC or cluster administration helper: ocrcheck local. | `REVIEW` | `-` |
| `ocrcheck.sh` | Oracle RAC or cluster administration helper: ocrcheck. | `REVIEW` | `-` |
| `ocrconfig.add.sh` | Oracle RAC or cluster administration helper: ocrconfig add. | `REVIEW` | `-` |
| `ocrconfig.manualbackup.sh` | Oracle RAC or cluster administration helper: ocrconfig manualbackup. | `REVIEW` | `-` |
| `ocrconfig.showbackup.sh` | Oracle RAC or cluster administration helper: ocrconfig showbackup. | `REVIEW` | `-` |
| `oifcfg.getif.sh` | Oracle RAC or cluster administration helper: oifcfg getif. | `REVIEW` | `-` |
| `oifcfg.iflist.sh` | Oracle RAC or cluster administration helper: oifcfg iflist. | `REVIEW` | `-` |
| `oracle.gstats.monitor.sh` | Global Daily Stats Monitor # | `CHANGES` | `APPL_PATH, ARCHIVE, BIN, CONFIG, DEFAULT_ERROR_LOG, DEFAULT_OUTPUT_LOG, ERR_NUM, FUN_NAME, LIB, LOG, LOGFILE, LOG_STR, Local, MAIL_DBAS, MAIL_PS, MAIL_TO, MSG_LOG, NARG, ORACLE_SID, ORAUSER, PARAMETERS, PROGRAM, SCRIPT, SCRIPT_LOGS, SCRIPT_NAME, arg1, arg2, arg3, mi, ss` |
| `oracle_check.sql` | Oracle RAC or cluster administration helper: oracle check. | `CHANGES` | `variables` |
| `oracle_common_functions_linux.sh` | Oracle RAC or cluster administration helper: oracle common functions linux. | `DESTRUCTIVE` | `CENTRAL_ORAINV, CRS_DB_RESOURCE, CRS_DB_STATE, CURRENT_HOST, DB_NAME, DB_ROLE, DB_UNIQUE_NAME, DIAGNOSTIC_DEST, DISPLAY, G_ORAEDITION, G_ORAVERSION, HOST, IFS, ISTTY, LD_LIBRARY_PATH, LOC, L_OH, L_OH_NAME, L_ORAEDITION, L_ORAVERSION, MGMTDB_HOST, NAME, NLS_CHARSET, NLS_LANG, OH2CHECK, OH_NAME, OLDIFS, ONLINE, ORACLE_BASE, ORACLE_HOME, ORACLE_SID, ORCL, ORCL1, ORCL_SITE1, PATH, PORT, PRIMARY, PS1, PSERR, REMOVED, SEARCH, SID, TNS_ADMIN, TOP, VER, arg1, arg2, arg3, arg4, arg5` |
| `oracle_to_excel.sql` | Oracle RAC or cluster administration helper: oracle to excel. | `CHANGES` | `Cell, Data, Format, ID, MI, Name, NumberFormat, Row, SS, Style, StyleID, Styles, Table, Type, Workbook, Worksheet, mm, office, schemas, spreadsheet, ss, variables` |
| `oracle.db.deploy.sh` | Deploy database scripts reliably # | `CHANGES` | `APPL_CFG_DIR, APPL_LOG, APPL_PATH, DEFAULT_ERROR_LOG, DEFAULT_LOG, DPLY_STATUS, ERR_NUM, FUN_NAME, LOGFILE, LOG_DIR, LOG_STR, Local, MSG_LOG, PACKAGE_NAME, PARAMETERS, PROGRAM, SCRIPT_NAME, SQL_SCRIPT, VERSIONID, VERSIONS_TB_IMPLEMENTED, VERSION_ID_NAME, ZIPPED_FILE, ZIPPED_FILE_NAME, arg1, arg2, arg3, exp_` |
| `test_oracledb.py` | Oracle RAC or cluster administration helper: test oracledb. | `CHANGES` | `ADDRESS, CONNECT_DATA, DESCRIPTION, PROTOCOL, SERVICE_NAME` |
| `srv.config.db.sh` | Oracle RAC or cluster administration helper: srv config db. | `REVIEW` | `-` |
| `srv.config.scan.sh` | Oracle RAC or cluster administration helper: srv config scan. | `REVIEW` | `-` |
| `srv.config.scan_listener.sh` | Oracle RAC or cluster administration helper: srv config scan listener. | `REVIEW` | `-` |
| `srv.config.service.sh` | Oracle RAC or cluster administration helper: srv config service. | `REVIEW` | `-` |
| `srv.config.vips.sh` | Oracle RAC or cluster administration helper: srv config vips. | `REVIEW` | `-` |
| `srv.gns_config.sh` | Oracle RAC or cluster administration helper: srv gns config. | `REVIEW` | `-` |
| `srv.service.taf.sql` | Oracle RAC or cluster administration helper: srv service taf. | `READ_ONLY` | `variables` |
| `srv.start.instance.sh` | Oracle RAC or cluster administration helper: srv start instance. | `REVIEW` | `-` |
| `srv.status_database.sh` | Oracle RAC or cluster administration helper: srv status database. | `REVIEW` | `-` |
| `srvctl.add_database.sh` | Oracle RAC or cluster administration helper: srvctl add database. | `REVIEW` | `-` |
| `srvctl.stop.home.sh` | Oracle RAC or cluster administration helper: srvctl stop home. | `REVIEW` | `-` |
| `cbo_analyze.sh` | Oracle RAC or cluster administration helper: cbo analyze. | `CHANGES` | `arg1` |
| `trace_onlogon_trigger.sql` | Oracle RAC or cluster administration helper: trace onlogon trigger. | `CHANGES` | `variables` |
| `trace_specific_error.sql` | Oracle RAC or cluster administration helper: trace specific error. | `CHANGES` | `variables` |
| `trace_usuarios.sql` | Oracle RAC or cluster administration helper: trace usuarios. | `CHANGES` | `SQL_TRACE, USER_ID, variables` |
| `trigger_database_x_ip_trace.sql` | Oracle RAC or cluster administration helper: trigger database x ip trace. | `CHANGES` | `variables` |
| `xml_extract_example.sql` | Oracle RAC or cluster administration helper: xml extract example. | `READ_ONLY` | `variables` |
