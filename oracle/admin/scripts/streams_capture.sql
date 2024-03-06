set lines 900
col state for a30
select inst_id, capture_name, STATE from gv$STREAMS_CAPTURE;