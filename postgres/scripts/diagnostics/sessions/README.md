# postgres diagnostics/sessions

| Script | Description | Risk | Parameters |
|---|---|---|---|
| `autovacuum_pg_stat_activity.sql` | postgres diagnostics/sessions helper: autovacuum pg stat activity. | `CHANGES` | `-` |
| `current_query_pid.sql` | postgres diagnostics/sessions helper: current query pid. | `READ_ONLY` | `pid` |
| `kill_session.sql` | postgres diagnostics/sessions helper: kill session. | `DESTRUCTIVE` | `-` |
| `list_sessions.sql` | postgres diagnostics/sessions helper: list sessions. | `READ_ONLY` | `-` |
| `list_sessions_active.sql` | postgres diagnostics/sessions helper: list sessions active. | `READ_ONLY` | `-` |
| `pg_locks.sql` | postgres diagnostics/sessions helper: pg locks. | `READ_ONLY` | `-` |
| `pg_locks_fastpath.sql` | postgres diagnostics/sessions helper: pg locks fastpath. | `READ_ONLY` | `-` |
| `pg_stat_activity.sql` | postgres diagnostics/sessions helper: pg stat activity. | `READ_ONLY` | `-` |
| `postgres_lock_trees.sql` | postgres diagnostics/sessions helper: postgres lock trees. | `READ_ONLY` | `int, interval, text` |
| `top_wait_events.sql` | postgres diagnostics/sessions helper: top wait events. | `READ_ONLY` | `-` |
