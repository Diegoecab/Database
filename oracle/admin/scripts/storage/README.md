# oracle/admin storage

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `Default_Tmp_Tablespace_Database.sql` | oracle/admin storage helper: Default Tmp Tablespace Database. | `READ_ONLY` | `-` |
| `acfs_create.sh` | Oracle storage, ASM, ACFS or tablespace helper: acfs create. | `CHANGES` | `ORACLE_HOME, ORACLE_SID, PATH` |
| `acfs_drop.sh` | Oracle storage, ASM, ACFS or tablespace helper: acfs drop. | `DESTRUCTIVE` | `-` |
| `acfs_mount.sh` | Oracle storage, ASM, ACFS or tablespace helper: acfs mount. | `CHANGES` | `-` |
| `acfs_resize.sh` | Oracle storage, ASM, ACFS or tablespace helper: acfs resize. | `REVIEW` | `-` |
| `acfs_throubleshooting.sh` | Oracle storage, ASM, ACFS or tablespace helper: acfs throubleshooting. | `READ_ONLY` | `-` |
| `acfs_volinfo.sh` | Oracle storage, ASM, ACFS or tablespace helper: acfs volinfo. | `REVIEW` | `-` |
| `afd_asmlib.sh` | Oracle storage, ASM, ACFS or tablespace helper: afd asmlib. | `REVIEW` | `ACL, grid, oinstall, rwx` |
| `afd_asmlib_unlabel.sh` | Oracle storage, ASM, ACFS or tablespace helper: afd asmlib unlabel. | `REVIEW` | `-` |
| `asfs.acfsutil.info.sh` | Oracle storage, ASM, ACFS or tablespace helper: asfs acfsutil info(1). | `REVIEW` | `-` |
| `asm.pwmove.sh` | Oracle storage, ASM, ACFS or tablespace helper: asm pwmove(1). | `REVIEW` | `-` |
| `asm_adddisk_asmlib.sh` | Oracle storage, ASM, ACFS or tablespace helper: asm adddisk asmlib(1). | `CHANGES` | `DATA013` |
| `asm_attribute.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm attribute. | `READ_ONLY` | `variables` |
| `asm_cp.sh` | Oracle storage, ASM, ACFS or tablespace helper: asm cp(1). | `REVIEW` | `DBI_TRACE` |
| `asm_dg.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm dg. | `READ_ONLY` | `dg, variables` |
| `asm_dg2.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm dg2. | `READ_ONLY` | `dg, variables` |
| `asm_disk.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm disk. | `READ_ONLY` | `dg, variables` |
| `asm_disk_balanced.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm disk balanced. | `READ_ONLY` | `DG, variables` |
| `asm_disk_iostat.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm disk iostat(1). | `DESTRUCTIVE` | `INST_ID, variables` |
| `asm_disk_stat_balanced.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm disk stat balanced. | `READ_ONLY` | `variables` |
| `asm_diskgroup.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm diskgroup. | `READ_ONLY` | `variables` |
| `asm_disks.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm disks. | `READ_ONLY` | `dg, variables` |
| `asm_disks_dg.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm disks dg. | `READ_ONLY` | `dg, variables` |
| `asm_get_formatted_metadata.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm get formatted metadata(1). | `CHANGES` | `MI, NLS_DATE_FORMAT, SS, variables` |
| `asm_healthcheck.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm healthcheck(1). | `DESTRUCTIVE` | `asm_disk, asm_diskgroup, variables` |
| `asm_io.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm io. | `READ_ONLY` | `variables` |
| `asm_list_files.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm list files. | `READ_ONLY` | `variables` |
| `asm_op.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm op. | `READ_ONLY` | `variables` |
| `asm_operation.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm operation. | `READ_ONLY` | `variables` |
| `asm_status.sql` | Oracle storage, ASM, ACFS or tablespace helper: asm status. | `READ_ONLY` | `variables` |
| `asmcmd_clustermode.sh` | Oracle storage, ASM, ACFS or tablespace helper: asmcmd clustermode. | `REVIEW` | `-` |
| `asmcmd_script.sh` | Oracle storage, ASM, ACFS or tablespace helper: asmcmd script(1). | `REVIEW` | `-` |
| `asmdu.sh` | Oracle storage, ASM, ACFS or tablespace helper: asmdu(1). | `REVIEW` | `arg1, arg2, arg3` |
| `asmdu2.sh` | oracle/admin storage helper: asmdu2. | `DESTRUCTIVE` | `COLOR, CRITICAL, DEFAULT_NOCOLOR, DEFAULT_UNIT, DEFAULT_VERBOSE, DIVIDER, END_COLOR, NOCOLOR, OLD_SID, ORACLE_SID, ORAENV_ASK, PARAM_NOCOLOR, PARAM_UNIT, PARAM_VERBOSE, RED_DIV, SUBDIR, UNIT, VERBOSE, VERSION, WARNING, WHITE, arg1, arg2, arg3, mgtnvhV` |
| `asmiostat.sh` | oracle/admin storage helper: asmiostat. | `READ_ONLY` | `LD_LIBRARY_PATH, MI, NLS_DATE_FORMAT, NLS_LANG, ORACLE_HOME, ORACLE_SID, SS, arg1, arg10, arg11, arg12, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9` |
| `asmlib.sh` | Oracle storage, ASM, ACFS or tablespace helper: asmlib(1). | `REVIEW` | `-` |
| `asmlib_diskslists.sh` | Oracle storage, ASM, ACFS or tablespace helper: asmlib diskslists. | `REVIEW` | `arg1, arg10, arg2` |
| `cdb_tablespaces.sql` | Oracle storage, ASM, ACFS or tablespace helper: cdb tablespaces(1). | `READ_ONLY` | `variables` |
| `datafile_free_space_ftablespace.sql` | oracle/admin storage helper: datafile free space ftablespace. | `READ_ONLY` | `TABLESPACE` |
| `dba_hist_tablespace_stat.sql` | Oracle storage, ASM, ACFS or tablespace helper: dba hist tablespace stat. | `READ_ONLY` | `days, m_dbid, m_instance, status, variables` |
| `dba_hist_tbspc_space_tablespace_usage.sql` | Oracle storage, ASM, ACFS or tablespace helper: dba hist tbspc space tablespace usage. | `READ_ONLY` | `MI, SS, variables` |
| `dba_tablespace_usage_metrics.sql` | Oracle storage, ASM, ACFS or tablespace helper: dba tablespace usage metrics. | `READ_ONLY` | `variables` |
| `dba_tablespaces.sql` | Oracle storage, ASM, ACFS or tablespace helper: dba tablespaces. | `READ_ONLY` | `variables` |
| `espacioenFSxtablespace-datafile-xFileSystem.sql` | Oracle storage, ASM, ACFS or tablespace helper: espacioenFSxtablespace datafile xFileSystem. | `READ_ONLY` | `FILE_NAME, variables` |
| `espacioenFSxtablespace-datafile.sql` | Oracle storage, ASM, ACFS or tablespace helper: espacioenFSxtablespace datafile. | `DESTRUCTIVE` | `TABLESPACE_NAME, variables` |
| `get_ddl_tablespaces.sql` | Oracle storage, ASM, ACFS or tablespace helper: get ddl tablespaces (1). | `CHANGES` | `variables` |
| `objetosenTablespace.sql` | Oracle storage, ASM, ACFS or tablespace helper: objetosenTablespace. | `READ_ONLY` | `TABLESPACE, variables` |
| `pwcopy_passwordfile.asm.sh` | Oracle storage, ASM, ACFS or tablespace helper: pwcopy passwordfile asm. | `REVIEW` | `-` |
| `srvctl.asm.status.sh` | Oracle storage, ASM, ACFS or tablespace helper: srvctl asm status. | `REVIEW` | `-` |
| `tablespace_growth.sql` | Oracle storage, ASM, ACFS or tablespace helper: tablespace growth. | `READ_ONLY` | `MI, SS, variables` |
| `tbs.sql` | Oracle storage, ASM, ACFS or tablespace helper: tbs (2). | `READ_ONLY` | `variables` |
| `tbs2.sql` | oracle/admin storage helper: tbs2. | `READ_ONLY` | `xxhost, xxinst, xxrun_date` |
| `tbs3.sql` | Oracle storage, ASM, ACFS or tablespace helper: tbs3. | `READ_ONLY` | `variables` |
| `tbs_df.sql` | Oracle storage, ASM, ACFS or tablespace helper: tbs df. | `READ_ONLY` | `variables` |
| `tbs_espacioaAsignar.sql` | Oracle storage, ASM, ACFS or tablespace helper: tbs espacioaAsignar. | `READ_ONLY` | `variables` |
| `tbs_temp.sql` | Oracle storage, ASM, ACFS or tablespace helper: tbs temp (1). | `READ_ONLY` | `PROPERTY_NAME, variables` |
| `tbs_temp_state.sql` | oracle/admin storage helper: tbs temp state. | `READ_ONLY` | `-` |
| `tbs_x.sql` | Oracle storage, ASM, ACFS or tablespace helper: tbs x. | `READ_ONLY` | `TABLESPACE, variables` |
| `tbspaces_add_space_ae_pl.sql` | Oracle storage, ASM, ACFS or tablespace helper: tbspaces add space ae pl. | `CHANGES` | `exec_yn, free_space_margin, max_df_size, variables` |
| `tbsx.sql` | Oracle storage, ASM, ACFS or tablespace helper: tbsx (2). | `READ_ONLY` | `base, variables` |
