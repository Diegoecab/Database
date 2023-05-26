--create_part_table.sql
CREATE SEQUENCE db_requests_id_seq
  start 1
  increment 1;

CREATE TABLE IF NOT EXISTS db_requests
(
    id integer NOT NULL DEFAULT nextval('db_requests_id_seq'::regclass),
    id_action character varying(50) COLLATE pg_catalog."default" NOT NULL,
    source character varying(50) COLLATE pg_catalog."default" NOT NULL,
    submitter character varying(50) COLLATE pg_catalog."default" NOT NULL,
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    lifecycle character varying(50) COLLATE pg_catalog."default" NOT NULL,
    db_type character varying(20) COLLATE pg_catalog."default" NOT NULL,
    req_type character varying(20) COLLATE pg_catalog."default" NOT NULL,
    application_id integer NOT NULL,
    service_id integer NOT NULL,
    email_notif character varying(255) COLLATE pg_catalog."default" NOT NULL,
    maintenance_windows character varying(255) COLLATE pg_catalog."default" NOT NULL,
    status character varying(20) COLLATE pg_catalog."default" NOT NULL,
    sensitive_data boolean,
    relational boolean,
    mov_of_money boolean,
    affects_channels boolean,
    is_cluster boolean,
    instances integer,
    CONSTRAINT db_requests_pkey PRIMARY KEY (id, created_on)
) PARTITION BY RANGE (created_on);

ALTER TABLE IF EXISTS db_requests
    OWNER to "postgres";
-- Index: ix_db_requests_id_action

-- DROP INDEX IF EXISTS ix_db_requests_id_action;

CREATE INDEX IF NOT EXISTS ix_db_requests_id_action
    ON db_requests USING btree
    (id_action COLLATE pg_catalog."default" ASC NULLS LAST)
;

-- Partitions SQL

CREATE TABLE db_requests_2201 PARTITION OF db_requests
    FOR VALUES FROM ('2022-01-01 00:00:00') TO ('2022-02-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2201
    OWNER to "postgres";
CREATE TABLE db_requests_2202 PARTITION OF db_requests
    FOR VALUES FROM ('2022-02-01 00:00:00') TO ('2022-03-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2202
    OWNER to "postgres";
CREATE TABLE db_requests_2203 PARTITION OF db_requests
    FOR VALUES FROM ('2022-03-01 00:00:00') TO ('2022-04-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2203
    OWNER to "postgres";
CREATE TABLE db_requests_2204 PARTITION OF db_requests
    FOR VALUES FROM ('2022-04-01 00:00:00') TO ('2022-05-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2204
    OWNER to "postgres";
CREATE TABLE db_requests_2205 PARTITION OF db_requests
    FOR VALUES FROM ('2022-05-01 00:00:00') TO ('2022-06-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2205
    OWNER to "postgres";
CREATE TABLE db_requests_2206 PARTITION OF db_requests
    FOR VALUES FROM ('2022-06-01 00:00:00') TO ('2022-07-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2206
    OWNER to "postgres";
CREATE TABLE db_requests_2207 PARTITION OF db_requests
    FOR VALUES FROM ('2022-07-01 00:00:00') TO ('2022-08-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2207
    OWNER to "postgres";
CREATE TABLE db_requests_2208 PARTITION OF db_requests
    FOR VALUES FROM ('2022-08-01 00:00:00') TO ('2022-09-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2208
    OWNER to "postgres";
CREATE TABLE db_requests_2209 PARTITION OF db_requests
    FOR VALUES FROM ('2022-09-01 00:00:00') TO ('2022-10-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2209
    OWNER to "postgres";
CREATE TABLE db_requests_2210 PARTITION OF db_requests
    FOR VALUES FROM ('2022-10-01 00:00:00') TO ('2022-11-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2210
    OWNER to "postgres";
CREATE TABLE db_requests_2211 PARTITION OF db_requests
    FOR VALUES FROM ('2022-11-01 00:00:00') TO ('2022-12-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2211
    OWNER to "postgres";
CREATE TABLE db_requests_2212 PARTITION OF db_requests
    FOR VALUES FROM ('2022-12-01 00:00:00') TO ('2023-01-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2212
    OWNER to "postgres";
CREATE TABLE db_requests_2301 PARTITION OF db_requests
    FOR VALUES FROM ('2023-01-01 00:00:00') TO ('2023-02-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2301
    OWNER to "postgres";
CREATE TABLE db_requests_2302 PARTITION OF db_requests
    FOR VALUES FROM ('2023-02-01 00:00:00') TO ('2023-03-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2302
    OWNER to "postgres";
CREATE TABLE db_requests_2303 PARTITION OF db_requests
    FOR VALUES FROM ('2023-03-01 00:00:00') TO ('2023-04-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2303
    OWNER to "postgres";
CREATE TABLE db_requests_2304 PARTITION OF db_requests
    FOR VALUES FROM ('2023-04-01 00:00:00') TO ('2023-05-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2304
    OWNER to "postgres";
CREATE TABLE db_requests_2305 PARTITION OF db_requests
    FOR VALUES FROM ('2023-05-01 00:00:00') TO ('2023-06-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2305
    OWNER to "postgres";
CREATE TABLE db_requests_2306 PARTITION OF db_requests
    FOR VALUES FROM ('2023-06-01 00:00:00') TO ('2023-07-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2306
    OWNER to "postgres";
CREATE TABLE db_requests_2307 PARTITION OF db_requests
    FOR VALUES FROM ('2023-07-01 00:00:00') TO ('2023-08-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2307
    OWNER to "postgres";
CREATE TABLE db_requests_2308 PARTITION OF db_requests
    FOR VALUES FROM ('2023-08-01 00:00:00') TO ('2023-09-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2308
    OWNER to "postgres";
CREATE TABLE db_requests_2309 PARTITION OF db_requests
    FOR VALUES FROM ('2023-09-01 00:00:00') TO ('2023-10-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2309
    OWNER to "postgres";
CREATE TABLE db_requests_2310 PARTITION OF db_requests
    FOR VALUES FROM ('2023-10-01 00:00:00') TO ('2023-11-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2310
    OWNER to "postgres";
CREATE TABLE db_requests_2311 PARTITION OF db_requests
    FOR VALUES FROM ('2023-11-01 00:00:00') TO ('2023-12-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2311
    OWNER to "postgres";
CREATE TABLE db_requests_2312 PARTITION OF db_requests
    FOR VALUES FROM ('2023-12-01 00:00:00') TO ('2024-01-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2312
    OWNER to "postgres";
CREATE TABLE db_requests_2401 PARTITION OF db_requests
    FOR VALUES FROM ('2024-01-01 00:00:00') TO ('2024-02-01 00:00:00');

ALTER TABLE IF EXISTS db_requests_2401
    OWNER to "postgres";