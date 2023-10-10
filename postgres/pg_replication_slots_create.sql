--Test decoding
SELECT * FROM pg_create_logical_replication_slot('mydmssource_replication_slot', 'test_decoding');
