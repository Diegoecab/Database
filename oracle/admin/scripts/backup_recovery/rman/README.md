# oracle/admin backup_recovery/rman

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `CloneRmanRestore.sql` | Oracle RMAN backup, restore or recovery helper: CloneRmanRestore. | `DESTRUCTIVE` | `sysPassword, variables` |
| `backupRMAN.sql` | Oracle RMAN backup, restore or recovery helper: backupRMAN. | `DESTRUCTIVE` | `variables` |
| `citi_rman_24hs.sql` | Oracle RMAN backup, restore or recovery helper: citi rman 24hs. | `DESTRUCTIVE` | `MI, variables` |
| `citi_rman_avg_type.sql` | Oracle RMAN backup, restore or recovery helper: citi rman avg type. | `DESTRUCTIVE` | `variables` |
| `citi_rman_dly.sql` | Oracle RMAN backup, restore or recovery helper: citi rman dly. | `DESTRUCTIVE` | `host, sid, variables` |
| `citi_rman_full.sql` | Oracle RMAN backup, restore or recovery helper: citi rman full. | `DESTRUCTIVE` | `variables` |
| `citi_rman_status.sql` | Oracle RMAN backup, restore or recovery helper: citi rman status. | `DESTRUCTIVE` | `days, variables` |
| `IncrementalCM.rman` | Oracle RMAN backup, restore or recovery helper: IncrementalCM. | `DESTRUCTIVE` | `TAG` |
| `RestaurarRMANSinBase!!!.sh` | Oracle RMAN backup, restore or recovery helper: RestaurarRMANSinBase!!!. | `DESTRUCTIVE` | `DBID, DIR_BACK, DIR_BACK_ARCHIVES, DIR_BACK_CONTROLF, DIR_BACK_LEVEL0, DIR_BACK_LEVEL1, DIR_LOGS, ORACLE_HOME, ORACLE_SID` |
| `RestoreUntilSequence.sql` | Oracle RMAN backup, restore or recovery helper: RestoreUntilSequence. | `DESTRUCTIVE` | `PARMS, variables` |
| `RmanCreateScripts.sql` | Oracle RMAN backup, restore or recovery helper: RmanCreateScripts. | `DESTRUCTIVE` | `variables` |
| `ClonarBase.cmd` | Oracle RMAN backup, restore or recovery helper: ClonarBase. | `DESTRUCTIVE` | `ORACLE_SID` |
| `CloneRmanRestore.sql` | Oracle RMAN backup, restore or recovery helper: CloneRmanRestore. | `DESTRUCTIVE` | `sysPassword, variables` |
| `cloneDBCreation.sql` | Oracle RMAN backup, restore or recovery helper: cloneDBCreation. | `DESTRUCTIVE` | `sysPassword, systemPassword, variables` |
| `dba.bat` | Oracle RMAN backup, restore or recovery helper: dba. | `DESTRUCTIVE` | `ORACLE_SID` |
| `dba.sql` | Oracle RMAN backup, restore or recovery helper: dba. | `DESTRUCTIVE` | `SPFILE, sysPassword, variables` |
| `postDBCreation.sql` | Oracle RMAN backup, restore or recovery helper: postDBCreation. | `DESTRUCTIVE` | `MI, SS, dbsnmpPassword, sysPassword, sysmanPassword, variables` |
| `postScripts.sql` | Oracle RMAN backup, restore or recovery helper: postScripts. | `DESTRUCTIVE` | `sysPassword, variables` |
| `full.rman` | Oracle RMAN backup, restore or recovery helper: full. | `DESTRUCTIVE` | `TAG` |
| `fullCM.rman` | Oracle RMAN backup, restore or recovery helper: fullCM. | `DESTRUCTIVE` | `TAG` |
| `level0.cmd` | Oracle RMAN backup, restore or recovery helper: level0. | `DESTRUCTIVE` | `-` |
| `level1.cmd` | Oracle RMAN backup, restore or recovery helper: level1. | `DESTRUCTIVE` | `-` |
| `restoreFull.cmd` | Oracle RMAN backup, restore or recovery helper: restoreFull. | `DESTRUCTIVE` | `-` |
| `rmanCM_Incremental.cmd` | Oracle RMAN backup, restore or recovery helper: rmanCM Incremental. | `DESTRUCTIVE` | `ORACLE_SID` |
| `rmanCM_full.cmd` | Oracle RMAN backup, restore or recovery helper: rmanCM full. | `DESTRUCTIVE` | `ORACLE_SID` |
| `rmanRestoreDatafiles.sql` | Oracle RMAN backup, restore or recovery helper: rmanRestoreDatafiles. | `DESTRUCTIVE` | `MI, SS, devicename, variables` |
| `LinuxLVL0.sh` | Oracle RMAN backup, restore or recovery helper: LinuxLVL0. | `DESTRUCTIVE` | `EDITOR, FECHA, LD_LIBRARY_PATH, NLS_DATE_FORMAT, NLS_LANG, ORACLE_BASE, ORACLE_HOME, ORACLE_SID, PATH, RMAN_LOG, TNS_ADMIN, hh24, mi, ss` |
| `LinuxLVL1.sh` | Oracle RMAN backup, restore or recovery helper: LinuxLVL1. | `DESTRUCTIVE` | `EDITOR, FECHA, LD_LIBRARY_PATH, NLS_DATE_FORMAT, NLS_LANG, ORACLE_BASE, ORACLE_HOME, ORACLE_SID, PATH, RMAN_LOG, TNS_ADMIN, hh24, mi, ss` |
| `CopyDatRMAN.rman` | Oracle RMAN backup, restore or recovery helper: CopyDatRMAN. | `DESTRUCTIVE` | `-` |
| `ExecControlF.bat` | Oracle RMAN backup, restore or recovery helper: ExecControlF. | `DESTRUCTIVE` | `ORACLE_SID` |
| `ExecRman.bat` | Oracle RMAN backup, restore or recovery helper: ExecRman. | `DESTRUCTIVE` | `ORACLE_SID` |
| `cStandByCtl.sql` | Oracle RMAN backup, restore or recovery helper: cStandByCtl. | `DESTRUCTIVE` | `variables` |
| `Borrar_Archives.vbs` | Oracle RMAN backup, restore or recovery helper: Borrar Archives. | `DESTRUCTIVE` | `-` |
| `Copiar_Archives.bat` | Oracle RMAN backup, restore or recovery helper: Copiar Archives. | `DESTRUCTIVE` | `-` |
| `Copiar_Datafiles.bat` | Oracle RMAN backup, restore or recovery helper: Copiar Datafiles. | `DESTRUCTIVE` | `-` |
| `ExecRecover.bat` | Oracle RMAN backup, restore or recovery helper: ExecRecover. | `DESTRUCTIVE` | `ORACLE_SID` |
| `SwitchBackSTB.bat` | Oracle RMAN backup, restore or recovery helper: SwitchBackSTB. | `DESTRUCTIVE` | `ORACLE_SID` |
| `SwitchOverSTB.bat` | Oracle RMAN backup, restore or recovery helper: SwitchOverSTB. | `DESTRUCTIVE` | `ORACLE_SID` |
| `cRecoverSTB.sql` | Oracle RMAN backup, restore or recovery helper: cRecoverSTB. | `DESTRUCTIVE` | `variables` |
| `ejecutaBKPDatafile.sh` | Oracle RMAN backup, restore or recovery helper: ejecutaBKPDatafile. | `DESTRUCTIVE` | `-` |
| `ejecutaBKPFull.sh` | Oracle RMAN backup, restore or recovery helper: ejecutaBKPFull. | `DESTRUCTIVE` | `ORACLE_SID` |
| `ejecutaRestoreDatafile.sh` | Oracle RMAN backup, restore or recovery helper: ejecutaRestoreDatafile. | `DESTRUCTIVE` | `-` |
| `ejecutaRestoreFull.sh` | Oracle RMAN backup, restore or recovery helper: ejecutaRestoreFull. | `DESTRUCTIVE` | `-` |
| `ejecutaRestoreTablespace.sh` | Oracle RMAN backup, restore or recovery helper: ejecutaRestoreTablespace. | `DESTRUCTIVE` | `-` |
| `ejecutaRestoreTime.sh` | Oracle RMAN backup, restore or recovery helper: ejecutaRestoreTime. | `DESTRUCTIVE` | `-` |
| `ejecuta_mail.sql` | Oracle RMAN backup, restore or recovery helper: ejecuta mail. | `DESTRUCTIVE` | `variables` |
| `full.sql` | Oracle RMAN backup, restore or recovery helper: full. | `DESTRUCTIVE` | `variables` |
| `restoreDatafile.sql` | Oracle RMAN backup, restore or recovery helper: restoreDatafile. | `DESTRUCTIVE` | `variables` |
| `restoreFull.sql` | Oracle RMAN backup, restore or recovery helper: restoreFull. | `DESTRUCTIVE` | `variables` |
| `restoreTablespace.sql` | Oracle RMAN backup, restore or recovery helper: restoreTablespace. | `DESTRUCTIVE` | `variables` |
| `restoreTime.sql` | Oracle RMAN backup, restore or recovery helper: restoreTime. | `DESTRUCTIVE` | `variables` |
| `BkpBin.cmd` | Oracle RMAN backup, restore or recovery helper: BkpBin. | `DESTRUCTIVE` | `-` |
| `BkpPASS.cmd` | Oracle RMAN backup, restore or recovery helper: BkpPASS. | `DESTRUCTIVE` | `-` |
| `RestoreTime.sql` | Oracle RMAN backup, restore or recovery helper: RestoreTime. | `DESTRUCTIVE` | `variables` |
| `backdatafile3.sql` | Oracle RMAN backup, restore or recovery helper: backdatafile3. | `DESTRUCTIVE` | `variables` |
| `backdatafile6.sql` | Oracle RMAN backup, restore or recovery helper: backdatafile6. | `DESTRUCTIVE` | `variables` |
| `ejcutaBKPInc.cmd` | Oracle RMAN backup, restore or recovery helper: ejcutaBKPInc. | `DESTRUCTIVE` | `-` |
| `ejcutaBKPInc2.bat` | Oracle RMAN backup, restore or recovery helper: ejcutaBKPInc2. | `DESTRUCTIVE` | `-` |
| `ejecutaBKPDatafile3.cmd` | Oracle RMAN backup, restore or recovery helper: ejecutaBKPDatafile3. | `DESTRUCTIVE` | `-` |
| `ejecutaBKPDatafile6.cmd` | Oracle RMAN backup, restore or recovery helper: ejecutaBKPDatafile6. | `DESTRUCTIVE` | `-` |
| `ejecutaBKPFull.cmd` | Oracle RMAN backup, restore or recovery helper: ejecutaBKPFull. | `DESTRUCTIVE` | `-` |
| `ejecutaRestoreFull.cmd` | Oracle RMAN backup, restore or recovery helper: ejecutaRestoreFull. | `DESTRUCTIVE` | `-` |
| `ejecutaRestoreTime.cmd` | Oracle RMAN backup, restore or recovery helper: ejecutaRestoreTime. | `DESTRUCTIVE` | `-` |
| `ejecutarRestoreDatafile.cmd` | Oracle RMAN backup, restore or recovery helper: ejecutarRestoreDatafile. | `DESTRUCTIVE` | `-` |
| `ejecutarRestoreTablepace.cmd` | Oracle RMAN backup, restore or recovery helper: ejecutarRestoreTablepace. | `DESTRUCTIVE` | `-` |
| `full.sql` | Oracle RMAN backup, restore or recovery helper: full. | `DESTRUCTIVE` | `variables` |
| `incremental.sql` | Oracle RMAN backup, restore or recovery helper: incremental. | `DESTRUCTIVE` | `variables` |
| `incremental2.sql` | Oracle RMAN backup, restore or recovery helper: incremental2. | `DESTRUCTIVE` | `variables` |
| `restoreDatafile3.sql` | Oracle RMAN backup, restore or recovery helper: restoreDatafile3. | `DESTRUCTIVE` | `variables` |
| `IncrementalCM.rman` | Oracle RMAN backup, restore or recovery helper: IncrementalCM. | `DESTRUCTIVE` | `-` |
| `fullCM.rman` | Oracle RMAN backup, restore or recovery helper: fullCM. | `DESTRUCTIVE` | `-` |
| `rmanCM_Incremental.cmd` | Oracle RMAN backup, restore or recovery helper: rmanCM Incremental. | `DESTRUCTIVE` | `ORACLE_SID` |
| `rmanCM_full.cmd` | Oracle RMAN backup, restore or recovery helper: rmanCM full. | `DESTRUCTIVE` | `ORACLE_SID` |
| `script_ejec_rman.cmd` | Oracle RMAN backup, restore or recovery helper: script ejec rman. | `DESTRUCTIVE` | `ORACLE_SID` |
| `performance_report_online_html.sql` | oracle/admin backup_recovery/rman helper: performance report online html. | `READ_ONLY` | `Top, _dbname, dba_hist_snapshot_days, filen, minutes, sysdt` |
| `rc_rman_configuration.sql` | Oracle RMAN backup, restore or recovery helper: rc rman configuration. | `DESTRUCTIVE` | `db_name, variables` |
| `rc_rman_databases.sql` | Oracle RMAN backup, restore or recovery helper: rc rman databases. | `DESTRUCTIVE` | `variables` |
| `rc_rman_output.sql` | Oracle RMAN backup, restore or recovery helper: rc rman output. | `DESTRUCTIVE` | `variables` |
| `rc_rman_running.sql` | Oracle RMAN backup, restore or recovery helper: rc rman running. | `DESTRUCTIVE` | `STATUS, variables` |
| `rc_rman_status.sql` | Oracle RMAN backup, restore or recovery helper: rc rman status. | `DESTRUCTIVE` | `days, db_name, mi, object_type, operation, output_device_type, ss, variables` |
| `rc_rman_status_full.sql` | Oracle RMAN backup, restore or recovery helper: rc rman status full. | `DESTRUCTIVE` | `variables` |
| `rmanRestoreDatafiles.sql` | Oracle RMAN backup, restore or recovery helper: rmanRestoreDatafiles. | `DESTRUCTIVE` | `MI, SS, devicename, variables` |
| `rman_backup.sh` | Performs a LEVEL 0 + ARCHIVELOG backup. # | `DESTRUCTIVE` | `AMBIENTE, BKPDIR, ERROR, LOGFILE, MAIL_DBAS, MAIL_MSG, MAIL_OPERADORES, MAIL_TO, MI, NARG, NLS_DATE_FORMAT, NLS_LANG, ORACLE_BASE, ORACLE_HOME, ORACLE_SID, PATH, SS, TAG, TIPO, WARNING, WDIR, arg1, arg2, arg3, arg4, arg9` |
| `rman_backup_archivelog_sequence.sh` | Oracle RMAN backup, restore or recovery helper: rman backup archivelog sequence. | `DESTRUCTIVE` | `-` |
| `rman_backup_full.sh` | Oracle RMAN backup, restore or recovery helper: rman backup full. | `DESTRUCTIVE` | `ORACLE_SID, ORAENV_ASK` |
| `rman_backup_job_details.sql` | Oracle RMAN backup, restore or recovery helper: rman backup job details. | `DESTRUCTIVE` | `STATUS, mi, variables` |
| `rman_backup_job_details_vview.sql` | Oracle RMAN backup, restore or recovery helper: v$rman backup job details (1). | `DESTRUCTIVE` | `mi, variables` |
| `rman_backup_set_details.sql` | Oracle RMAN backup, restore or recovery helper: rman backup set details. | `DESTRUCTIVE` | `bkp_type, filename, variables` |
| `rman_backup_set_details_report.sql` | oracle/admin backup_recovery/rman helper: rman backup set details report. | `CHANGES` | `BGCOLOR, BORDER, Black, DIR_SPOOL, MI, SS, WIDTH, White, black, bold, darkgreen, dbinf, repHeader, top` |
| `rman_catalog_datafilecopy.sql` | Oracle RMAN backup, restore or recovery helper: rman catalog datafilecopy. | `DESTRUCTIVE` | `variables` |
| `rman_catalog_report.sql` | Genera reporte html de lo registrado en el catalogo de rman en los ultimos 8 dias | `CHANGES` | `MI, SS, White, absolute, auto, black, bold, dflt_name, hidden, mi, report_name, ss, top` |
| `rman_duplicate_target.sql` | Oracle RMAN backup, restore or recovery helper: rman duplicate target. | `DESTRUCTIVE` | `ADDRESS, COMPRESSION, CONNECT_DATA, DESCRIPTION, FAL_CLIENT, FAL_SERVER, GLOBAL_DBNAME, LOG_ARCHIVE_DEST_2, PROTOCOL, SID, SID_DESC, SID_LIST, SID_LIST_LISTENER_5322, VALID_FOR, variables` |
| `rman_output.sql` | Oracle RMAN backup, restore or recovery helper: rman output. | `DESTRUCTIVE` | `variables` |
| `rman_recover_from_service.sh` | Oracle RMAN backup, restore or recovery helper: rman recover from service. | `DESTRUCTIVE` | `-` |
| `rman_restore_archivelog_to_standby.sh` | Oracle RMAN backup, restore or recovery helper: rman restore archivelog to standby. | `DESTRUCTIVE` | `-` |
| `rman_restore_from_service_set_newname.sh` | Oracle RMAN backup, restore or recovery helper: rman restore from service set newname. | `DESTRUCTIVE` | `-` |
| `rman_running.sql` | Oracle RMAN backup, restore or recovery helper: rman running. | `DESTRUCTIVE` | `MI, SS, STATUS, variables` |
| `rman_status.sql` | Oracle RMAN backup, restore or recovery helper: rman status. | `DESTRUCTIVE` | `operation, status, variables` |
| `session_longops_rman.sql` | Oracle RMAN backup, restore or recovery helper: session longops rman. | `DESTRUCTIVE` | `variables` |
