# oracle/admin security

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `Auditoria.sql` | Oracle security, audit, user, role or grants helper: Auditoria. | `DESTRUCTIVE` | `variables` |
| `Privilegios.sql` | Oracle security, audit, user, role or grants helper: Privilegios. | `CHANGES` | `PRIVILEGE, variables` |
| `audit.sql` | Oracle security, audit, user, role or grants helper: audit(1). | `READ_ONLY` | `variables` |
| `audit1.sql` | Oracle security, audit, user, role or grants helper: audit1. | `READ_ONLY` | `variables` |
| `audit_cp_files.sh` | Oracle security, audit, user, role or grants helper: audit cp files(1). | `REVIEW` | `arg9` |
| `audit_unified_enabled_policies.sql` | Oracle security, audit, user, role or grants helper: audit unified enabled policies. | `READ_ONLY` | `variables` |
| `audit_unified_policies.sql` | Oracle security, audit, user, role or grants helper: audit unified policies. | `READ_ONLY` | `variables` |
| `auditoria_vistas.sql` | Oracle security, audit, user, role or grants helper: auditoria vistas. | `READ_ONLY` | `variables` |
| `cdb_unified_audit_trail.sql` | Oracle security, audit, user, role or grants helper: cdb unified audit trail. | `READ_ONLY` | `variables` |
| `cdb_users.sql` | Oracle security, audit, user, role or grants helper: cdb users(1). | `READ_ONLY` | `variables` |
| `copyuser.sql` | Script to create a new user (with privs) like an existing | `CHANGES` | `newname, oldname, psw` |
| `cr_create_user.sql` | Oracle security, audit, user, role or grants helper: cr create user. | `CHANGES` | `variables` |
| `create_policy_unified_audit_db_schema_changes.sql` | Oracle security, audit, user, role or grants helper: create policy unified audit db schema changes. | `DESTRUCTIVE` | `variables` |
| `crs.get.node.role.status.sh` | Oracle security, audit, user, role or grants helper: crs get node role status. | `REVIEW` | `-` |
| `db_link_dbms_sys_sql.parse_as_user.sql` | Oracle security, audit, user, role or grants helper: db link dbms sys sql parse as user. | `CHANGES` | `variables` |
| `dba_audit_mgmt_config_params.sql` | Oracle security, audit, user, role or grants helper: dba audit mgmt config params. | `READ_ONLY` | `variables` |
| `dba_audit_mgmt_last_arch_ts.sql` | Oracle security, audit, user, role or grants helper: dba audit mgmt last arch ts. | `READ_ONLY` | `variables` |
| `dba_audit_policies.sql` | Oracle security, audit, user, role or grants helper: dba audit policies. | `READ_ONLY` | `variables` |
| `dba_audit_trail.sql` | Oracle security, audit, user, role or grants helper: dba audit trail. | `READ_ONLY` | `action_name, days, os_username, returncode, username, variables` |
| `dba_audit_trail_html.sql` | Oracle security, audit, user, role or grants helper: dba audit trail html. | `READ_ONLY` | `variables` |
| `dba_fga_audit_trail.sql` | Oracle security, audit, user, role or grants helper: dba fga audit trail. | `READ_ONLY` | `variables` |
| `dba_hist_snapshot_username.sql` | Oracle security, audit, user, role or grants helper: dba hist snapshot username. | `READ_ONLY` | `SNAPF, SNAPI, days, schema, variables` |
| `dba_role_privs.sql` | Oracle security, audit, user, role or grants helper: dba role privs. | `CHANGES` | `admin_option, default_role, granted_role, grantee, variables` |
| `dba_role_privs_x.sql` | Oracle security, audit, user, role or grants helper: dba role privs x (1). | `READ_ONLY` | `ROLE, variables` |
| `dba_roles.sql` | Oracle security, audit, user, role or grants helper: dba roles. | `READ_ONLY` | `role, variables` |
| `dba_rsrc_consumer_group_privs.sql` | Oracle security, audit, user, role or grants helper: dba rsrc consumer group privs. | `READ_ONLY` | `variables` |
| `dba_sys_privs.sql` | Oracle security, audit, user, role or grants helper: dba sys privs. | `CHANGES` | `admin_option, grantee, privilege, variables` |
| `dba_sys_privs_x.sql` | Oracle security, audit, user, role or grants helper: dba sys privs x. | `CHANGES` | `admin_option, grantee, privilege, variables` |
| `dba_tab_privs.sql` | Oracle security, audit, user, role or grants helper: dba tab privs. | `CHANGES` | `grantable, grantee, grantor, owner, privilege, table_name, variables` |
| `dba_tab_privs_x.sql` | Oracle security, audit, user, role or grants helper: dba tab privs x. | `READ_ONLY` | `grantable, grantee, grantor, owner, privilege, table_name, variables` |
| `dba_tab_privs_xd.sql` | Oracle security, audit, user, role or grants helper: dba tab privs xd. | `READ_ONLY` | `GRANTEE, USUARIO, usuario, variables` |
| `dba_users.sql` | Oracle security, audit, user, role or grants helper: dba users. | `DESTRUCTIVE` | `username, variables` |
| `dba_users_password_changed.sql` | Oracle security, audit, user, role or grants helper: dba users password changed. | `READ_ONLY` | `sysdate, username, variables` |
| `dba_users_x.sql` | Oracle security, audit, user, role or grants helper: dba users x. | `READ_ONLY` | `usuario, variables` |
| `depura_orabpel_audit.sh` | Oracle security, audit, user, role or grants helper: depura orabpel audit. | `DESTRUCTIVE` | `AMBIENTE, CRITICAL, DATFILE, HOST, MAIL_DBAS, MAIL_MSG, MAIL_OPERADORES, MAIL_TO, NOTIFICATION, ORACLE_SID, TIPO, TMPFILE, WARNING, arg1, arg2, arg3, arg4` |
| `drop_user_cascade.sql` | Oracle security, audit, user, role or grants helper: drop user cascade. | `DESTRUCTIVE` | `OWNER, variables` |
| `drop_user_cascade_new.sql` | Oracle security, audit, user, role or grants helper: drop user cascade new. | `DESTRUCTIVE` | `OWNER, variables` |
| `enable_trace_role_plustrace.sql` | Oracle security, audit, user, role or grants helper: enable trace role plustrace. | `CHANGES` | `variables` |
| `get_ddl_indexes_grants.sql` | Oracle security, audit, user, role or grants helper: get ddl indexes grants. | `CHANGES` | `OWNER, TABLE_NAME, owner, table_name, variables` |
| `get_ddl_user.sql` | Oracle security, audit, user, role or grants helper: get ddl user. | `CHANGES` | `username, variables` |
| `grant_all_readonly.sql` | Oracle security, audit, user, role or grants helper: grant all readonly. | `CHANGES` | `grantee, owner, variables` |
| `grants_all.sql` | Oracle security, audit, user, role or grants helper: grants all. | `DESTRUCTIVE` | `grantee, owner, variables` |
| `grants_obj_esquema_users.sql` | oracle/admin security helper: grants obj esquema users. | `CHANGES` | `SCHEMA` |
| `iduser.sql` | Oracle security, audit, user, role or grants helper: iduser. | `READ_ONLY` | `MI, SS, variables` |
| `iduser1.sql` | Oracle security, audit, user, role or grants helper: iduser1. | `READ_ONLY` | `MI, SS, variables` |
| `iduser2.sql` | Oracle security, audit, user, role or grants helper: iduser2. | `DESTRUCTIVE` | `MI, SS, variables` |
| `listener_log_grep_users_host.sh` | Oracle security, audit, user, role or grants helper: listener log grep users host. | `REVIEW` | `HOST, ORASID, PROGRAM, USER, arg1` |
| `mem_by_users.sh` | Oracle security, audit, user, role or grants helper: mem by users. | `REVIEW` | `arg1, arg2` |
| `owb_runtime.wb_rt_audit_etl_udt_suc_4.sql` | Oracle security, audit, user, role or grants helper: owb runtime wb rt audit etl udt suc 4. | `READ_ONLY` | `variables` |
| `pga_by_users.sql` | Oracle security, audit, user, role or grants helper: pga by users. | `DESTRUCTIVE` | `MI, SS, variables` |
| `ps_mon_chklist_det_history_guser.sql` | Oracle security, audit, user, role or grants helper: ps mon chklist det history guser. | `CHANGES` | `btime, etime, spool_name, variables` |
| `role_privs_x.sql` | oracle/admin security helper: role privs x. | `READ_ONLY` | `ROLE` |
| `role_sys_privs.sql` | Oracle security, audit, user, role or grants helper: role sys privs. | `READ_ONLY` | `admin_option, privilege, role, variables` |
| `role_tab_privs.sql` | Oracle security, audit, user, role or grants helper: role tab privs. | `READ_ONLY` | `column_name, grantable, owner, privilege, role, table_name, variables` |
| `roleprivs.sql` | Oracle security, audit, user, role or grants helper: roleprivs. | `READ_ONLY` | `variables` |
| `roles_usuariosxrol.sql` | oracle/admin security helper: roles usuariosxrol. | `READ_ONLY` | `ROL` |
| `selectGRANTs.sql` | Oracle security, audit, user, role or grants helper: selectGRANTs. | `READ_ONLY` | `LOWNER, TNAME, variables` |
| `show_user_mem_usage.sh` | Oracle security, audit, user, role or grants helper: show user mem usage. | `READ_ONLY` | `arg1, arg4` |
| `sqlarea_user_io_w_time.sql` | Oracle security, audit, user, role or grants helper: sqlarea user io w time. | `READ_ONLY` | `variables` |
| `sysprivs.sql` | Oracle security, audit, user, role or grants helper: sysprivs. | `READ_ONLY` | `variables` |
| `system_privilege_map.sql` | Oracle security, audit, user, role or grants helper: system privilege map. | `READ_ONLY` | `variables` |
| `tabprivs.sql` | Oracle security, audit, user, role or grants helper: tabprivs. | `READ_ONLY` | `variables` |
| `temp_x_user.sql` | Oracle security, audit, user, role or grants helper: temp x user. | `READ_ONLY` | `variables` |
| `truncate_audit_execution_tables_10_1.sql` | Oracle security, audit, user, role or grants helper: truncate audit execution tables 10 1. | `DESTRUCTIVE` | `variables` |
| `truncate_audit_execution_tables_10_2.sql` | Oracle security, audit, user, role or grants helper: truncate audit execution tables 10 2. | `DESTRUCTIVE` | `variables` |
| `undo_xuser.sql` | oracle/admin security helper: undo xuser. | `READ_ONLY` | `-` |
| `unified_audit_policies_examples.sql` | Oracle security, audit, user, role or grants helper: unified audit policies examples. | `DESTRUCTIVE` | `variables` |
| `unified_audit_trail.sql` | Oracle security, audit, user, role or grants helper: unified audit trail. | `DESTRUCTIVE` | `variables` |
| `user.sql` | Oracle security, audit, user, role or grants helper: user. | `READ_ONLY` | `variables` |
| `user_base_table.sql` | Oracle security, audit, user, role or grants helper: user$. | `READ_ONLY` | `name, variables` |
| `user_clone.sql` | oracle/admin security helper: user clone. | `CHANGES` | `newuser, passwd, poo, userid` |
| `user_conf.sql` | oracle/admin security helper: user conf. | `READ_ONLY` | `userid` |
| `user_deps_obj.sql` | oracle/admin security helper: user deps obj. | `READ_ONLY` | `owner` |
| `user_deps_obj_x.sql` | oracle/admin security helper: user deps obj x. | `READ_ONLY` | `OBJ, OWNER, owner` |
| `user_obj_grants.sql` | oracle/admin security helper: user obj grants. | `READ_ONLY` | `usuario` |
| `user_recrea.sql` | oracle/admin security helper: user recrea. | `DESTRUCTIVE` | `direc, mi, ss, userid` |
| `user_segments.sql` | Oracle security, audit, user, role or grants helper: user segments. | `DESTRUCTIVE` | `gb, partition_mame, segment_name, segment_type, tablespace_name, variables` |
| `user_sql_trace.sql` | Oracle security, audit, user, role or grants helper: user sql trace. | `CHANGES` | `variables` |
