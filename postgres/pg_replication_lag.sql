--run in replica
-- https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PostgreSQL.optimizedreads.html
select now() - pg_last_xact_replay_timestamp() AS replication_delay;

SELECT
  pg_is_in_recovery() AS is_slave,
  pg_last_wal_receive_lsn() AS receive,
  pg_last_wal_replay_lsn() AS replay,
  pg_last_wal_receive_lsn() = pg_last_wal_replay_lsn() AS synced,
  (
   EXTRACT(EPOCH FROM now()) -
   EXTRACT(EPOCH FROM pg_last_xact_replay_timestamp())
  )::int AS lag;