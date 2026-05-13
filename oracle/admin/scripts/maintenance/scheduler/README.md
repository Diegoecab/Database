# oracle/admin maintenance/scheduler

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `Scheduler10g.sql` | Oracle database maintenance helper: Scheduler10g. | `READ_ONLY` | `MI, variables` |
| `abjobdefid.sql` | oracle/admin maintenance/scheduler helper: abjobdefid. | `CHANGES` | `system_name` |
| `crea_job.sql` | Oracle database maintenance helper: crea job. | `CHANGES` | `mi, ss, variables` |
| `dba_autotask_job_history.sql` | Oracle database maintenance helper: dba autotask job history. | `READ_ONLY` | `days, variables` |
| `dba_datapump_jobs.sql` | Oracle database maintenance helper: dba datapump jobs. | `DESTRUCTIVE` | `variables` |
| `dba_jobs.sql` | Oracle database maintenance helper: dba jobs (1). | `READ_ONLY` | `variables` |
| `dba_jobs_broken.sql` | Oracle database maintenance helper: dba jobs broken. | `READ_ONLY` | `variables` |
| `dba_scheduler_job_classes.sql` | Oracle database maintenance helper: dba scheduler job classes. | `READ_ONLY` | `variables` |
| `dba_scheduler_job_log.sql` | Oracle database maintenance helper: dba scheduler job log. | `READ_ONLY` | `job_name, variables` |
| `dba_scheduler_job_run_details.sql` | Oracle database maintenance helper: dba scheduler job run details. | `READ_ONLY` | `day, job_name, mi, variables` |
| `dba_scheduler_jobs.sql` | Oracle database maintenance helper: dba scheduler jobs. | `READ_ONLY` | `job_name, mi, ss, variables` |
| `dba_scheduler_programs.sql` | Oracle database maintenance helper: dba scheduler programs. | `READ_ONLY` | `variables` |
| `dba_scheduler_schedules.sql` | Oracle database maintenance helper: dba scheduler schedules. | `READ_ONLY` | `variables` |
| `dba_scheduler_window_groups.sql` | Oracle database maintenance helper: dba scheduler window groups. | `READ_ONLY` | `variables` |
| `dba_scheduler_windows.sql` | Oracle database maintenance helper: dba scheduler windows. | `DESTRUCTIVE` | `WINDOW_GROUP_NAME, mi, variables, window_name` |
| `dba_scheduler_windows_x.sql` | Oracle database maintenance helper: dba scheduler windows x. | `CHANGES` | `mi, variables, win_group_name, window_name` |
| `dbms_datapump.stop_job.sql` | Oracle database maintenance helper: dbms datapump stop job. | `REVIEW` | `JOB_NAME, OWNER_NAME, variables` |
| `dbms_jobs.remove.sql` | Oracle database maintenance helper: dbms jobs remove (1). | `DESTRUCTIVE` | `JOB, variables` |
| `dbms_jobs.remove_all.sql` | Oracle database maintenance helper: dbms jobs remove all. | `DESTRUCTIVE` | `variables` |
| `dbms_scheduler.add_window_group_member.sql` | Oracle database maintenance helper: dbms scheduler add window group member. | `REVIEW` | `group_name, variables, window_list_sep_coma` |
| `dbms_scheduler.close_window.sql` | Oracle database maintenance helper: dbms scheduler close window. | `READ_ONLY` | `WIN_NAME, variables` |
| `dbms_scheduler.create_job.sql` | Oracle database maintenance helper: dbms scheduler create job. | `CHANGES` | `FREQ, INTERVAL, comments, enabled, job_name, program_name, restartable, schedule_name, stop_on_window_close, variables` |
| `dbms_scheduler.create_program.sql` | Oracle database maintenance helper: dbms scheduler create program. | `CHANGES` | `comments, enabled, program_action, program_name, program_type, variables` |
| `dbms_scheduler.create_schedule.sql` | Oracle database maintenance helper: dbms scheduler create schedule. | `CHANGES` | `FREQ, comments, repeat_interval, schedule_name, start_date, variables` |
| `dbms_scheduler.create_window.sql` | Oracle database maintenance helper: dbms scheduler create window. | `CHANGES` | `FREQ, comments, duration_mins, end_date, repeat_interval, resource_plan, start_date, variables, window_name, window_priority` |
| `dbms_scheduler.create_window_group.sql` | Oracle database maintenance helper: dbms scheduler create window group. | `CHANGES` | `variables, window_group_name` |
| `dbms_scheduler.disable_job.sql` | Oracle database maintenance helper: dbms scheduler disable job. | `REVIEW` | `variables` |
| `dbms_scheduler.drop_job.sql` | Oracle database maintenance helper: dbms scheduler drop job. | `DESTRUCTIVE` | `force, job_name, variables` |
| `dbms_scheduler.drop_schedule.sql` | Oracle database maintenance helper: dbms scheduler drop schedule. | `DESTRUCTIVE` | `force, owner_schedule_name, variables` |
| `dbms_scheduler.drop_window.sql` | Oracle database maintenance helper: dbms scheduler drop window. | `DESTRUCTIVE` | `variables, window_list_sep_coma` |
| `dbms_scheduler.enable_job.sql` | Oracle database maintenance helper: dbms scheduler enable job. | `REVIEW` | `variables` |
| `dbms_scheduler.modify_job.sql` | Oracle database maintenance helper: dbms scheduler modify job. | `REVIEW` | `variables` |
| `dbms_scheduler.open_window.sql` | Oracle database maintenance helper: dbms scheduler open window. | `READ_ONLY` | `MINS, WIN_NAME, variables` |
| `dbms_scheduler.remove_window_group_member.sql` | Oracle database maintenance helper: dbms scheduler remove window group member. | `DESTRUCTIVE` | `group_name, variables, window_list_sep_coma` |
| `dbms_scheduler.stop_job.sql` | Oracle database maintenance helper: dbms scheduler stop job. | `REVIEW` | `job_name, variables` |
| `exp_jobsize.sql` | Oracle database maintenance helper: exp jobsize. | `CHANGES` | `variables` |
| `exp_jobsize2.sql` | Oracle database maintenance helper: exp jobsize2. | `READ_ONLY` | `variables` |
| `exp_jobsize_avgavg.sql` | Oracle database maintenance helper: exp jobsize avgavg. | `CHANGES` | `variables` |
| `exp_jobsize_avgmax.sql` | Oracle database maintenance helper: exp jobsize avgmax. | `CHANGES` | `variables` |
| `exp_jobsize_max.sql` | Oracle database maintenance helper: exp jobsize max. | `CHANGES` | `variables` |
| `job.sql` | Oracle database maintenance helper: job. | `READ_ONLY` | `variables` |
| `jobb.sql` | Oracle database maintenance helper: jobb. | `READ_ONLY` | `variables` |
| `jobs.sql` | Oracle database maintenance helper: jobs. | `READ_ONLY` | `MI, SS, variables` |
| `scheduler.sql` | Oracle database maintenance helper: scheduler. | `READ_ONLY` | `MI, variables` |
| `scheduler_running_jobs.sql` | Oracle database maintenance helper: scheduler running jobs. | `READ_ONLY` | `variables` |
