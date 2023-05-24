alter session set current_schema=RMAN;
select output from rc_rman_output where session_key=34838130 order by STAMP;