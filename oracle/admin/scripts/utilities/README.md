# oracle/admin utilities

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `triggers_database.sql` | oracle/admin utilities helper: triggers database. | `CHANGES` | `-` |
| `10gDB.sh` | Oracle administration helper: 10gDB. | `REVIEW` | `arg1` |
| `10gEM.sh` | Oracle administration helper: 10gEM. | `REVIEW` | `ORACLE_SID, arg1, arg2` |
| `10genv.sh` | Oracle administration helper: 10genv. | `REVIEW` | `CLASSPATH, LD_LIBRARY_PATH, ORACLE_BASE, ORACLE_HOME, PATH, PS1` |
| `11gDB.sh` | Oracle administration helper: 11gDB. | `REVIEW` | `arg1` |
| `11gEM.sh` | Oracle administration helper: 11gEM. | `REVIEW` | `ORACLE_SID, arg1, arg2` |
| `11genv.sh` | Oracle administration helper: 11genv. | `REVIEW` | `CLASSPATH, LD_LIBRARY_PATH, ORACLE_BASE, ORACLE_HOME, ORACLE_SID, PATH, PS1` |
| `Cache_Hits.sql` | Oracle administration helper: Cache Hits(1). | `READ_ONLY` | `variables` |
| `Crear_tabla_as_select_sin_registros.sql` | Oracle administration helper: Crear tabla as select sin registros. | `CHANGES` | `variables` |
| `CreateQueues.sql` | Oracle administration helper: CreateQueues. | `CHANGES` | `variables` |
| `CursorEfficiency.sql` | Oracle administration helper: CursorEfficiency. | `READ_ONLY` | `variables` |
| `DG_troubleshooting.sql` | Oracle administration helper: DG troubleshooting. | `DESTRUCTIVE` | `APPLIED, DEST_ID, MI, SID, SQL, SS, STATE, arg4, mi, ss, variables` |
| `DOT_ORI.sql` | Oracle administration helper: DOT ORI. | `READ_ONLY` | `variables` |
| `EBSbugs.sql` | Oracle administration helper: EBSbugs. | `READ_ONLY` | `variables` |
| `EBSprods.sql` | Oracle administration helper: EBSprods. | `READ_ONLY` | `variables` |
| `HardParses.sql` | Oracle administration helper: HardParses. | `READ_ONLY` | `variables` |
| `Identific_Procesos_usuarios.sql` | Oracle administration helper: Identific Procesos usuarios. | `READ_ONLY` | `variables` |
| `IndicesFuncionesEjemplo.sql` | Oracle administration helper: IndicesFuncionesEjemplo. | `DESTRUCTIVE` | `variables` |
| `Keep_Cache_.sql` | Oracle administration helper: Keep Cache. | `CHANGES` | `variables` |
| `Lectura_a_disco.sql` | Oracle administration helper: Lectura a disco. | `READ_ONLY` | `variables` |
| `LibCacheOverview10g.sql` | Oracle administration helper: LibCacheOverview10g. | `READ_ONLY` | `mi, ss, variables, x_1time_sum, x_1time_ttl, x_KGH, x_bc_size, x_jp_size, x_lp_size, x_other_size, x_ra, x_sgasize, x_sp_free_chks, x_sp_no_kept_chks, x_sp_no_obj, x_sp_no_pins, x_sp_no_stmts, x_sp_other, x_sp_size, x_sp_sz_kept_chks, x_sp_sz_pins, x_sp_used, x_sp_used_per, x_sp_used_run, x_sp_used_shr, x_sp_vers, x_str_size, x_tot_lc, x_trend_4031, x_trend_rs, x_trend_rs_size, x_trend_size` |
| `LibCacheOverview9i.sql` | Oracle administration helper: LibCacheOverview9i. | `READ_ONLY` | `mi, ss, variables, x_1time_sum, x_1time_ttl, x_bc_size, x_jp_size, x_lp_size, x_other_size, x_sgasize, x_sp_free_chks, x_sp_no_kept_chks, x_sp_no_obj, x_sp_no_pins, x_sp_no_stmts, x_sp_other, x_sp_size, x_sp_sz_kept_chks, x_sp_sz_pins, x_sp_used, x_sp_used_per, x_sp_used_run, x_sp_used_shr, x_sp_vers, x_tot_lc, x_trend_4031, x_trend_rs, x_trend_rs_size, x_trend_size` |
| `Literals10g.sql` | Oracle administration helper: Literals10g. | `DESTRUCTIVE` | `TIME_ZONE, variables` |
| `Literals9i.sql` | Oracle administration helper: Literals9i. | `DESTRUCTIVE` | `TIME_ZONE, variables` |
| `Lockeos10G.sql` | Oracle administration helper: Lockeos10G. | `READ_ONLY` | `variables` |
| `LogFileSwitchHistory.sql` | Oracle administration helper: LogFileSwitchHistory. | `READ_ONLY` | `variables` |
| `Loks10g.sql` | Oracle administration helper: Loks10g. | `READ_ONLY` | `variables` |
| `Long Rollbacks.sql` | Oracle administration helper: Long Rollbacks. | `READ_ONLY` | `variables` |
| `MemoriaOcupadaxProceduresPack.sql` | Oracle administration helper: MemoriaOcupadaxProceduresPack. | `READ_ONLY` | `variables` |
| `Miner_LOG.sql` | Oracle administration helper: Miner LOG. | `CHANGES` | `MI, SS, variables` |
| `Mvtabs.sql` | Oracle administration helper: Mvtabs. | `CHANGES` | `owner, tabname, variables` |
| `OWB_refrescos.sql` | Oracle administration helper: OWB refrescos. | `READ_ONLY` | `variables` |
| `PGA_OrdenamientosenDisco.sql` | Oracle administration helper: PGA OrdenamientosenDisco. | `READ_ONLY` | `variables` |
| `PGA_SESION.sql` | Oracle administration helper: PGA SESION. | `READ_ONLY` | `variables` |
| `Parallel_Query.sql` | Oracle administration helper: Parallel Query. | `READ_ONLY` | `variables` |
| `PinCandidates.sql` | Oracle administration helper: PinCandidates. | `READ_ONLY` | `variables` |
| `PinnedCode.sql` | Oracle administration helper: PinnedCode. | `READ_ONLY` | `variables` |
| `PoolAdvice.sql` | Oracle administration helper: PoolAdvice. | `READ_ONLY` | `variables` |
| `PostgreSQL_Monit.sql` | Oracle administration helper: PostgreSQL Monit. | `READ_ONLY` | `OPDB, PGPORT, variables` |
| `ProdtvPeru.sql` | Oracle administration helper: ProdtvPeru. | `DESTRUCTIVE` | `COLUMNA_INDICE, FOREIGN_KEY, INDICE, NEW, OWNER, TABLA, variables` |
| `ProductsOA11i.sql` | Oracle administration helper: ProductsOA11i. | `READ_ONLY` | `variables` |
| `Queries_AnalyticExamples.sql` | Oracle administration helper: Queries AnalyticExamples. | `READ_ONLY` | `variables` |
| `Query Rpt109.sql` | Oracle administration helper: Query Rpt109. | `READ_ONLY` | `P_FECHA_DESDE, P_FECHA_HASTA, variables` |
| `ReservedAnalysis.sql` | Oracle administration helper: ReservedAnalysis. | `READ_ONLY` | `variables` |
| `SGAComponents.sql` | Oracle administration helper: SGAComponents. | `READ_ONLY` | `mi, ss, variables` |
| `SGAComponents11g.sql` | Oracle administration helper: SGAComponents11g. | `READ_ONLY` | `mi, ss, variables` |
| `SGAParameters.sql` | Oracle administration helper: SGAParameters. | `READ_ONLY` | `mi, ss, variables` |
| `SGAParameters11g.sql` | Oracle administration helper: SGAParameters11g. | `READ_ONLY` | `variables` |
| `SGAStat.sql` | Oracle administration helper: SGAStat. | `READ_ONLY` | `PLW_STR_NEW_LEN_VEC, mi, ss, variables` |
| `SQLMemory10g.sql` | Oracle administration helper: SQLMemory10g. | `READ_ONLY` | `variables` |
| `SQLMemory11g.sql` | Oracle administration helper: SQLMemory11g. | `READ_ONLY` | `variables` |
| `SQLMemory9i.sql` | Oracle administration helper: SQLMemory9i. | `READ_ONLY` | `variables` |
| `SQLVersions10g.sql` | Oracle administration helper: SQLVersions10g. | `CHANGES` | `B1, B10, B2, B3, B4, B5, B6, B7, B8, B9, dbid, variables` |
| `SQLVersions11g.sql` | Oracle administration helper: SQLVersions11g. | `READ_ONLY` | `variables` |
| `SQLVersions9i.sql` | Oracle administration helper: SQLVersions9i. | `CHANGES` | `B1, variables` |
| `SQL_Usuario_consume_mayor_recurso.sql` | Oracle administration helper: SQL Usuario consume mayor recurso. | `READ_ONLY` | `variables` |
| `SQL_actual_de_Usuario.sql` | Oracle administration helper: SQL actual de Usuario. | `READ_ONLY` | `USERNAME, variables` |
| `Script_Creac_Indices.sql` | Oracle administration helper: Script Creac Indices. | `DESTRUCTIVE` | `variables` |
| `SelectTablasExport.sql` | Oracle administration helper: SelectTablasExport. | `READ_ONLY` | `variables` |
| `TrendsLC.sql` | Oracle administration helper: TrendsLC. | `READ_ONLY` | `mi, variables` |
| `Tuns.sql` | Oracle administration helper: Tuns. | `DESTRUCTIVE` | `FREE_SPACE, MI, REQUEST_FAILURES, REQUEST_MISSES, variables` |
| `Uso_Actual_de_componentes_en_memoria.sql` | Oracle administration helper: Uso Actual de componentes en memoria. | `READ_ONLY` | `variables` |
| `Ver_posicion_indices_FK.sql` | Oracle administration helper: Ver posicion indices FK (2). | `READ_ONLY` | `variables` |
| `a_sql.sql` | Oracle administration helper: a sql. | `REVIEW` | `sql_id, variables` |
| `accessobj.sql` | Oracle administration helper: accessobj. | `READ_ONLY` | `variables` |
| `active_services.sql` | Oracle administration helper: active services. | `READ_ONLY` | `variables` |
| `add_partitions.sql` | Oracle administration helper: add partitions. | `CHANGES` | `MI, NLS_CALENDAR, SS, add_par, cnt_part, min_month, min_year, table_name, table_owner, variables` |
| `add_sql_stability_baseline.sql` | Oracle administration helper: add sql stability baseline. | `REVIEW` | `variables` |
| `addm_rep.sh` | oracle/admin utilities helper: addm rep. | `READ_ONLY` | `DEFVARIA, DIAS, FECHA, HOST, LEJEC, LOGF, MAIL, NOMBRE_BASE, ORACLE_SID, VAWR, arg1, arg2, arg3` |
| `administrar_lobs.sql` | Oracle administration helper: administrar lobs. | `CHANGES` | `variables` |
| `advisor_progress.sql` | Oracle administration helper: advisor progress. | `READ_ONLY` | `TASKID, taskid, variables` |
| `afd_refresh.sh` | Oracle administration helper: afd refresh. | `CHANGES` | `ORA_DATA_01, ORA_DATA_02, ORA_DATA_03, ORA_FRA_01` |
| `alert_log_raise_error_simula.sql` | Oracle administration helper: alert log raise error simula. | `CHANGES` | `variables` |
| `alert_log_table_create.sql` | oracle/admin utilities helper: alert log table create. | `DESTRUCTIVE` | `MI, NLS_DATE_LANGUAGE, OWNER, SS, TBS, _DB, _bdump, alert_length` |
| `alert_log_table_update.sql` | oracle/admin utilities helper: alert log table update. | `CHANGES` | `mi, ss` |
| `all_object_usage.sql` | Oracle administration helper: all object usage. | `CHANGES` | `variables` |
| `all_tab_partitions.sql` | Oracle administration helper: all tab partitions. | `DESTRUCTIVE` | `variables` |
| `all_tab_partitions_high_value.sql` | Oracle administration helper: all tab partitions high value. | `DESTRUCTIVE` | `variables` |
| `apex_config.sql` | Oracle administration helper: apex config. | `READ_ONLY` | `variables` |
| `apex_logs.sql` | Oracle administration helper: apex logs. | `READ_ONLY` | `variables` |
| `ash_sql_id_pga.sql` | Oracle administration helper: ash sql id pga. | `READ_ONLY` | `IS_SQLID_CURRENT, seconds, top, variables` |
| `ash_sql_id_pga_hist.sql` | Oracle administration helper: ash sql id pga hist. | `DESTRUCTIVE` | `IS_SQLID_CURRENT, MI, SS, days, top, variables` |
| `awr_rep.sh` | oracle/admin utilities helper: awr rep. | `READ_ONLY` | `DEFVARIA, DIAS, FECHA, HOST, LEJEC, LOGF, NOMBRE_BASE, ORACLE_SID, VAWR, arg1, arg2` |
| `awr_reports.sql` | Oracle administration helper: awr reports. | `READ_ONLY` | `days, variables` |
| `awr_sql_object_avg_dy.sql` | Oracle administration helper: awr sql object avg dy. | `READ_ONLY` | `variables` |
| `backup.sh` | Oracle administration helper: backup. | `REVIEW` | `LOGFILE, LOGPATH, arg1` |
| `backup.sql` | Oracle administration helper: backup. | `READ_ONLY` | `variables` |
| `banner.sql` | Oracle administration helper: banner(1). | `READ_ONLY` | `variables` |
| `bases.sh` | Oracle administration helper: bases. | `REVIEW` | `AMBIENTE, CRITICAL, DATFILE, HOST, LASTFIELD, MAIL_DBAS, MAIL_MSG, MAIL_OPERADORES, MAIL_TO, NOTIFICATION, ORACLE_HOME, ORACLE_SID, ORATAB, SCRIPT, SQLDBA, TIPO, TMPFILE, WARNING, arg1, arg2, arg3, arg4` |
| `bdf.sh` | Oracle administration helper: bdf. | `REVIEW` | `DIRTMP, IAM, TMPF, TMPF1, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, bilt` |
| `bind_variables_sqlplus_sql.sql` | Oracle administration helper: bind variables sqlplus sql(1). | `REVIEW` | `P_FTTH, P_OTROS_MODEMS, P_SATELITAL, variables` |
| `block_status_memory.sql` | Oracle administration helper: block status memory(1). | `READ_ONLY` | `BLOCK, FILE, variables` |
| `blocks_inBuffer.sql` | Oracle administration helper: blocks inBuffer. | `DESTRUCTIVE` | `variables` |
| `blocks_inBuffer_default.sql` | Oracle administration helper: blocks inBuffer default. | `DESTRUCTIVE` | `variables` |
| `blocks_inBuffer_keep.sql` | Oracle administration helper: blocks inBuffer keep. | `DESTRUCTIVE` | `variables` |
| `blocks_inBuffer_owner.sql` | Oracle administration helper: blocks inBuffer owner. | `DESTRUCTIVE` | `OWNER, variables` |
| `borra_tabla_cascade.sql` | Oracle administration helper: borra tabla cascade. | `DESTRUCTIVE` | `variables` |
| `borrar_crear_logs_online.sql` | Oracle administration helper: borrar crear logs online (2). | `DESTRUCTIVE` | `variables` |
| `brazil1.sql` | Oracle administration helper: brazil1. | `READ_ONLY` | `MI, variables` |
| `brazil2.sql` | Oracle administration helper: brazil2. | `READ_ONLY` | `MI, days_ago, variables` |
| `brazil3.sql` | Oracle administration helper: brazil3. | `READ_ONLY` | `CATEGORY_NAME, MI, days_ago, variables` |
| `broker_check.sh` | oracle/admin utilities helper: broker check. | `READ_ONLY` | `ORACLE_HOME, ORACLE_SID` |
| `buffer_cache_.sql` | Oracle administration helper: buffer cache (1). | `READ_ONLY` | `variables` |
| `buffer_hit_ratio.sql` | oracle/admin utilities helper: buffer hit ratio. | `READ_ONLY` | `-` |
| `cache_flush(liberar_memoria).sql` | Oracle administration helper: cache flush(liberar memoria). | `CHANGES` | `variables` |
| `calcula_estadisticas.sql` | Oracle administration helper: calcula estadisticas. | `READ_ONLY` | `CASCADE, mi, ss, variables` |
| `cant_obj_seg_pool.sql` | Oracle administration helper: cant obj seg pool. | `READ_ONLY` | `variables` |
| `cantidad_extents_objetos.sql` | Oracle administration helper: cantidad extents objetos. | `READ_ONLY` | `variables` |
| `cantidad_inserts_sql_area.sql` | Oracle administration helper: cantidad inserts sql area. | `CHANGES` | `mi, ss, variables` |
| `cdb_create.sql` | Oracle administration helper: cdb create(1). | `CHANGES` | `variables` |
| `cdb_pdbs.sql` | Oracle administration helper: cdb pdbs. | `READ_ONLY` | `variables` |
| `cdb_services.sql` | Oracle administration helper: cdb services(1). | `READ_ONLY` | `variables` |
| `chained.sql` | Oracle administration helper: chained(1). | `DESTRUCTIVE` | `variables` |
| `change_global_pref.sql` | Oracle administration helper: change global pref. | `CHANGES` | `variables` |
| `change_table_pref.sql` | Oracle administration helper: change table pref. | `CHANGES` | `variables` |
| `change_window_maitenance.sql` | oracle/admin utilities helper: change window maitenance. | `READ_ONLY` | `BYDAY, BYHOUR, BYMINUTE, BYSECOND, FREQ` |
| `changing_default_prefs.sql` | Oracle administration helper: changing default prefs. | `DESTRUCTIVE` | `variables` |
| `check_espacio.sql` | Oracle administration helper: check espacio. | `CHANGES` | `mi, ss, variables` |
| `check_global_publish_prefs.sql` | Oracle administration helper: check global publish prefs. | `READ_ONLY` | `variables` |
| `check_parallel.sql` | Oracle administration helper: check parallel. | `CHANGES` | `variables` |
| `check_products_pref.sql` | Oracle administration helper: check products pref. | `READ_ONLY` | `variables` |
| `check_publish_prefs.sql` | Oracle administration helper: check publish prefs. | `READ_ONLY` | `variables` |
| `check_sales_pref.sql` | Oracle administration helper: check sales pref. | `READ_ONLY` | `variables` |
| `check_security.sql` | oracle/admin utilities helper: check security. | `DESTRUCTIVE` | `mi, narchivo, ss` |
| `check_table_publish_prefs.sql` | Oracle administration helper: check table publish prefs. | `READ_ONLY` | `variables` |
| `check_undo.sql` | Oracle administration helper: check undo. | `READ_ONLY` | `mi, ss, variables` |
| `citi_chk_intervals.sql` | Oracle administration helper: citi chk intervals. | `READ_ONLY` | `variables` |
| `citi_health_check.sql` | Oracle administration helper: citi health check. | `CHANGES` | `variables` |
| `citi_trg_test.sql` | Oracle administration helper: citi trg test. | `DESTRUCTIVE` | `CURRENT_SCHEMA, NEW, variables` |
| `cloneDBCreation.sql` | Oracle administration helper: cloneDBCreation. | `DESTRUCTIVE` | `sysPassword, systemPassword, variables` |
| `coalesce.sql` | Oracle administration helper: coalesce. | `CHANGES` | `variables` |
| `coldBkpSols.sh` | Oracle administration helper: coldBkpSols. | `DESTRUCTIVE` | `FECHA, NOMBRE_BASE, PASSW, PTHTMP, USUARIO, VISTA_CONTROLFILES, VISTA_DATAFILES` |
| `cold_backup.sh` | Oracle administration helper: cold backup. | `DESTRUCTIVE` | `FECHA, NOMBRE_BASE, ORACLE_HOME, ORACLE_SID, PASSW, PATH, PTHTMP, USUARIO, VISTA_CONTROLFILES, VISTA_DATAFILES, VISTA_TMP_DATAFILES` |
| `commit_status.sql` | Oracle administration helper: commit status. | `READ_ONLY` | `variables` |
| `compile.sql` | Oracle administration helper: compile. | `CHANGES` | `variables` |
| `componentes.sql` | Oracle administration helper: componentes. | `READ_ONLY` | `variables` |
| `config_db_seg.sql` | Oracle administration helper: config db seg. | `DESTRUCTIVE` | `variables` |
| `const.sql` | Oracle administration helper: const. | `READ_ONLY` | `variables` |
| `const_no_index_fk.view.sql` | Oracle administration helper: const no index fk view. | `CHANGES` | `variables` |
| `consultaDBLinks.sql` | Oracle administration helper: consultaDBLinks. | `READ_ONLY` | `variables` |
| `consultas_parseos.sql` | oracle/admin utilities helper: consultas parseos. | `READ_ONLY` | `-` |
| `containers.sql` | Oracle administration helper: containers. | `READ_ONLY` | `variables` |
| `context.sql` | Oracle administration helper: context. | `READ_ONLY` | `variables` |
| `control(p1).sql` | Oracle administration helper: control(p1). | `READ_ONLY` | `variables` |
| `control.sql` | oracle/admin utilities helper: control. | `CHANGES` | `MI, SS, mi, ss` |
| `control_db.sql` | Oracle administration helper: control db. | `READ_ONLY` | `mi, ss, variables` |
| `control_dguard.sh` | oracle/admin utilities helper: control dguard. | `CHANGES` | `AGENT_HOME, AMBIENTE, DB_HOME, FILELOCK, LD_LIBRARY_PATH, LOGFILE, MAIL_DBAS, MAIL_MSG, MAIL_OPERADORES, MAIL_TO, OMS_HOME, ORACLE_BASE, ORACLE_HOME, ORACLE_SID, OWB1_HOME, OWB2_HOME, PATH, PS1, SUBJECT, TERM, TIPO, TMP, arg1, mi, ss` |
| `controlfile.sql` | Oracle administration helper: controlfile. | `READ_ONLY` | `variables` |
| `copy_sqlprof_table.sql` | Oracle administration helper: copy sqlprof table. | `REVIEW` | `schema_name, sql_profile_id, staging_table, variables` |
| `cpp4aix.ps1` | Oracle administration helper: cpp4aix. | `READ_ONLY` | `Combine, GetDirectoryName, GetFileName, INDEXX, INTTYPE, INTVL, ORACLE_PASSWORD, ORACLE_USER, PHYSS, POOLS, now` |
| `cpu_hist_per_module.sql` | Oracle administration helper: cpu hist per module. | `READ_ONLY` | `days, variables` |
| `cpu_hist_plot.sql` | Oracle administration helper: cpu hist plot. | `READ_ONLY` | `cpupercent, days, variables` |
| `cpu_test.sql` | oracle/admin utilities helper: cpu test. | `DESTRUCTIVE` | `-` |
| `crea_snapshot.sql` | Oracle administration helper: crea snapshot. | `DESTRUCTIVE` | `MI, MVIEW_NAME, RV_DOMAIN, SS, mi, ss, variables` |
| `creabase.sh` | Oracle administration helper: creabase. | `DESTRUCTIVE` | `ENTRIES, FILE, ORACLE_BASE, ORACLE_HOME, ORACLE_SID, PASSWORD` |
| `creabase.sql` | Oracle administration helper: creabase. | `DESTRUCTIVE` | `ENTRIES, FILE, PASSWORD, variables` |
| `creac_tablas_n_reg_+_particiones.sql` | Oracle administration helper: creac tablas n reg + particiones. | `CHANGES` | `variables` |
| `create_Table_connect_by_level.sql` | Oracle administration helper: create Table connect by level. | `CHANGES` | `variables` |
| `create_big_table.sql` | Oracle administration helper: create big table. | `CHANGES` | `tablename, tablename_pk, variables` |
| `create_mview.sql` | Oracle administration helper: create mview. | `CHANGES` | `INCLUDE_NEW_VALUES, PRIMARY_KEY, ROWIDS, variables` |
| `create_pdb.sqL` | Oracle administration helper: create pdb. | `CHANGES` | `ROLES, variables` |
| `create_schema_triggers_ex.sql` | Oracle administration helper: create schema triggers ex. | `CHANGES` | `variables` |
| `create_synonyms_all.sql` | Oracle administration helper: create synonyms all. | `CHANGES` | `grantee, owner, variables` |
| `create_virtual_indexes.sql` | Oracle administration helper: create virtual indexes. | `CHANGES` | `variables` |
| `createst.sql` | Oracle administration helper: createst. | `CHANGES` | `variables` |
| `crecimiento.sql` | Oracle administration helper: crecimiento. | `REVIEW` | `variables` |
| `crecimiento_base.sql` | Oracle administration helper: crecimiento base. | `READ_ONLY` | `max_inc, range, variables` |
| `crs_has_check_status.sh` | Oracle administration helper: crs has check status. | `REVIEW` | `ASM, CRS, CSS, CTSS, EVM, HAS, LOC, NAME, OCR, OH_NAME, REMOVED, SCAN, SCANLIST, VER, arg1, arg2, arg8` |
| `curl_mos.sh` | Oracle administration helper: curl mos. | `REVIEW` | `password, testssPassw` |
| `current_scn.sql` | Oracle administration helper: current scn. | `READ_ONLY` | `MI, SS, variables` |
| `current_sql.sql` | Oracle administration helper: current sql (1). | `READ_ONLY` | `variables` |
| `current_sql_hash.sql` | Oracle administration helper: current sql hash. | `READ_ONLY` | `HASH, SQL_HASH_VALUE, variables` |
| `current_sql_sid.sql` | Oracle administration helper: current sql sid (1). | `READ_ONLY` | `SID, variables` |
| `cursor_cache_hits.sql` | oracle/admin utilities helper: cursor cache hits. | `READ_ONLY` | `-` |
| `cursores.sql` | Oracle administration helper: cursores. | `READ_ONLY` | `sid, variables` |
| `cursors.sql` | oracle/admin utilities helper: cursors. | `READ_ONLY` | `-` |
| `custom.sql` | Oracle administration helper: custom. | `READ_ONLY` | `TRIGGER_NAME, variables` |
| `customizaciones.sql` | Oracle administration helper: customizaciones. | `READ_ONLY` | `variables` |
| `dataDictionaryCache.sql` | Oracle administration helper: dataDictionaryCache. | `READ_ONLY` | `variables` |
| `data_files_move_omf_online.sql` | Script para mover datafiles online (Version 12c en adelante) | `CHANGES` | `MI, SS` |
| `data_pump.sql` | Oracle administration helper: data pump. | `READ_ONLY` | `variables` |
| `data_pump_kill.sql` | Oracle administration helper: data pump kill. | `DESTRUCTIVE` | `job_name, owner, variables` |
| `database.sql` | Oracle administration helper: database. | `READ_ONLY` | `variables` |
| `database_block_corruption.sql` | Oracle administration helper: database block corruption. | `READ_ONLY` | `block_id, file_id, variables` |
| `datafile.sql` | Oracle administration helper: datafile. | `DESTRUCTIVE` | `variables` |
| `datafile_free_space.sql` | oracle/admin utilities helper: datafile free space. | `READ_ONLY` | `-` |
| `datafile_header.sql` | Oracle administration helper: datafile header. | `READ_ONLY` | `variables` |
| `datafiles.sql` | oracle/admin utilities helper: datafiles. | `DESTRUCTIVE` | `file_name, tablespace_name` |
| `datafiles_io.sql` | Oracle administration helper: datafiles io. | `READ_ONLY` | `variables` |
| `datafiles_io_gday.sql` | Oracle administration helper: datafiles io gday. | `CHANGES` | `variables` |
| `datafiles_scn.sql` | Oracle administration helper: datafiles scn. | `READ_ONLY` | `variables` |
| `datafiles_shrink.sql` | Oracle administration helper: datafiles shrink. | `CHANGES` | `DB_BLOCK_SIZE, ts_name, variables` |
| `datapump_status.sql` | Oracle administration helper: datapump status. | `READ_ONLY` | `variables` |
| `date.sql` | Oracle administration helper: date. | `READ_ONLY` | `variables` |
| `db.sql` | Oracle administration helper: db. | `READ_ONLY` | `variables` |
| `db01.sh` | Oracle administration helper: db01. | `REVIEW` | `ORACLE_SID` |
| `db01.sql` | Oracle administration helper: db01. | `REVIEW` | `sysPassword, variables` |
| `db_cache_advice.sql` | Oracle administration helper: db cache advice. | `READ_ONLY` | `variables` |
| `db_load.sql` | Oracle administration helper: db load. | `READ_ONLY` | `variables` |
| `db_object_cache.sql` | Oracle administration helper: db object cache. | `DESTRUCTIVE` | `name, owner, variables` |
| `db_object_cache_sharedpool.sql` | Oracle administration helper: db object cache sharedpool. | `READ_ONLY` | `variables` |
| `db_size.sql` | Oracle administration helper: db size. | `READ_ONLY` | `variables` |
| `db_space_hist_proc.sql` | Oracle administration helper: db space hist proc. | `DESTRUCTIVE` | `variables` |
| `db_space_hist_proc_query.sql` | Oracle administration helper: db space hist proc query. | `DESTRUCTIVE` | `variables` |
| `dba_advisor_actions.sql` | Oracle administration helper: dba advisor actions. | `READ_ONLY` | `owner, task_id, task_name, variables` |
| `dba_advisor_log.sql` | Oracle administration helper: dba advisor log. | `READ_ONLY` | `variables` |
| `dba_advisor_tasks.sql` | oracle/admin utilities helper: dba advisor tasks. | `READ_ONLY` | `ADVISORID` |
| `dba_autotask_client.sql` | Oracle administration helper: dba autotask client. | `DESTRUCTIVE` | `WINDOW_GROUP_NAME, variables` |
| `dba_autotask_statistics_11g.sql` | Oracle administration helper: dba autotask statistics 11g. | `READ_ONLY` | `days, variables` |
| `dba_capture.sql` | Oracle administration helper: dba capture. | `READ_ONLY` | `variables` |
| `dba_column_usage.sql` | Oracle administration helper: dba column usage. | `CHANGES` | `column_name, name, owner, variables` |
| `dba_constraints.sql` | Oracle administration helper: dba constraints. | `DESTRUCTIVE` | `constraint_name, constraint_type, owner, status, tabla, variables` |
| `dba_constraints_fk_non_indexes.sql` | Oracle administration helper: dba constraints fk non indexes. | `DESTRUCTIVE` | `OWNER, variables` |
| `dba_constraints_r.sql` | Oracle administration helper: dba constraints r. | `READ_ONLY` | `OWNER, TABLA, variables` |
| `dba_constraints_r_x.sql` | Oracle administration helper: dba constraints r x. | `READ_ONLY` | `OWNER, TABLA, variables` |
| `dba_constraints_x.sql` | Oracle administration helper: dba constraints x. | `READ_ONLY` | `OWNER, TABLA, variables` |
| `dba_data_files.sql` | oracle/admin utilities helper: dba data files. | `DESTRUCTIVE` | `file_name, tablespace_name` |
| `dba_data_files_fs.sql` | oracle/admin utilities helper: dba data files fs. | `READ_ONLY` | `-` |
| `dba_data_files_io.sql` | Oracle administration helper: dba data files io. | `READ_ONLY` | `variables` |
| `dba_data_files_min.sql` | Oracle administration helper: dba data files min. | `READ_ONLY` | `file_name, tablespace_name, variables` |
| `dba_data_files_shrink.sql` | Oracle administration helper: dba data files shrink. | `CHANGES` | `DB_BLOCK_SIZE, ts_name, variables` |
| `dba_data_files_shrink2.sql` | Oracle administration helper: dba data files shrink2. | `CHANGES` | `mbtoshrink, tbs, variables` |
| `dba_data_files_x.sql` | oracle/admin utilities helper: dba data files x. | `READ_ONLY` | `TABLESPACE` |
| `dba_db_links.sql` | Oracle administration helper: dba db links. | `READ_ONLY` | `db_link, host, owner, username, variables` |
| `dba_db_links_x.sql` | Oracle administration helper: dba db links x. | `READ_ONLY` | `OWNER, owner, variables` |
| `dba_dependencies.sql` | Oracle administration helper: dba dependencies. | `READ_ONLY` | `name, owner, referenced_name, referenced_owner, referenced_type, type, variables` |
| `dba_directories.sql` | Oracle administration helper: dba directories. | `READ_ONLY` | `directory_name, directory_path, variables` |
| `dba_errors.sql` | Oracle administration helper: dba errors. | `READ_ONLY` | `name, owner, text, type, variables` |
| `dba_errors_x.sql` | Oracle administration helper: dba errors x. | `READ_ONLY` | `OBJ_NAME, variables` |
| `dba_extents.sql` | Oracle administration helper: dba extents. | `READ_ONLY` | `block_id, file_id, variables` |
| `dba_feature_usage_statistics.sql` | Oracle administration helper: dba feature usage statistics. | `READ_ONLY` | `variables` |
| `dba_feature_usage_statistics_java_jvm.sql` | Oracle administration helper: dba feature usage statistics java jvm. | `READ_ONLY` | `variables` |
| `dba_hist_event_histogram_io.sql` | Oracle administration helper: dba hist event histogram io. | `READ_ONLY` | `DAYS_AGO, INST_ID, variables` |
| `dba_hist_mem_dynamic_comp_pga_sga.sql` | Oracle administration helper: dba hist mem dynamic comp pga sga. | `CHANGES` | `MI, SS, variables` |
| `dba_hist_parameter.sql` | Oracle administration helper: dba hist parameter. | `READ_ONLY` | `MI, days, instance_number, parameter_name, variables` |
| `dba_hist_pga_sga_stat_usage_hist.sql` | Oracle administration helper: dba hist pga sga stat usage hist. | `READ_ONLY` | `INSTANCE_NUMBER, MI, SS, variables` |
| `dba_hist_pgastat.sql` | Oracle administration helper: dba hist pgastat. | `READ_ONLY` | `variables` |
| `dba_hist_resource_limit.sql` | Oracle administration helper: dba hist resource limit. | `DESTRUCTIVE` | `variables` |
| `dba_hist_seg_stat.sql` | Oracle administration helper: dba hist seg stat. | `DESTRUCTIVE` | `variables` |
| `dba_hist_seg_stat_x.sql` | Oracle administration helper: dba hist seg stat x. | `READ_ONLY` | `OWNER, mm, variables` |
| `dba_hist_sgastat_shared_pool_gdaily.sql` | Oracle administration helper: dba hist sgastat shared pool gdaily. | `CHANGES` | `MI, SS, variables` |
| `dba_hist_sgastat_shared_pool_gmonth.sql` | Oracle administration helper: dba hist sgastat shared pool gmonth. | `CHANGES` | `variables` |
| `dba_hist_snapshot.sql` | Oracle administration helper: dba hist snapshot. | `CHANGES` | `MI, SS, days, variables` |
| `dba_hist_snapshot_indx_usage.sql` | Oracle administration helper: dba hist snapshot indx usage. | `READ_ONLY` | `object_name, object_owner, sqlid, variables` |
| `dba_hist_snapshot_obj_usage.sql` | Oracle administration helper: dba hist snapshot obj usage. | `READ_ONLY` | `days, object_name, object_owner, object_type, operation, sqlid, variables` |
| `dba_hist_snapshot_sqlid.sql` | Oracle administration helper: dba hist snapshot sqlid. | `DESTRUCTIVE` | `variables` |
| `dba_hist_sql_workarea_hstgrm_por_dia.sql` | Oracle administration helper: dba hist sql workarea hstgrm por dia. | `READ_ONLY` | `variables` |
| `dba_hist_sqlbind.sql` | Oracle administration helper: dba hist sqlbind. | `READ_ONLY` | `SQLID, variables` |
| `dba_hist_sqlbind_x.sql` | Oracle administration helper: dba hist sqlbind x. | `READ_ONLY` | `SQLID, SQL_ID, variables` |
| `dba_hist_sysmetric_all.sql` | Oracle administration helper: dba hist sysmetric all. | `CHANGES` | `mi, variables` |
| `dba_hist_sysmetric_history_sql_response_time.sql` | Oracle administration helper: dba hist sysmetric history sql response time. | `READ_ONLY` | `_Average, _standard_deviation, mi, variables` |
| `dba_hist_sysmetric_history_sql_response_time_js.sql` | oracle/admin utilities helper: dba hist sysmetric history sql response time js. | `READ_ONLY` | `MI, _Average, _avgplusstddev, _standard_deviation` |
| `dba_hist_sysmetric_summary.sql` | Oracle administration helper: dba hist sysmetric summary. | `CHANGES` | `mi, variables` |
| `dba_hist_sysmetric_summary_cpu_io.sql` | Oracle administration helper: dba hist sysmetric summary cpu io. | `READ_ONLY` | `MI, SS, days, variables` |
| `dba_hist_sysmetric_summary_cpu_js.sql` | oracle/admin utilities helper: dba hist sysmetric summary cpu js. | `READ_ONLY` | `MI` |
| `dba_hist_sysmetric_summary_io_js.sql` | oracle/admin utilities helper: dba hist sysmetric summary io js. | `CHANGES` | `MI` |
| `dba_hist_sysstat.sql` | Oracle administration helper: dba hist sysstat. | `CHANGES` | `MI, SS, days, stat, variables` |
| `dba_hist_system_event.sql` | Oracle administration helper: dba hist system event. | `CHANGES` | `BngTime, EndTime, event_name, variables, wait_class` |
| `dba_hist_system_event_io.sql` | Oracle administration helper: dba hist system event io. | `READ_ONLY` | `variables` |
| `dba_hist_system_event_io2.sql` | Oracle administration helper: dba hist system event io2. | `READ_ONLY` | `DAYS_AGO, variables` |
| `dba_hist_tbspc_space_usage.sql` | Oracle administration helper: dba hist tbspc space usage. | `READ_ONLY` | `variables` |
| `dba_hist_undostat.sql` | Oracle administration helper: dba hist undostat. | `READ_ONLY` | `variables` |
| `dba_hist_undostat_usagehist.sql` | oracle/admin utilities helper: dba hist undostat usagehist. | `CHANGES` | `MI, MIn, SS, SSOLDERRCNT, nospaceerrcnt, sysdate, total_usage` |
| `dba_ind_columns.sql` | Oracle administration helper: dba ind columns. | `DESTRUCTIVE` | `column_name, index_name, table_name, table_owner, variables` |
| `dba_ind_columns_x.sql` | Oracle administration helper: dba ind columns x. | `READ_ONLY` | `NOMBRE_TABLA, OWNER_TABLA, variables` |
| `dba_ind_partitions.sql` | Oracle administration helper: dba ind partitions. | `READ_ONLY` | `index_name, index_owner, partition_name, unusable, variables` |
| `dba_ind_partitions_info.sql` | Oracle administration helper: dba ind partitions info. | `READ_ONLY` | `MI, Mb, SSSSS, index_name, owner, pct_cluster, variables` |
| `dba_indexes.sql` | Oracle administration helper: dba indexes. | `READ_ONLY` | `index_name, index_owner, index_type, status, table_name, variables` |
| `dba_indexes_duplicate.sql` | Oracle administration helper: dba indexes duplicate. | `READ_ONLY` | `variables` |
| `dba_indexes_info.sql` | Oracle administration helper: dba indexes info. | `READ_ONLY` | `MI, Mb, SSSSS, index_name, owner, pct_cluster, table_name, variables` |
| `dba_indexes_invalid.sql` | Oracle administration helper: dba indexes invalid. | `READ_ONLY` | `index_name, index_owner, index_type, table_name, variables` |
| `dba_indexes_nomon.sql` | Oracle administration helper: dba indexes nomon. | `READ_ONLY` | `variables` |
| `dba_indexes_owner.sql` | Oracle administration helper: dba indexes owner (1). | `READ_ONLY` | `OWNER, Owner, variables` |
| `dba_indexes_table.sql` | Oracle administration helper: dba indexes table. | `READ_ONLY` | `TABLE, owner, variables` |
| `dba_indexes_tbs.sql` | Oracle administration helper: dba indexes tbs. | `READ_ONLY` | `TBS, variables` |
| `dba_indexes_x.sql` | Oracle administration helper: dba indexes x. | `READ_ONLY` | `INDEX, variables` |
| `dba_lobs.sql` | Oracle administration helper: dba lobs. | `READ_ONLY` | `column_name, owner, segment_name, table_name, tablespace_name, variables` |
| `dba_lobs_table.sql` | Oracle administration helper: dba lobs table. | `READ_ONLY` | `TABLE_NAME, variables` |
| `dba_lobs_x.sql` | Oracle administration helper: dba lobs x. | `READ_ONLY` | `SEGMENT_NAME, variables` |
| `dba_lock.sql` | Oracle administration helper: dba lock. | `READ_ONLY` | `variables` |
| `dba_mview_logs.sql` | Oracle administration helper: dba mview logs. | `READ_ONLY` | `variables` |
| `dba_mview_refresh_times.sql` | Oracle administration helper: dba mview refresh times. | `READ_ONLY` | `variables` |
| `dba_mviews.sql` | Oracle administration helper: dba mviews. | `READ_ONLY` | `variables` |
| `dba_object_size.sql` | Oracle administration helper: dba object size. | `READ_ONLY` | `owner, variables` |
| `dba_objects.sql` | Oracle administration helper: dba objects. | `READ_ONLY` | `obj_name, object_type, owner, variables` |
| `dba_objects_invalid.sql` | Oracle administration helper: dba objects invalid. | `CHANGES` | `object_name, object_type, owner, variables` |
| `dba_objects_invalid_gowner.sql` | Oracle administration helper: dba objects invalid gowner. | `READ_ONLY` | `owner, variables` |
| `dba_objects_invalid_owner.sql` | Oracle administration helper: dba objects invalid owner. | `CHANGES` | `owner, variables` |
| `dba_objects_owner.sql` | Oracle administration helper: dba objects owner. | `READ_ONLY` | `OWNER, variables` |
| `dba_objects_tbs.sql` | Oracle administration helper: dba objects tbs. | `READ_ONLY` | `TBS, variables` |
| `dba_objects_x.sql` | Oracle administration helper: dba objects x. | `READ_ONLY` | `OBJ_NAME, OWNER, variables` |
| `dba_outstanding_alerts.sql` | Oracle administration helper: dba outstanding alerts. | `READ_ONLY` | `mi, variables` |
| `dba_part_Tables.sql` | Oracle administration helper: dba part Tables. | `READ_ONLY` | `owner, partition_count, partitioning_type, status, subpartitioning_type, table_name, variables` |
| `dba_part_indexes.sql` | Oracle administration helper: dba part indexes. | `READ_ONLY` | `index_name, owner, table_name, variables` |
| `dba_part_key_columns.sql` | Oracle administration helper: dba part key columns. | `READ_ONLY` | `column_name, data_type, name, object_type, owner, variables` |
| `dba_part_key_columns_x.sql` | Oracle administration helper: dba part key columns x. | `READ_ONLY` | `NAME, OWNER, variables` |
| `dba_pdb_saved_states.sql` | Oracle administration helper: dba pdb saved states. | `READ_ONLY` | `variables` |
| `dba_pending_transactions.sql` | Oracle administration helper: dba pending transactions. | `READ_ONLY` | `variables` |
| `dba_policies.sql` | Oracle administration helper: dba policies. | `READ_ONLY` | `variables` |
| `dba_procedures.sql` | Oracle administration helper: dba procedures. | `DESTRUCTIVE` | `object_id, object_name, procedure_name, subprogram_id, variables` |
| `dba_proxies.sql` | Oracle administration helper: dba proxies. | `CHANGES` | `variables` |
| `dba_recyclebin.sql` | Oracle administration helper: dba recyclebin. | `DESTRUCTIVE` | `variables` |
| `dba_recyclebin_tbs.sql` | Oracle administration helper: dba recyclebin tbs. | `READ_ONLY` | `TBS, variables` |
| `dba_registry.sql` | Oracle administration helper: dba registry. | `READ_ONLY` | `variables` |
| `dba_registry_history.sql` | Oracle administration helper: dba registry history. | `READ_ONLY` | `variables` |
| `dba_registry_sqlpatch.sql` | Oracle administration helper: dba registry sqlpatch. | `DESTRUCTIVE` | `variables` |
| `dba_registry_sqlpatch_12.sql` | Oracle administration helper: dba registry sqlpatch 12. | `DESTRUCTIVE` | `INSTALL_ID, variables` |
| `dba_rollback_segs.sql` | Oracle administration helper: dba rollback segs. | `READ_ONLY` | `variables` |
| `dba_segments.sql` | Oracle administration helper: dba segments (1). | `READ_ONLY` | `variables` |
| `dba_segments_compactar.sql` | Oracle administration helper: dba segments compactar. | `CHANGES` | `ENTER_OWNER_NAME, ENTER_TABLE_NAME, variables` |
| `dba_segments_gowner.sql` | Oracle administration helper: dba segments gowner (1). | `READ_ONLY` | `variables` |
| `dba_segments_index.sql` | Oracle administration helper: dba segments index. | `READ_ONLY` | `OWNER, segment_name, variables` |
| `dba_segments_owner.sql` | Oracle administration helper: dba segments owner. | `READ_ONLY` | `OWNER, variables` |
| `dba_segments_tbs.sql` | Oracle administration helper: dba segments tbs (1). | `READ_ONLY` | `TABLESPACE, Tablespace, variables` |
| `dba_segments_x.sql` | Oracle administration helper: dba segments x (1). | `READ_ONLY` | `OBJ_NAME, variables` |
| `dba_services.sql` | Oracle administration helper: dba services. | `DESTRUCTIVE` | `variables` |
| `dba_source.sql` | Oracle administration helper: dba source. | `READ_ONLY` | `obj_name, owner, text, variables` |
| `dba_source_x.sql` | Oracle administration helper: dba source x. | `READ_ONLY` | `obj_name, owner, variables` |
| `dba_source_x_like.sql` | Oracle administration helper: dba source x like. | `READ_ONLY` | `LIKE, OBJ_NAME, OWNER, variables` |
| `dba_source_x_line.sql` | Oracle administration helper: dba source x line. | `READ_ONLY` | `LINEA, OBJ_NAME, OWNER, variables` |
| `dba_source_x_line_beet.sql` | Oracle administration helper: dba source x line beet. | `READ_ONLY` | `LINEA1, LINEA2, OBJ_NAME, OWNER, variables` |
| `dba_sql_patches.sql` | oracle/admin utilities helper: dba sql patches. | `DESTRUCTIVE` | `-` |
| `dba_sqlset.sql` | oracle/admin utilities helper: dba sqlset. | `READ_ONLY` | `-` |
| `dba_stat_extensions.sql` | Oracle administration helper: dba stat extensions. | `DESTRUCTIVE` | `variables` |
| `dba_synonyms.sql` | Oracle administration helper: dba synonyms. | `DESTRUCTIVE` | `owner, synonym_name, table_name, table_owner, variables` |
| `dba_synonyms_x.sql` | Oracle administration helper: dba synonyms x. | `READ_ONLY` | `OWNER, owner, variables` |
| `dba_tab_col_statistics.sql` | Oracle administration helper: dba tab col statistics. | `DESTRUCTIVE` | `column_name, data_type, owner, table_name, variables` |
| `dba_tab_columns.sql` | Oracle administration helper: dba tab columns. | `READ_ONLY` | `column_name, data_type, owner, table_name, variables` |
| `dba_tab_columns_x.sql` | Oracle administration helper: dba tab columns x. | `READ_ONLY` | `column_name, owner, table_name, variables` |
| `dba_tab_comments_x.sql` | Oracle administration helper: dba tab comments x. | `READ_ONLY` | `OWNER, TABLA, variables` |
| `dba_tab_histograms.sql` | Oracle administration helper: dba tab histograms. | `READ_ONLY` | `column_name, owner, table_name, variables` |
| `dba_tab_modifications.sql` | Oracle administration helper: dba tab modifications. | `CHANGES` | `table_name, table_owner, variables` |
| `dba_tab_part_seg.sql` | Oracle administration helper: dba tab part seg. | `READ_ONLY` | `OWNER, variables` |
| `dba_tab_part_sub_count.sql` | Oracle administration helper: dba tab part sub count. | `READ_ONLY` | `table_owner, variables` |
| `dba_tab_partitions.sql` | Oracle administration helper: dba tab partitions. | `DESTRUCTIVE` | `partition_name, table_name, table_owner, tablespace_name, variables` |
| `dba_tab_partitions_owner.sql` | Oracle administration helper: dba tab partitions owner. | `READ_ONLY` | `OWNER, variables` |
| `dba_tab_partitions_size.sql` | Oracle administration helper: dba tab partitions size. | `READ_ONLY` | `owner, table_name, variables` |
| `dba_tab_partitions_x.sql` | Oracle administration helper: dba tab partitions x. | `READ_ONLY` | `partition_name, table_name, table_owner, tablespace_name, variables` |
| `dba_tab_statistics.sql` | Oracle administration helper: dba tab statistics. | `READ_ONLY` | `OWNER, variables` |
| `dba_tab_subpartitions.sql` | Oracle administration helper: dba tab subpartitions. | `READ_ONLY` | `partition_name, subpartition_name, table_name, table_owner, tablespace_name, variables` |
| `dba_tab_subpartitions_sum_size.sql` | Oracle administration helper: dba tab subpartitions sum size. | `DESTRUCTIVE` | `variables` |
| `dba_tables.sql` | oracle/admin utilities helper: dba tables. | `READ_ONLY` | `owner, table_name` |
| `dba_tables_owner.sql` | Oracle administration helper: dba tables owner (1). | `READ_ONLY` | `OWNER, Owner, variables` |
| `dba_tables_owner_tbs.sql` | Oracle administration helper: dba tables owner tbs (1). | `READ_ONLY` | `OWNER, Owner, TABLESPACE, Tablespace, variables` |
| `dba_tables_porcent_estad.sql` | Oracle administration helper: dba tables porcent estad (1). | `READ_ONLY` | `variables` |
| `dba_tables_tbs.sql` | Oracle administration helper: dba tables tbs (1). | `READ_ONLY` | `TABLESPACE, Tablespace, variables` |
| `dba_tables_x.sql` | oracle/admin utilities helper: dba tables x. | `READ_ONLY` | `TNAME` |
| `dba_temp_files.sql` | oracle/admin utilities helper: dba temp files. | `READ_ONLY` | `-` |
| `dba_triggers.sql` | Oracle administration helper: dba triggers. | `READ_ONLY` | `owner, status, table_name, table_owner, trigger_name, variables` |
| `dba_triggers_logon.sql` | Oracle administration helper: dba triggers logon. | `DESTRUCTIVE` | `variables` |
| `dba_triggers_owner.sql` | Oracle administration helper: dba triggers owner (1). | `READ_ONLY` | `OWNER, variables` |
| `dba_triggers_x.sql` | Oracle administration helper: dba triggers x (1). | `READ_ONLY` | `TRIGGER, variables` |
| `dba_ts_quotas.sql` | Oracle administration helper: dba ts quotas. | `READ_ONLY` | `tablespace_name, username, variables` |
| `dba_undo_extents.sql` | Oracle administration helper: dba undo extents. | `READ_ONLY` | `variables` |
| `dba_views_x.sql` | Oracle administration helper: dba views x. | `READ_ONLY` | `OWNER, VISTA, variables` |
| `dbasnapshot_database_10g.sql` | oracle/admin utilities helper: dbasnapshot database 10g. | `DESTRUCTIVE` | `BGCOLOR, BORDER, Black, FileName, MI, SS, WIDTH, White, _blocksize, _date_time, _dbname, _global_name, _reportRunUser, _spool_time, _startup_time, black, bold, reportHeader, statsPackUser, top` |
| `dbctrl10g.sql` | Oracle administration helper: dbctrl10g. | `READ_ONLY` | `mi, ss, variables` |
| `dbctrl9i.sql` | Oracle administration helper: dbctrl9i. | `READ_ONLY` | `mi, ss, variables` |
| `dbinfo.sql` | Oracle administration helper: dbinfo. | `READ_ONLY` | `variables` |
| `dblink_create.sql` | Oracle administration helper: dblink create. | `DESTRUCTIVE` | `p_dblinkalias, p_dblinkname, p_dblinkpassword, p_dblinkuser, p_owner, v_count, variables` |
| `dblink_drop.sql` | Oracle administration helper: dblink drop. | `DESTRUCTIVE` | `p_dblinkname, p_owner, v_count, variables` |
| `dblinks.sql` | Oracle administration helper: dblinks. | `DESTRUCTIVE` | `variables` |
| `dbms_advisor_create_task.sql` | Oracle administration helper: dbms advisor create task. | `CHANGES` | `EJECJOB, advtype, indexn, numDaysToRetain, scheman, tablen, taskdesc, taskname, tbsname, timelimit, variables` |
| `dbms_datapump.examples.sql` | Oracle administration helper: dbms datapump examples. | `DESTRUCTIVE` | `variables` |
| `dbms_network_acl_admin_ex.sql` | Oracle administration helper: dbms network acl admin ex. | `DESTRUCTIVE` | `variables` |
| `dbms_perf.report_sql.sql` | Oracle administration helper: dbms perf report sql. | `READ_ONLY` | `mi, ss, variables` |
| `dbms_resource_manager.pga.sql` | Oracle administration helper: dbms resource manager pga. | `CHANGES` | `variables` |
| `dbms_service_create_service.sql` | Oracle administration helper: dbms service create service. | `CHANGES` | `serv_name, variables` |
| `dbms_service_status_start.sql` | Oracle administration helper: dbms service status start. | `DESTRUCTIVE` | `ORACLE_SID, ORAENV_ASK, PATH, arg8, variables` |
| `dbms_space_cost.sql` | Oracle administration helper: dbms space cost (1). | `CHANGES` | `variables` |
| `dbms_space_recommendations.sql` | Oracle administration helper: dbms space recommendations (1). | `READ_ONLY` | `variables` |
| `dbms_space_recommendations_sql.sql` | Oracle administration helper: dbms space recommendations sql. | `CHANGES` | `variables` |
| `dbms_sqldiag.create_sql_patch.sql` | Oracle administration helper: dbms sqldiag create sql patch. | `CHANGES` | `arg1, arg58, variables` |
| `dbms_utility.compile_schema.sql` | Oracle administration helper: dbms utility compile schema. | `CHANGES` | `schema_name, variables` |
| `dc_perf_report_sqlid.sql` | Oracle administration helper: dc perf report sqlid. | `CHANGES` | `MI, SS, minutes, variables` |
| `dc_recomp_obj_01.sql` | Oracle administration helper: dc recomp obj 01. | `CHANGES` | `variables` |
| `decrease_data_files.sql` | oracle/admin utilities helper: decrease data files. | `CHANGES` | `p_tablespace_name` |
| `desc_table.sql` | Oracle administration helper: desc table. | `READ_ONLY` | `TOWNER, TTABLE, towner, ttable, variables` |
| `desc_table_const.sql` | oracle/admin utilities helper: desc table const. | `READ_ONLY` | `OWNER, R_CONSTRAINT_NAME, TABLA, TABLE, TOWNER, TTABLE, towner, ttable` |
| `df_usage_greater_than.sh` | Oracle administration helper: df usage greater than. | `REVIEW` | `arg5` |
| `diag_alert_ext.sql` | Oracle administration helper: diag alert ext. | `DESTRUCTIVE` | `mi, ss, variables` |
| `diag_info.sql` | Oracle administration helper: diag info. | `READ_ONLY` | `variables` |
| `dict.sql` | Oracle administration helper: dict. | `READ_ONLY` | `variables` |
| `dictionary_hit_ratio.sql` | oracle/admin utilities helper: dictionary hit ratio. | `READ_ONLY` | `-` |
| `dictionary_x.sql` | Oracle administration helper: dictionary x. | `READ_ONLY` | `TABLA, variables` |
| `diff_parameters.sql` | oracle/admin utilities helper: diff parameters. | `READ_ONLY` | `-` |
| `discoverer.sql` | Oracle administration helper: discoverer. | `CHANGES` | `variables` |
| `dot_ori_orig.sql` | Oracle administration helper: dot ori orig. | `READ_ONLY` | `variables` |
| `dp_backup.sh` | # | `DESTRUCTIVE` | `ACTION, AMBIENTE, BO_ACTION, HOST, LOGFILE, MAIL_DBAS, MAIL_MSG, MAIL_OPERADORES, MAIL_TO, NARG, ORACLE_SID, TIPO, TYPE, TYPE_COLD, TYPE_HOT, T_ACTION, USAGE, arg1, arg2, arg3` |
| `drop_context_queue_tables.sql` | Oracle administration helper: drop context queue tables (1). | `DESTRUCTIVE` | `variables` |
| `drop_db_link.sql` | Oracle administration helper: drop db link. | `DESTRUCTIVE` | `owner, variables` |
| `drop_tbs_temp.sql` | Oracle administration helper: drop tbs temp (1). | `DESTRUCTIVE` | `variables` |
| `dumpfile_header.sql` | Oracle administration helper: dumpfile header. | `CHANGES` | `variables` |
| `dumping_block.sql` | Oracle administration helper: dumping block. | `CHANGES` | `variables` |
| `dw_vpd_admin.dw_access_policy.sql` | Oracle administration helper: dw vpd admin dw access policy. | `REVIEW` | `variables` |
| `ejemplo_procedure_sun_desa.sql` | Oracle administration helper: ejemplo procedure sun desa. | `DESTRUCTIVE` | `variables` |
| `em_metric_daily_tbs_usage.sql` | Oracle administration helper: em metric daily tbs usage. | `READ_ONLY` | `target_name, variables` |
| `emcli.relocate_targets.sh` | Oracle administration helper: emcli relocate targets. | `REVIEW` | `-` |
| `emctl_commands.sh` | Oracle administration helper: emctl commands. | `READ_ONLY` | `arg8, oracle_database, oracle_pdb` |
| `estadistica_segmentos.sql` | Oracle administration helper: estadistica segmentos. | `CHANGES` | `variables` |
| `estadisticas-usuarios.sql` | Oracle administration helper: estadisticas usuarios. | `READ_ONLY` | `variables` |
| `eul.sql` | Oracle administration helper: eul. | `CHANGES` | `variables` |
| `eventmetric_io.sql` | Oracle administration helper: eventmetric io. | `READ_ONLY` | `variables` |
| `events.sql` | Oracle administration helper: events (1). | `REVIEW` | `variables` |
| `exa.io.mystat.sql` | Oracle administration helper: exa io mystat. | `READ_ONLY` | `variables` |
| `exa.test.smart_scan.sql` | Oracle administration helper: exa test smart scan. | `DESTRUCTIVE` | `variables` |
| `exit.sql` | Oracle administration helper: exit. | `REVIEW` | `variables` |
| `exp_active.sql` | Oracle administration helper: exp active. | `READ_ONLY` | `db_sid, schema, variables` |
| `exp_avg.sql` | Oracle administration helper: exp avg. | `READ_ONLY` | `schema_name, variables` |
| `exp_env.sql` | Oracle administration helper: exp env. | `CHANGES` | `MI, variables` |
| `exp_eom.sql` | Oracle administration helper: exp eom. | `READ_ONLY` | `db_sid, variables` |
| `exp_files.sql` | Oracle administration helper: exp files. | `READ_ONLY` | `JOB_ID, variables` |
| `exp_gantt.sql` | Oracle administration helper: exp gantt. | `READ_ONLY` | `MI, sid, variables` |
| `exp_r.sql` | Oracle administration helper: exp r. | `CHANGES` | `MI, variables` |
| `exp_sizing.sql` | Oracle administration helper: exp sizing. | `READ_ONLY` | `variables` |
| `exp_total.sql` | Oracle administration helper: exp total. | `READ_ONLY` | `schema_name, variables` |
| `expdp_database.sh` | Oracle administration helper: expdp database. | `CHANGES` | `AMBIENTE, DIR, DIRDB, DUMPFILE, FECHA, FILE, LD_LIBRARY_PATH, LOGFILE, MAIL_DBAS, MAIL_MSG, MAIL_OPERADORES, MAIL_TO, NLS_LANG, ORACLE_HOME, ORACLE_SID, OWNERR, PATH, PREF, RETENTION, TIPO, ZIPF, arg1, arg2, arg3, arg4, arg5, arg6` |
| `explain.sql` | Oracle administration helper: explain. | `CHANGES` | `CHILD, SQL_ID, v_sys_b_0, v_sys_b_1, v_sys_b_2, v_sys_b_3, v_sys_b_4, v_sys_b_5, v_sys_b_6, v_sys_b_7, variables` |
| `explain_outline.sql` | Oracle administration helper: explain outline. | `READ_ONLY` | `query, variables` |
| `explain_sqls.sql` | oracle/admin utilities helper: explain sqls. | `CHANGES` | `-` |
| `export+cold.sh` | Oracle administration helper: export+cold. | `DESTRUCTIVE` | `DIRECT_BACKUP, FECHA, NOMBRE_BASE, ORACLE_BASE, ORACLE_HOME, ORACLE_SID, PASSW, PATH, PATH_LOGS, PTHTMP, USUARIO, VISTA_CONTROLFILES, VISTA_DATAFILES` |
| `export_owner.sh` | Oracle administration helper: export owner. | `CHANGES` | `AMBIENTE, DIR, DUMPFILE, FECHA, FILE, LOGFILE, MAIL_DBAS, MAIL_MSG, MAIL_OPERADORES, MAIL_TO, NLS_LANG, ORACLE_SID, OWNERR, PREF, RETENTION, TIPO, ZIPF, arg1, arg2, arg3, arg4` |
| `filestat_tbs.sql` | Oracle administration helper: filestat tbs. | `READ_ONLY` | `variables` |
| `find_files_by_date.sh` | Oracle administration helper: find files by date. | `REVIEW` | `-` |
| `find_grep_sqlnet_params.sh` | Oracle administration helper: find grep sqlnet params. | `CHANGES` | `-` |
| `find_sql.sql` | Oracle administration helper: find sql. | `DESTRUCTIVE` | `parsing_schema_name, sql_id, sql_text, variables` |
| `find_sql_mem.sql` | Oracle administration helper: find sql mem. | `DESTRUCTIVE` | `parsing_schema_name, sql_id, sql_text, variables` |
| `find_unique_date.sh` | Oracle administration helper: find unique date. | `CHANGES` | `-` |
| `flash_recovery_area_usage.sql` | Oracle administration helper: flash recovery area usage. | `READ_ONLY` | `variables` |
| `flashback.sql` | Oracle administration helper: flashback. | `CHANGES` | `variables` |
| `flashback_database_log.sql` | Oracle administration helper: flashback database log. | `READ_ONLY` | `variables` |
| `flashback_database_logfile.sql` | Oracle administration helper: flashback database logfile. | `READ_ONLY` | `variables` |
| `flashback_original.sql` | Oracle administration helper: flashback original. | `DESTRUCTIVE` | `HH24, MI, SS, as, fb_scn, fb_timestamp, unable, variables` |
| `flashback_query.sql` | Oracle administration helper: flashback query. | `CHANGES` | `variables` |
| `flush_shared_pool_sqlid.sql` | Oracle administration helper: flush shared pool sqlid. | `DESTRUCTIVE` | `sql_id, variables` |
| `formatofecha.sql` | Oracle administration helper: formatofecha. | `CHANGES` | `mi, ss, variables` |
| `fra.sql` | Oracle administration helper: fra. | `READ_ONLY` | `variables` |
| `free_memory.sql` | Oracle administration helper: free memory. | `READ_ONLY` | `variables` |
| `full.sh` | Oracle administration helper: full (1). | `CHANGES` | `-` |
| `full.sql` | Oracle administration helper: full (1). | `CHANGES` | `variables` |
| `gardw_eul_purge.sh` | # | `DESTRUCTIVE` | `FECHA, LOGFILE, ORACLE_SID, mi, ss` |
| `get_bytes_part_range.sql` | Oracle administration helper: get bytes part range. | `CHANGES` | `variables` |
| `get_db_information.sql` | oracle/admin utilities helper: get db information. | `CHANGES` | `ALIGN, COLSPAN, CONTENT, EQUIV, MI, SS, White, absolute, auto, black, bold, dbname, hidden, mi, nbsp, nth, report_name, ss, suffix, timestamp, top` |
| `get_ddl.sql` | Oracle administration helper: get ddl (1). | `READ_ONLY` | `NAME, OWNER, TYPE, variables` |
| `get_ddl_index.sql` | Oracle administration helper: get ddl index. | `CHANGES` | `OWNER, variables` |
| `get_ddl_mail.sql` | Oracle administration helper: get ddl mail. | `READ_ONLY` | `MI, SS, addr, object, owner, type, variables` |
| `get_ddl_owner.sql` | Oracle administration helper: get ddl owner. | `READ_ONLY` | `OWNER, variables` |
| `get_ddl_rol.sql` | Oracle administration helper: get ddl rol (1). | `CHANGES` | `ROLE, variables` |
| `get_ddl_table.sql` | Oracle administration helper: get ddl table. | `READ_ONLY` | `owner, table_name, variables` |
| `get_pparameters_db.sql` | oracle/admin utilities helper: get pparameters db. | `READ_ONLY` | `-` |
| `get_row_block_id.sql` | Oracle administration helper: get row block id. | `READ_ONLY` | `variables` |
| `get_view_text.sql` | Oracle administration helper: get view text. | `CHANGES` | `owner, spoolname, variables, viewname` |
| `getddl.sql` | Oracle administration helper: getddl. | `READ_ONLY` | `variables` |
| `ggs_checkpoint.sql` | Oracle administration helper: ggs checkpoint. | `READ_ONLY` | `variables` |
| `gi_reconfig_setup.sh` | Oracle administration helper: gi reconfig setup. | `CHANGES` | `INVENTORY_LOCATION, ORACLE_BASE, ORACLE_HOME, ORACLE_OWNER, OSASM, OSDBA, OSOPER, SELECTED_LANGUAGES` |
| `GG_create_HBT.sql` | Oracle administration helper: GG create HBT. | `DESTRUCTIVE` | `MI, NLS_DATE_FORMAT, SQL, SS, SSxFF, variables` |
| `XAG_managed.sh` | Oracle administration helper: XAG managed. | `REVIEW` | `-` |
| `gg_stop_drop_capture.sql` | Oracle administration helper: gg stop drop capture. | `DESTRUCTIVE` | `variables` |
| `infocredentialstore.sh` | Oracle administration helper: infocredentialstore. | `REVIEW` | `-` |
| `ogg_12102_health_check.sql` | Oracle administration helper: ogg 12102 health check. | `DESTRUCTIVE` | `AQ_TM_PROCESSES, FREQ, GRANT_SELECT_PRIVILEGES, HH24, MI, Mi, PRIVILEGE_TYPE, SS, SSxFF, age_threshold, hcversion, lag_threshold, v_table_name, variables` |
| `prm_parsing.sh` | Oracle administration helper: prm parsing. | `CHANGES` | `arg10` |
| `gpswd.sql` | Oracle administration helper: gpswd. | `READ_ONLY` | `variables` |
| `grep_recover_until_change_alert.sh` | Oracle administration helper: grep recover until change alert. | `DESTRUCTIVE` | `arg2, arg3, arg4` |
| `grid_notification_rules.sql` | Oracle administration helper: grid notification rules. | `READ_ONLY` | `metric_column, metric_name, owner, rule_name, target_name, target_type, variables` |
| `grupo_refresh.sql` | Oracle administration helper: grupo refresh. | `REVIEW` | `MI, SS, variables` |
| `hcheck.sql` | oracle/admin utilities helper: hcheck. | `DESTRUCTIVE` | `ABS, ATTR_NAME, BLOCK, BLOCKS, CNT, DOBJ, FAILURE, NAME, OBJ, OPTION, PARTCNT, RFILE, SUCCESS, TYPE, obj` |
| `unnest.sql` | Oracle administration helper: unnest. | `CHANGES` | `variables` |
| `hit_ratios.sql` | Oracle administration helper: hit ratios. | `CHANGES` | `variables` |
| `hot_blocks2.sql` | Oracle administration helper: hot blocks2. | `CHANGES` | `ADDR_Value, variables` |
| `hout.sql` | oracle/admin utilities helper: hout. | `CHANGES` | `-` |
| `hugepages_settings.sh` | Oracle administration helper: hugepages settings. | `READ_ONLY` | `HPG_SZ, HUGETLB_POOL, KERN, MIN_PG, NUM_PG, RES_BYTES, arg1, arg2` |
| `i_create_patch_12.1.sql` | Oracle administration helper: i create patch 12 1. | `CHANGES` | `variables` |
| `imp_r.sql` | Oracle administration helper: imp r. | `DESTRUCTIVE` | `variables` |
| `impdp_sqlfile.sh` | Oracle administration helper: impdp sqlfile. | `REVIEW` | `CONTENT, DIRECTORY, INCLUDE` |
| `import_sqlprof_table.sql` | Oracle administration helper: import sqlprof table. | `REVIEW` | `schema_name, staging_table, variables` |
| `indices_cache.sql` | Oracle administration helper: indices cache. | `CHANGES` | `variables` |
| `indices_sin_usar.sql` | Oracle administration helper: indices sin usar. | `READ_ONLY` | `variables` |
| `informe_base.sql` | Oracle administration helper: informe base. | `CHANGES` | `ALIGN, BGCOLOR, BORDER, CELLPADDING, COLOR, COLSPAN, CONTENT, EQUIV, FACE, MI, SIZE, SS, WIDTH, nbsp, variables` |
| `initial_rsrc_consumer_group.sql` | Oracle administration helper: initial rsrc consumer group. | `READ_ONLY` | `variables` |
| `inodos_find_files_x_folder.sh` | Oracle administration helper: inodos find files x folder. | `REVIEW` | `-` |
| `inserts_x_min.sql` | Oracle administration helper: inserts x min. | `CHANGES` | `MI, SS, variables` |
| `instance.sql` | Oracle administration helper: instance. | `READ_ONLY` | `variables` |
| `instance_exit.sql` | Oracle administration helper: instance exit. | `READ_ONLY` | `variables` |
| `internal_params.sql` | Oracle administration helper: internal params. | `READ_ONLY` | `variables` |
| `invalid_number_detector.sql` | Oracle administration helper: invalid number detector. | `READ_ONLY` | `variables` |
| `iot_tables.sql` | Oracle administration helper: iot tables. | `READ_ONLY` | `variables` |
| `iotop.sh` | Oracle administration helper: iotop. | `REVIEW` | `-` |
| `jar_jdbc_tester.sh` | Oracle administration helper: jar jdbc tester. | `REVIEW` | `oracle, thin` |
| `java_check_usage.sql` | Oracle administration helper: java check usage. | `READ_ONLY` | `variables` |
| `java_recompile.sql` | Oracle administration helper: java recompile. | `CHANGES` | `JOB_QUEUE_PROCESSES, variables` |
| `java_test.sql` | Oracle administration helper: java test. | `READ_ONLY` | `variables` |
| `keep_procedure.sql` | Oracle administration helper: keep procedure (1). | `DESTRUCTIVE` | `MI, NEW, SS, mi, ss, variables` |
| `left_to_do.sql` | Oracle administration helper: left to do. | `READ_ONLY` | `variables` |
| `lfsdiag.sql` | oracle/admin utilities helper: lfsdiag. | `CHANGES` | `dbname, mi, ss, suffix, threshold, timestamp` |
| `liberar_espacio_objetos.sql` | Oracle administration helper: liberar espacio objetos. | `CHANGES` | `variables` |
| `liberar_memoria_q_ya_no_se_esta_utilizando_en_sesion.sql` | Oracle administration helper: liberar memoria q ya no se esta utilizando en sesion. | `CHANGES` | `variables` |
| `library_cache_hit_ratio.sql` | Oracle administration helper: library cache hit ratio. | `READ_ONLY` | `variables` |
| `library_miss_ratio.sql` | oracle/admin utilities helper: library miss ratio. | `READ_ONLY` | `-` |
| `librarycache.sql` | Oracle administration helper: librarycache. | `READ_ONLY` | `variables` |
| `licence.sql` | Oracle administration helper: licence. | `READ_ONLY` | `variables` |
| `link_base_table.sql` | Oracle administration helper: link$. | `READ_ONLY` | `authusr, host, name, password, userid, variables` |
| `linux_diskcheck.sh` | Oracle administration helper: linux diskcheck. | `DESTRUCTIVE` | `arg1, arg12, arg2, arg3, arg4, arg5` |
| `linux_split_file.sh` | Oracle administration helper: linux split file. | `REVIEW` | `-` |
| `list_files.sql` | Oracle administration helper: list files. | `CHANGES` | `variables` |
| `lista_posic_column_dif.sql` | Oracle administration helper: lista posic column dif. | `CHANGES` | `variables` |
| `listener_log_grep_errors.sh` | Oracle administration helper: listener log grep errors. | `READ_ONLY` | `-` |
| `listener_log_grep_logins.sh` | Oracle administration helper: listener log grep logins. | `REVIEW` | `BASE, FECHA, HORA, arg1, arg2` |
| `literals_sqlarea.sql` | Oracle administration helper: literals sqlarea. | `READ_ONLY` | `variables` |
| `lock_mode_p1.sql` | Oracle administration helper: lock mode p1. | `CHANGES` | `p1, variables` |
| `lock_rows.sql` | Oracle administration helper: lock rows. | `DESTRUCTIVE` | `object_name, owner, variables, waiting_sid` |
| `locked_object.sql` | Oracle administration helper: locked object. | `READ_ONLY` | `variables` |
| `lockedobjects.sql` | Oracle administration helper: lockedobjects. | `READ_ONLY` | `variables` |
| `locko.sql` | Oracle administration helper: locko. | `READ_ONLY` | `variables` |
| `lockobj.sql` | Oracle administration helper: lockobj. | `READ_ONLY` | `variables` |
| `locks.sql` | Oracle administration helper: locks. | `READ_ONLY` | `ADDR, ID1, ID2, LATCH, ROW, THREAD, TYPE, variables` |
| `locks1.sql` | Oracle administration helper: locks1. | `READ_ONLY` | `variables` |
| `locks10g.sql` | Oracle administration helper: locks10g. | `READ_ONLY` | `variables` |
| `locks2.sql` | Oracle administration helper: locks2. | `READ_ONLY` | `variables` |
| `locks3.sql` | Display database locks and latches (with tables names, etc) | `READ_ONLY` | `ADDR, ID1, ID2, LATCH, ROW, THREAD, TYPE` |
| `log.sql` | Oracle administration helper: log. | `READ_ONLY` | `variables` |
| `log_history.sql` | Oracle administration helper: log history. | `CHANGES` | `MI, SS, first_time, variables` |
| `log_history_sum.sql` | Oracle administration helper: log history sum. | `READ_ONLY` | `variables` |
| `log_switch_history.sql` | oracle/admin utilities helper: log switch history. | `CHANGES` | `days` |
| `log_switch_history_2.sql` | Oracle administration helper: log switch history 2. | `CHANGES` | `variables` |
| `logfile.sql` | Oracle administration helper: logfile. | `READ_ONLY` | `variables` |
| `longops10g.sql` | Oracle administration helper: longops10g. | `READ_ONLY` | `variables` |
| `lsoh.sh` | Oracle administration helper: lsoh. | `REVIEW` | `CENTRAL_ORAINV, IFS, LOC, NAME, OH_NAME, ORAEDITION, ORAMAJOR, ORAVERSION, VER, arg2` |
| `max_lob_size.sql` | Oracle administration helper: max lob size. | `READ_ONLY` | `variables` |
| `maxlengthcolumn.sql` | Oracle administration helper: maxlengthcolumn. | `CHANGES` | `variables` |
| `mem_pga.sql` | Oracle administration helper: mem pga. | `READ_ONLY` | `variables` |
| `mem_pool.sql` | Oracle administration helper: mem pool. | `READ_ONLY` | `variables` |
| `mem_sharedpool.sql` | Oracle administration helper: mem sharedpool. | `READ_ONLY` | `variables` |
| `mem_sharedpool1.sql` | oracle/admin utilities helper: mem sharedpool1. | `READ_ONLY` | `-` |
| `mem_usage.sh` | Oracle administration helper: mem usage. | `DESTRUCTIVE` | `INSTANCE_NUMBER, MAXMEM_USED, MAXMEM_USEDP, MAXPGA_USED, MAXPGA_USEDP, MAXSGA_USED, MAXSGA_USEDP, MI, ORACLE_SID, ORAENV_ASK, OUT, PATH, SS, arg1, arg8` |
| `memoria_libre_pool_memoria_uso.sql` | Oracle administration helper: memoria libre pool memoria uso. | `READ_ONLY` | `variables` |
| `memory_sga.sql` | Oracle administration helper: memory sga. | `READ_ONLY` | `variables` |
| `memory_usage.sql` | oracle/admin utilities helper: memory usage. | `READ_ONLY` | `-` |
| `memory_usage_hist.sql` | oracle/admin utilities helper: memory usage hist. | `READ_ONLY` | `days` |
| `memory_usage_process.sql` | Oracle administration helper: memory usage process. | `READ_ONLY` | `variables` |
| `memory_usage_v2.sql` | Oracle administration helper: memory usage v2. | `CHANGES` | `KSMSSNAM, MI, SS, variables` |
| `migrar_dbs_10gR2.sh` | Oracle administration helper: migrar dbs 10gR2. | `DESTRUCTIVE` | `ORACLE_SID` |
| `modificar_secuencia.sql` | Oracle administration helper: modificar secuencia. | `CHANGES` | `variables` |
| `mon_imp_perf.sql` | Oracle administration helper: mon imp perf. | `CHANGES` | `mi, ss, variables` |
| `move_lobs.sql` | Oracle administration helper: move lobs. | `CHANGES` | `variables` |
| `move_online_schema.sql` | Oracle administration helper: move online schema. | `CHANGES` | `MI, SS, variables` |
| `move_sysaux.sql` | Oracle administration helper: move sysaux. | `DESTRUCTIVE` | `variables` |
| `multi_block_read_count_full_scan.sql` | Oracle administration helper: multi block read count full scan. | `READ_ONLY` | `variables` |
| `mutex_sleep.sql` | Oracle administration helper: mutex sleep. | `READ_ONLY` | `variables` |
| `mutex_sleep_history.sql` | Oracle administration helper: mutex sleep history. | `READ_ONLY` | `variables` |
| `mystat_pga.sql` | Oracle administration helper: mystat pga. | `READ_ONLY` | `variables` |
| `mytbs_10g.sql` | Oracle administration helper: mytbs 10g. | `CHANGES` | `variables` |
| `nls.sql` | Oracle administration helper: nls. | `READ_ONLY` | `variables` |
| `nls_date.sql` | Oracle administration helper: nls date. | `CHANGES` | `MI, SS, variables` |
| `no_objetossystema_en_tab_system.sql` | Oracle administration helper: no objetossystema en tab system. | `READ_ONLY` | `variables` |
| `obj.sql` | Oracle administration helper: obj. | `READ_ONLY` | `variables` |
| `obj1.sql` | Oracle administration helper: obj1. | `READ_ONLY` | `variables` |
| `obj11.sql` | Oracle administration helper: obj11. | `READ_ONLY` | `variables` |
| `obj2.sql` | Oracle administration helper: obj2. | `READ_ONLY` | `variables` |
| `obj3.sql` | Oracle administration helper: obj3. | `READ_ONLY` | `variables` |
| `obj4.sql` | Oracle administration helper: obj4. | `READ_ONLY` | `variables` |
| `obj_esquemas.sql` | oracle/admin utilities helper: obj esquemas. | `READ_ONLY` | `-` |
| `obj_invalid.sql` | oracle/admin utilities helper: obj invalid. | `READ_ONLY` | `-` |
| `obj_invalid_det.sql` | Oracle administration helper: obj invalid det. | `READ_ONLY` | `variables` |
| `object_usage.sql` | Oracle administration helper: object usage. | `READ_ONLY` | `variables` |
| `objects_locks.sql` | Oracle administration helper: objects locks. | `DESTRUCTIVE` | `variables` |
| `objetos_en_shared_pool.sql` | Oracle administration helper: objetos en shared pool. | `READ_ONLY` | `variables` |
| `objetos_memoria.sql` | Oracle administration helper: objetos memoria. | `READ_ONLY` | `variables` |
| `objetos_shared_pool_a_keep.sql` | Oracle administration helper: objetos shared pool a keep. | `DESTRUCTIVE` | `NUEVO, variables` |
| `oem_querys.sql` | Oracle administration helper: oem querys. | `DESTRUCTIVE` | `mi, ss, variables` |
| `oem_rest_query_curl.sh` | Oracle administration helper: oem rest query curl. | `READ_ONLY` | `Prodentmgr13c` |
| `ogg_12102.sql` | Oracle administration helper: ogg 12102. | `DESTRUCTIVE` | `AQ_TM_PROCESSES, FREQ, GRANT_SELECT_PRIVILEGES, HH24, MI, Mi, PRIVILEGE_TYPE, SS, SSxFF, age_threshold, hcversion, lag_threshold, v_table_name, variables` |
| `oh_clone_12.1.sh` | Oracle administration helper: oh clone 12 1. | `REVIEW` | `DBHOME_FILE, ORACLE_BASE, ORACLE_HOME, ORACLE_HOME_DEST, OSASM_GROUP, OSBACKUPDBA_GROUP, OSDBA_GROUP, OSDGDBA_GROUP, OSKMDBA_GROUP, OSOPER_GROUP, OSRACDBA_GROUP, RUNNINSTALLER_COMMAND, SOURCE_PATH, UNIX_GROUP_NAME` |
| `ojvm_status.sql` | Oracle administration helper: ojvm status. | `READ_ONLY` | `variables` |
| `olocks.sql` | Oracle administration helper: olocks. | `READ_ONLY` | `variables` |
| `oms_host_encryption_check.sh` | Oracle administration helper: oms host encryption check. | `REVIEW` | `-` |
| `open_cursor.sql` | Oracle administration helper: open cursor. | `READ_ONLY` | `variables` |
| `open_cursor_cnt.sql` | Oracle administration helper: open cursor cnt. | `READ_ONLY` | `variables` |
| `open_cursor_pl.sql` | Oracle administration helper: open cursor pl. | `READ_ONLY` | `variables` |
| `open_cursor_sid.sql` | Oracle administration helper: open cursor sid. | `READ_ONLY` | `SID, variables` |
| `opened_cursors_current.sql` | Oracle administration helper: opened cursors current. | `READ_ONLY` | `variables` |
| `optimizer_index_cost_adj.sql` | Oracle administration helper: optimizer index cost adj. | `READ_ONLY` | `variables` |
| `optionssql.sql` | Oracle administration helper: optionssql. | `READ_ONLY` | `variables` |
| `ora_manage_restore_point.sh` | Oracle administration helper: ora manage restore point. | `DESTRUCTIVE` | `HEADER_SQL, INF_QUERY, ORACLE_SID, ORAENV_ASK, PATH, QUERY, arg8` |
| `oradebug_check_enabled_events.sql` | Oracle administration helper: oradebug check enabled events. | `CHANGES` | `variables` |
| `oratab_exec_script.sh` | Oracle administration helper: oratab exec script. | `CHANGES` | `LD_LIBRARY_PATH, ORACLE_HOME, ORACLE_SID, ORATAB, ORATABLINE, PATH` |
| `orcl_wallet.sh` | Oracle administration helper: orcl wallet. | `CHANGES` | `-` |
| `orden_de_columnas_en_una_tabla.sql` | Oracle administration helper: orden de columnas en una tabla. | `CHANGES` | `variables` |
| `os_dba_group_check.sh` | Oracle administration helper: os dba group check. | `REVIEW` | `-` |
| `param_optimizer_index_cost_adj.sql` | oracle/admin utilities helper: param optimizer index cost adj. | `READ_ONLY` | `-` |
| `parameter.sql` | oracle/admin utilities helper: parameter. | `READ_ONLY` | `name` |
| `parameter_db.sql` | oracle/admin utilities helper: parameter db. | `READ_ONLY` | `-` |
| `parameter_mem.sql` | oracle/admin utilities helper: parameter mem. | `READ_ONLY` | `-` |
| `parameter_x.sql` | oracle/admin utilities helper: parameter x. | `READ_ONLY` | `parametro` |
| `parametros_base.sql` | Oracle administration helper: parametros base. | `READ_ONLY` | `variables` |
| `parmemory.sql` | Oracle administration helper: parmemory. | `READ_ONLY` | `variables` |
| `parseos.sql` | Oracle administration helper: parseos. | `READ_ONLY` | `variables` |
| `partition.sql` | Oracle administration helper: partition. | `READ_ONLY` | `variables` |
| `partition_control.sql` | Oracle administration helper: partition control. | `READ_ONLY` | `variables` |
| `partition_high_value.sql` | Oracle administration helper: partition high value. | `READ_ONLY` | `OWNER, variables` |
| `partition_max_high_value.sql` | Oracle administration helper: partition max high value. | `READ_ONLY` | `owner, table_name, variables` |
| `partition_table_interval_ex.sql` | Oracle administration helper: partition table interval ex. | `DESTRUCTIVE` | `variables` |
| `partition_tablec.sql` | Oracle administration helper: partition tablec. | `CHANGES` | `variables` |
| `patch_alldbs.sh` | Oracle administration helper: patch alldbs. | `DESTRUCTIVE` | `ORACLE_SID` |
| `pbds.sql` | Oracle administration helper: pbds. | `READ_ONLY` | `variables` |
| `pdb.close.sql` | Oracle administration helper: pdb close. | `CHANGES` | `variables` |
| `pdb.rename.sql` | Oracle administration helper: pdb rename. | `CHANGES` | `variables` |
| `pdb_resource_usage.sql` | Oracle administration helper: pdb resource usage. | `CHANGES` | `MI, NLS_DATE_FORMAT, NLS_TIMESTAMP_FORMAT, SS, variables` |
| `pdb_services.sql` | Oracle administration helper: pdb services. | `READ_ONLY` | `variables` |
| `pdb_switch.sql` | Oracle administration helper: pdb switch. | `CHANGES` | `variables` |
| `pdbs.sql` | Oracle administration helper: pdbs. | `READ_ONLY` | `variables` |
| `pga_advice.sql` | Oracle administration helper: pga advice. | `READ_ONLY` | `variables` |
| `pga_agregate_target.sql` | Oracle administration helper: pga agregate target. | `REVIEW` | `variables` |
| `pga_stat.sql` | Oracle administration helper: pga stat. | `DESTRUCTIVE` | `MI, variables` |
| `pga_target_advice.sql` | Oracle administration helper: pga target advice. | `READ_ONLY` | `variables` |
| `pga_test.sql` | Oracle administration helper: pga test. | `REVIEW` | `variables` |
| `pga_usage.sql` | Oracle administration helper: pga usage. | `DESTRUCTIVE` | `variables` |
| `pgastat.sql` | Oracle administration helper: pgastat. | `READ_ONLY` | `variables` |
| `plug_startall_pdb.sql` | Oracle administration helper: plug startall pdb. | `CHANGES` | `variables` |
| `plug_unplug_pdb.sql` | Oracle administration helper: plug unplug pdb. | `DESTRUCTIVE` | `variables` |
| `porcentaje_toma_estadisticas.sql` | Oracle administration helper: porcentaje toma estadisticas. | `READ_ONLY` | `OWNER, variables` |
| `portal_docs.sql` | Oracle administration helper: portal docs. | `READ_ONLY` | `variables` |
| `postDBCreation.sql` | Oracle administration helper: postDBCreation. | `DESTRUCTIVE` | `MI, SS, dbsnmpPassword, sysPassword, sysmanPassword, variables` |
| `postScripts.sql` | Oracle administration helper: postScripts. | `CHANGES` | `sysPassword, variables` |
| `pq_sysstat.sql` | Oracle administration helper: pq sysstat. | `READ_ONLY` | `variables` |
| `print_table.sql` | Oracle administration helper: print table. | `CHANGES` | `mi, ss, variables` |
| `print_table_old.sql` | Oracle administration helper: print table old. | `DESTRUCTIVE` | `mi, ss, variables` |
| `print_table_ori.sql` | Oracle administration helper: print table ori. | `DESTRUCTIVE` | `mi, ss, variables` |
| `process_memory_pga.sql` | Oracle administration helper: process memory pga. | `READ_ONLY` | `variables` |
| `prompt.sql` | Oracle administration helper: prompt. | `CHANGES` | `_connect_identifier, _date, _user, mi, ss, variables` |
| `prueba_bulk_collect_forall.sql` | Oracle administration helper: prueba bulk collect forall. | `DESTRUCTIVE` | `variables` |
| `prueba_insert_as_select.sql` | Oracle administration helper: prueba insert as select. | `DESTRUCTIVE` | `TBS, variables` |
| `ps_mon_checklist_det_history.sql` | Oracle administration helper: ps mon checklist det history. | `CHANGES` | `binsert_time, einsert_time, spool_name, variables` |
| `ps_mon_chklist_history.sql` | Oracle administration helper: ps mon chklist history. | `CHANGES` | `bbookdate, ebookdate, spool_name, variables` |
| `ps_mon_crontab.sql` | Oracle administration helper: ps mon crontab. | `READ_ONLY` | `variables` |
| `purge_partitions.sql` | oracle/admin utilities helper: purge partitions. | `DESTRUCTIVE` | `mi, ss` |
| `purge_partitions_2.sql` | Oracle administration helper: purge partitions 2. | `DESTRUCTIVE` | `variables` |
| `purge_recyclebin.sql` | Oracle administration helper: purge recyclebin. | `DESTRUCTIVE` | `variables` |
| `query_all_dbs.sh` | Oracle administration helper: query all dbs. | `DESTRUCTIVE` | `MI, ORACLE_SID, ORAENV_ASK, PATH, SS, arg8` |
| `quien.sql` | Oracle administration helper: quien. | `READ_ONLY` | `MI, variables` |
| `quota.sql` | Oracle administration helper: quota. | `READ_ONLY` | `variables` |
| `random.sh` | Oracle administration helper: random (1). | `DESTRUCTIVE` | `-` |
| `random.sql` | Oracle administration helper: random (1). | `CHANGES` | `id, variables` |
| `randomCOutLines.sql` | Oracle administration helper: randomCOutLines. | `CHANGES` | `id, variables` |
| `randomSOutLines.sql` | Oracle administration helper: randomSOutLines. | `CHANGES` | `id, variables` |
| `rc_backup_set_details.sql` | Oracle administration helper: rc backup set details. | `READ_ONLY` | `variables` |
| `rebindexi.sql` | Oracle administration helper: rebindexi. | `CHANGES` | `variables` |
| `rebuild_indices_online.sql` | Oracle administration helper: rebuild indices online. | `CHANGES` | `variables` |
| `recomp_inv_obj.sql` | Oracle administration helper: recomp inv obj. | `CHANGES` | `variables` |
| `recomp_synonyms.sql` | oracle/admin utilities helper: recomp synonyms. | `CHANGES` | `-` |
| `recovery_file_dest.sql` | Oracle administration helper: recovery file dest. | `READ_ONLY` | `variables` |
| `recrea_index_snap_punto.sql` | Oracle administration helper: recrea index snap punto. | `CHANGES` | `variables` |
| `recrea_indices.sql` | Oracle administration helper: recrea indices. | `DESTRUCTIVE` | `TABLESPACE_INDICE, variables` |
| `recrea_snap_punto.sql` | Oracle administration helper: recrea snap punto. | `DESTRUCTIVE` | `REFRESH_METHOD, variables` |
| `recreate_redo_logfiles.sql` | Oracle administration helper: recreate redo logfiles. | `DESTRUCTIVE` | `variables` |
| `redo_generation.sql` | Oracle administration helper: redo generation. | `READ_ONLY` | `variables` |
| `refresco_07001.sql` | Oracle administration helper: refresco 07001. | `CHANGES` | `HH24, MI, SS, variables` |
| `refrescos1.sql` | Oracle administration helper: refrescos1. | `CHANGES` | `HH24, MI, SS, variables` |
| `reintentos_escritura_redo.sql` | Oracle administration helper: reintentos escritura redo. | `READ_ONLY` | `variables` |
| `relaciones_entre_tablas.sql` | Oracle administration helper: relaciones entre tablas (2). | `READ_ONLY` | `R_CONSTRAINT_NAME, TABLE_NAME, variables` |
| `remote_ssh_commands.sh` | Oracle administration helper: remote ssh commands. | `REVIEW` | `arg1` |
| `rep.sql` | Oracle administration helper: rep. | `READ_ONLY` | `variables` |
| `rep_refresh.sql` | Oracle administration helper: rep refresh. | `READ_ONLY` | `variables` |
| `reset_global_prefs.sql` | Oracle administration helper: reset global prefs. | `CHANGES` | `variables` |
| `reset_table_prefs.sql` | Oracle administration helper: reset table prefs. | `CHANGES` | `variables` |
| `reset_table_prefs_customers.sql` | Oracle administration helper: reset table prefs customers. | `CHANGES` | `variables` |
| `resource_limit.sql` | Oracle administration helper: resource limit. | `READ_ONLY` | `variables` |
| `resource_manager_steps.sql` | Oracle administration helper: resource manager steps. | `CHANGES` | `variables` |
| `restore_point.sql` | Oracle administration helper: restore point. | `DESTRUCTIVE` | `variables` |
| `rg_sqlprof3.sql` | Oracle administration helper: rg sqlprof3. | `READ_ONLY` | `CURSOR_SHARING, variables` |
| `rollback.sql` | Display database sessions using rollback segments | `READ_ONLY` | `-` |
| `rollback_usage_TOAD.sql` | Oracle administration helper: rollback usage TOAD. | `READ_ONLY` | `variables` |
| `rowsize.sql` | Oracle administration helper: rowsize. | `READ_ONLY` | `variables` |
| `rsrc_pdb.sql` | Oracle administration helper: rsrc pdb. | `READ_ONLY` | `variables` |
| `rsrcmgrmetric_history.sql` | Oracle administration helper: rsrcmgrmetric history. | `READ_ONLY` | `MI, variables` |
| `sar_p_awk.sh` | Oracle administration helper: sar p awk. | `REVIEW` | `arg11` |
| `sarp.sql` | Oracle administration helper: sarp. | `READ_ONLY` | `pIdEmpresa, pIdSucursal, variables` |
| `search_sql.sql` | Oracle administration helper: search sql. | `CHANGES` | `ETIME, EXECUTIONS, MI, PSCHEMA, SQL_ID, SQL_TEXT, SS, variables` |
| `segment.sql` | Oracle administration helper: segment. | `READ_ONLY` | `variables` |
| `segment1.sql` | Oracle administration helper: segment1. | `READ_ONLY` | `variables` |
| `segment2.sql` | Oracle administration helper: segment2. | `READ_ONLY` | `variables` |
| `segment_advisor.sql` | Oracle administration helper: segment advisor. | `CHANGES` | `variables` |
| `segments_by_datafile.sql` | Oracle administration helper: segments by datafile. | `READ_ONLY` | `file_id, variables` |
| `segments_keep.sql` | Oracle administration helper: segments keep. | `READ_ONLY` | `variables` |
| `segments_to_keep.sql` | Oracle administration helper: segments to keep. | `READ_ONLY` | `variables` |
| `segments_to_keep_sql.sql` | Oracle administration helper: segments to keep sql. | `DESTRUCTIVE` | `variables` |
| `segtbs.sql` | Oracle administration helper: segtbs. | `READ_ONLY` | `variables` |
| `select_case.sql` | oracle/admin utilities helper: select case. | `READ_ONLY` | `-` |
| `select_query_exp_columns.sql` | Oracle administration helper: select query exp columns. | `READ_ONLY` | `OWNER, QUERY, variables` |
| `ses_optimizer_env.sql` | Oracle administration helper: ses optimizer env. | `READ_ONLY` | `sid, variables` |
| `set_global_publish.sql` | Oracle administration helper: set global publish. | `READ_ONLY` | `variables` |
| `set_sqlplus_defaults.sql` | Oracle administration helper: set sqlplus defaults. | `REVIEW` | `variables` |
| `set_table_publish_prefs_false.sql` | Oracle administration helper: set table publish prefs false. | `CHANGES` | `variables` |
| `setsequence.sql` | Oracle administration helper: setsequence. | `CHANGES` | `Seq_CacheSize, Seq_CurValue, Seq_Cycle, Seq_DesireValue, Seq_IncrementBy, Seq_MaxValue, Seq_Name, Seq_Owner, Seq_Value, variables` |
| `sga.sql` | Oracle administration helper: sga. | `READ_ONLY` | `variables` |
| `sga_free_memory.sql` | Oracle administration helper: sga free memory. | `READ_ONLY` | `variables` |
| `sga_usage_hist.sql` | Oracle administration helper: sga usage hist. | `READ_ONLY` | `mi, ss, variables` |
| `sgainfo.sql` | Oracle administration helper: sgainfo. | `READ_ONLY` | `variables` |
| `shared_pool_advice.sql` | Oracle administration helper: shared pool advice. | `READ_ONLY` | `variables` |
| `shared_pool_free_mem.sql` | Oracle administration helper: shared pool free mem. | `READ_ONLY` | `variables` |
| `shared_pool_memory_alloc.sql` | Oracle administration helper: shared pool memory alloc. | `CHANGES` | `MI, SS, variables` |
| `shared_pool_obj_nokept.sql` | Oracle administration helper: shared pool obj nokept. | `READ_ONLY` | `variables` |
| `shared_pool_ora4031_errors.sql` | Oracle administration helper: shared pool ora4031 errors. | `READ_ONLY` | `variables` |
| `shared_pool_reserved.sql` | Oracle administration helper: shared pool reserved. | `READ_ONLY` | `variables` |
| `shared_pool_size.sql` | Oracle administration helper: shared pool size. | `READ_ONLY` | `variables` |
| `shared_pool_sql_highmem.sql` | Oracle administration helper: shared pool sql highmem. | `CHANGES` | `variables` |
| `shared_pool_usage_dly.sql` | Oracle administration helper: shared pool usage dly. | `READ_ONLY` | `days, name, variables` |
| `shared_pool_utilization.sql` | Oracle administration helper: shared pool utilization. | `READ_ONLY` | `variables` |
| `sharedserver.sql` | Oracle administration helper: sharedserver. | `CHANGES` | `DIS, PROTOCOL, variables` |
| `gen_embeddings.py` | Gieven a CSV ot TSV file, this script generates vector embeddings using sentence transformers model. Then, a new file will be created with the new vector column called "embedding" | `READ_ONLY` | `-` |
| `grep_alert.sh` | Oracle administration helper: grep alert. | `REVIEW` | `-` |
| `python_connect.sh` | Oracle administration helper: python connect. | `CHANGES` | `-` |
| `sqlplus_connection_strings.sh` | Oracle administration helper: sqlplus connection strings. | `REVIEW` | `ADDRESS, CONNECT_DATA, DESCRIPTION, PROTOCOL, SERVICE_NAME` |
| `sqlplus_loop_linux.sh` | Oracle administration helper: sqlplus loop linux. | `CHANGES` | `-` |
| `similar_sql.sql` | Oracle administration helper: similar sql. | `READ_ONLY` | `chars, db, num_repeats, variables` |
| `small_table_threshold.sql` | Oracle administration helper: small table threshold. | `CHANGES` | `variables` |
| `sniped.sql` | Oracle administration helper: sniped. | `READ_ONLY` | `variables` |
| `soundex.sql` | Oracle administration helper: soundex. | `READ_ONLY` | `variables` |
| `spfile.sql` | Oracle administration helper: spfile. | `READ_ONLY` | `variables` |
| `spid.sql` | Oracle administration helper: spid. | `READ_ONLY` | `variables` |
| `spool_flashback.sql` | Oracle administration helper: spool flashback. | `CHANGES` | `fb_scn, variables` |
| `sql.sql` | Oracle administration helper: sql. | `READ_ONLY` | `parsing_schema_name, sql_id, sql_text, variables` |
| `sql_area_parses.sql` | oracle/admin utilities helper: sql area parses. | `READ_ONLY` | `-` |
| `sql_bind_capture_x.sql` | oracle/admin utilities helper: sql bind capture x. | `READ_ONLY` | `SQLID` |
| `sql_bind_variables.sql` | Oracle administration helper: sql bind variables. | `READ_ONLY` | `parsing_schema_name, plan_hash_value, variables` |
| `sql_high_memory.sql` | Oracle administration helper: sql high memory. | `CHANGES` | `variables` |
| `sql_hist_id.sql` | Oracle administration helper: sql hist id. | `READ_ONLY` | `MI, SS, sqlid, variables` |
| `sql_hit_ratio.sql` | oracle/admin utilities helper: sql hit ratio. | `READ_ONLY` | `-` |
| `sql_id_to_signature.sql` | Oracle administration helper: sql id to signature. | `READ_ONLY` | `SIGNATURE, sql_id, variables` |
| `sql_offload.sql` | Oracle administration helper: sql offload. | `CHANGES` | `MI, SS, sql_text, variables` |
| `sql_perf_mon.sql` | oracle/admin utilities helper: sql perf mon. | `CHANGES` | `MI, NLS_DATE_FORMAT, SQL_ID, SS, White, black, bold, left, mi, narchivo, ss, top` |
| `sql_response_time_stddev.sql` | Oracle administration helper: sql response time stddev. | `READ_ONLY` | `variables` |
| `sql_shared_cursor.sql` | Oracle administration helper: sql shared cursor. | `READ_ONLY` | `variables` |
| `sql_sqltext.sql` | Oracle administration helper: sql sqltext. | `READ_ONLY` | `variables` |
| `sql_test_1.sql` | Oracle administration helper: sql test 1. | `CHANGES` | `id, variables` |
| `sql_test_2.sql` | Oracle administration helper: sql test 2. | `DESTRUCTIVE` | `id, variables` |
| `sql_test_3.sql` | Oracle administration helper: sql test 3. | `CHANGES` | `id, variables` |
| `sql_tuning_auto_enable.sql` | Oracle administration helper: sql tuning auto enable. | `REVIEW` | `variables` |
| `sql_workarea_active.sql` | Oracle administration helper: sql workarea active. | `READ_ONLY` | `variables` |
| `sql_workarea_histogram.sql` | Oracle administration helper: sql workarea histogram. | `READ_ONLY` | `variables` |
| `sql_x.sql` | Oracle administration helper: sql x. | `READ_ONLY` | `SQL_TEXT, variables` |
| `sqlarea.sql` | Oracle administration helper: sqlarea. | `READ_ONLY` | `variables` |
| `sqlarea_x.sql` | Oracle administration helper: sqlarea x. | `READ_ONLY` | `SQL_ID, variables` |
| `sqlid_executions_elaptime.sql` | Oracle administration helper: sqlid executions elaptime. | `DESTRUCTIVE` | `duration_sec_min, sql_id, sysdaten, username, variables` |
| `sqlnet_blockip.sql` | Oracle administration helper: sqlnet blockip. | `CHANGES` | `Oracle, variables` |
| `sqltext.sql` | Oracle administration helper: sqltext. | `READ_ONLY` | `variables` |
| `sqltext_with_newlines.sql` | Oracle administration helper: sqltext with newlines. | `READ_ONLY` | `sqlid, variables` |
| `srdc_db_ora4031sp.sql` | Oracle administration helper: srdc db ora4031sp. | `CHANGES` | `MI, SRDCNAME, SRDCSPOOLNAME, SS, TZM, variables` |
| `srv.add.instance.sql` | Oracle administration helper: srv add instance. | `REVIEW` | `variables` |
| `srvctl.services..move.sh` | Oracle administration helper: srvctl services move. | `REVIEW` | `-` |
| `srvctl.services.sh` | Oracle administration helper: srvctl services. | `REVIEW` | `-` |
| `stat_parse.sql` | Oracle administration helper: stat parse. | `READ_ONLY` | `variables` |
| `statistics_level.sql` | Oracle administration helper: statistics level. | `READ_ONLY` | `variables` |
| `statname.sql` | Oracle administration helper: statname. | `READ_ONLY` | `statname, variables` |
| `streams_capture.sql` | Oracle administration helper: streams capture. | `READ_ONLY` | `variables` |
| `streams_dba_apply.sql` | Oracle administration helper: streams dba apply. | `READ_ONLY` | `variables` |
| `streams_hc_10GR2.sql` | Oracle administration helper: streams hc 10GR2. | `CHANGES` | `MI, Mi, SS, variables` |
| `streams_hc_11_2_0_3.sql` | Oracle administration helper: streams hc 11 2 0 3. | `DESTRUCTIVE` | `AQ_TM_PROCESSES, Mi, SS, hcversion, variables` |
| `streams_register_logfile.sql` | Oracle administration helper: streams register logfile. | `DESTRUCTIVE` | `variables` |
| `streams_schema_script.sql` | Oracle administration helper: streams schema script. | `DESTRUCTIVE` | `ADDRESS, ADDRESS_LIST, CONNECT_DATA, DESCRIPTION, HOST, PORT, PROTOCOL, SID, compat, db1, db2, lcr, strm_adm_db1, strm_adm_db2, strm_adm_pwd_db1, strm_adm_pwd_db2, strm_pwd_dest, strm_pwd_src, variables, ver` |
| `streams_table_script.sql` | Oracle administration helper: streams table script. | `DESTRUCTIVE` | `ADDRESS, ADDRESS_LIST, CONNECT_DATA, DESCRIPTION, HOST, PORT, PROTOCOL, SID, compat, db1, db2, lcr, strm_adm_db1, strm_adm_db2, strm_adm_pwd_db1, strm_adm_pwd_db2, strm_pwd_dest, strm_pwd_src, variables, ver` |
| `stress_test.sql` | Oracle administration helper: stress test. | `READ_ONLY` | `variables` |
| `subsrt.sql` | Oracle administration helper: subsrt. | `REVIEW` | `variables` |
| `supplemental_logging_check.sql` | Oracle administration helper: supplemental logging check. | `READ_ONLY` | `variables` |
| `syn.sql` | Oracle administration helper: syn. | `READ_ONLY` | `variables` |
| `sys_fields_59.sql` | Oracle administration helper: sys fields 59. | `CHANGES` | `variables` |
| `sys_time_model.sql` | Oracle administration helper: sys time model. | `CHANGES` | `variables` |
| `sys_time_model_vview.sql` | Oracle administration helper: v$sys time model (1). | `CHANGES` | `variables` |
| `sysaux_occupants.sql` | Oracle administration helper: sysaux occupants. | `CHANGES` | `variables` |
| `sysmetric_history.sql` | Oracle administration helper: sysmetric history. | `CHANGES` | `mi, variables` |
| `sysmetric_history_sql_response_time.sql` | Oracle administration helper: sysmetric history sql response time. | `READ_ONLY` | `_Average, _standard_deviation, mi, variables` |
| `sysmetric_summary.sql` | Oracle administration helper: sysmetric summary. | `READ_ONLY` | `variables` |
| `sysstat_parallel.sql` | Oracle administration helper: sysstat parallel. | `READ_ONLY` | `variables` |
| `system_event_io_latency.sql` | Oracle administration helper: system event io latency. | `READ_ONLY` | `prevdpr_ct_var, prevdpr_tm_var, prevdprt_ct_var, prevdprt_tm_var, prevdpw_ct_var, prevdpw_tm_var, prevdpwt_ct_var, prevdpwt_tm_var, prevlfpw_ct_var, prevlfpw_tm_var, prevscat_ct_var, prevscat_tm_var, prevsec_var, prevseq_ct_var, prevseq_tm_var, variables` |
| `system_fix_control.sql` | Oracle administration helper: system fix control. | `READ_ONLY` | `variables` |
| `system_statistics.sql` | Oracle administration helper: system statistics. | `READ_ONLY` | `variables` |
| `tablas_segmentos_menos10%libre.sql` | Oracle administration helper: tablas segmentos menos10%libre. | `READ_ONLY` | `variables` |
| `tablas_segmentos_menos10_libre.sql` | Oracle administration helper: tablas segmentos menos10 libre(1). | `READ_ONLY` | `variables` |
| `table.sql` | oracle/admin utilities helper: table. | `READ_ONLY` | `Owner, Table_name, owner, table_name` |
| `table2.sql` | Oracle administration helper: table2. | `READ_ONLY` | `Owner, Table_Owner, Table_name, owner, table_name, variables` |
| `table_conf.sql` | Oracle administration helper: table conf. | `READ_ONLY` | `mi, owner, table, variables` |
| `table_fetch_continued_row.sql` | Oracle administration helper: table fetch continued row. | `CHANGES` | `num_days, variables` |
| `tables.sql` | Oracle administration helper: tables. | `READ_ONLY` | `MI, SS, sch, variables` |
| `tables_to_partition.sql` | Oracle administration helper: tables to partition. | `READ_ONLY` | `variables` |
| `tables_with_lob_columns.sql` | Oracle administration helper: tables with lob columns. | `READ_ONLY` | `variables` |
| `tam_indices.sql` | Oracle administration helper: tam indices. | `READ_ONLY` | `variables` |
| `tamaño_objetos.sql` | Oracle administration helper: tamaño objetos. | `READ_ONLY` | `variables` |
| `tempfile.sql` | Oracle administration helper: tempfile. | `CHANGES` | `variables` |
| `test_db_link_exec.sql` | oracle/admin utilities helper: test db link exec. | `CHANGES` | `EFLUSH, IDENT, _connect_identifier, _date, _user, ext, mi, sep, spoolv, ss` |
| `test_db_link_perf.sql` | Oracle administration helper: test db link perf. | `DESTRUCTIVE` | `ADDRESS, ADDRESS_LIST, CONNECT_DATA, DESCRIPTION, HOST, PORT, PROTOCOL, SERVICE_NAME, variables` |
| `test_db_link_source_create.sql` | oracle/admin utilities helper: test db link source create. | `CHANGES` | `CKEEP, DB_KEEP_CACHE_SIZE, EFLUSH, TBSDATA, TBSINDX, tbsdata, tbsindx` |
| `test_db_link_source_drop.sql` | oracle/admin utilities helper: test db link source drop. | `DESTRUCTIVE` | `CKEEP, DB_KEEP_CACHE_SIZE` |
| `test_db_link_target_create.sql` | oracle/admin utilities helper: test db link target create. | `CHANGES` | `BASE, PASSW` |
| `test_db_link_target_drop.sql` | oracle/admin utilities helper: test db link target drop. | `DESTRUCTIVE` | `-` |
| `test_insensitive.sql` | Oracle administration helper: test insensitive. | `DESTRUCTIVE` | `NLS_COMP, NLS_SORT, variables` |
| `test_io_insert_ret_rowid.sql` | Oracle administration helper: test io insert ret rowid. | `DESTRUCTIVE` | `variables` |
| `test_io_oper.sql` | Oracle administration helper: test io oper. | `DESTRUCTIVE` | `TBS, tbs, variables` |
| `test_io_oper_rowid.sql` | Oracle administration helper: test io oper rowid. | `DESTRUCTIVE` | `TBS, tbs, variables` |
| `tfa_collect.sql` | Oracle administration helper: tfa collect. | `REVIEW` | `variables` |
| `timestamp_to_scn.sql` | Oracle administration helper: timestamp to scn. | `READ_ONLY` | `mi, ss, variables` |
| `timezone_columns_size.sql` | Oracle administration helper: timezone columns size. | `READ_ONLY` | `variables` |
| `timezone_file_version_dst_check_objects.sql` | Oracle administration helper: timezone file version dst check objects. | `READ_ONLY` | `variables` |
| `top10proc.sql` | oracle/admin utilities helper: top10proc. | `READ_ONLY` | `-` |
| `top10table.sql` | oracle/admin utilities helper: top10table. | `DESTRUCTIVE` | `-` |
| `top_CPU.sql` | Oracle administration helper: top CPU. | `DESTRUCTIVE` | `variables` |
| `top_activity.sql` | Oracle administration helper: top activity. | `DESTRUCTIVE` | `variables` |
| `top_activity_io.sql` | Script To Get Cpu Usage And Wait Event Information In Oracle Database | `READ_ONLY` | `MI, SS` |
| `top_sql_byelaptime.sql` | Oracle administration helper: top sql byelaptime. | `DESTRUCTIVE` | `HH24, MI, variables` |
| `top_ten.sql` | Oracle administration helper: top ten. | `CHANGES` | `variables` |
| `transaction.sql` | Oracle administration helper: transaction. | `READ_ONLY` | `variables` |
| `trend_awr_stat.sql` | oracle/admin utilities helper: trend awr stat. | `READ_ONLY` | `m_dbid, m_instance, m_stat_name, mi, ss` |
| `trg_database_logon.sql` | oracle/admin utilities helper: trg database logon. | `CHANGES` | `-` |
| `trg_database_logon_2.sql` | Oracle administration helper: trg database logon 2. | `CHANGES` | `SQL_TRACE, variables` |
| `trg_database_logon_par.sql` | oracle/admin utilities helper: trg database logon par. | `CHANGES` | `-` |
| `trg_database_logon_schema.sql` | Oracle administration helper: trg database logon schema. | `CHANGES` | `variables` |
| `trigger_logon_error.sql` | Oracle administration helper: trigger logon error. | `CHANGES` | `MI, SS, variables` |
| `trigger_onschema.sql` | Oracle administration helper: trigger onschema. | `CHANGES` | `variables` |
| `triggers_fixed_owner.sql` | Oracle administration helper: triggers fixed owner. | `DESTRUCTIVE` | `variables` |
| `ttab.sql` | Oracle administration helper: ttab. | `READ_ONLY` | `variables` |
| `tuning7-92.sql` | Oracle administration helper: tuning7 92. | `CHANGES` | `sum, variables, xxv1, xxv2, xxv3` |
| `undo.sql` | Oracle administration helper: undo (2). | `READ_ONLY` | `mi, ss, variables` |
| `undo9i.sql` | Oracle administration helper: undo9i. | `READ_ONLY` | `mi, ss, variables` |
| `unindex.sql` | Oracle administration helper: unindex. | `READ_ONLY` | `variables` |
| `unix.sql` | Oracle administration helper: unix (2). | `CHANGES` | `ID1, ID2, MI, ROW, SS, THREAD, TYPE, variables` |
| `update_massive_asselect.sql` | oracle/admin utilities helper: update massive asselect. | `CHANGES` | `-` |
| `update_sequence.sql` | Oracle administration helper: update sequence. | `CHANGES` | `v_column_name, v_owner_sequence, v_owner_table, v_sequence_name, v_table_name, variables` |
| `updates_masivos.sql` | Oracle administration helper: updates masivos. | `DESTRUCTIVE` | `variables` |
| `uptime.sql` | Oracle administration helper: uptime. | `READ_ONLY` | `variables` |
| `uso_memoria.sql` | Oracle administration helper: uso memoria. | `READ_ONLY` | `variables` |
| `usotemp.sql` | oracle/admin utilities helper: usotemp. | `READ_ONLY` | `-` |
| `utl_file_write_example.sql` | Oracle administration helper: utl file write example. | `REVIEW` | `variables` |
| `utl_recomp.sql` | Oracle administration helper: utl recomp. | `CHANGES` | `variables` |
| `utlsampl_10g.sql` | Oracle administration helper: utlsampl 10g. | `DESTRUCTIVE` | `variables` |
| `v_unusable_indexes.sql` | oracle/admin utilities helper: v unusable indexes. | `READ_ONLY` | `-` |
| `verLockeo.sql` | Oracle administration helper: verLockeo. | `READ_ONLY` | `variables` |
| `verify_passwd.sql` | Oracle administration helper: verify passwd. | `DESTRUCTIVE` | `variables` |
| `version.sql` | Oracle administration helper: version. | `READ_ONLY` | `variables` |
| `version_rpt3_12.sql` | Oracle administration helper: version rpt3 12. | `DESTRUCTIVE` | `CHAR_LENGTH, CHILD_ADDRESS, ISDEFAULT, OPTIMIZER_MISMATCH, SQL_ID, mi, v_hash, v_sql_id, variables` |
| `view_bind_variables.sql` | oracle/admin utilities helper: view bind variables. | `READ_ONLY` | `SQLID, parsing_schema_name, plan_hash_value` |
| `wget - example.sh` | Oracle administration helper: wget example. | `REVIEW` | `-` |
| `wget.sh` | Oracle administration helper: wget. | `READ_ONLY` | `COOKIE_FILE, DOWNLOAD_LINK, LANG, LOGDIR, LOGFILE, OUTPUT_DIR, WGET, arg1, patch_file` |
| `workbooks.sql` | Oracle administration helper: workbooks. | `READ_ONLY` | `variables` |
