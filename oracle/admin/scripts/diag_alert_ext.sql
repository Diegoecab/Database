--diag_alert_ext
set lines 280
set pages 10000
col message_text for a120 word_wrap
col host_id for a25 truncate
select TO_CHAR(A.ORIGINATING_TIMESTAMP, 'dd.mm.yyyy hh24:mi:ss') MESSAGE_TIME
,message_text
,host_id	
,inst_id
--,component_id
from V$DIAG_ALERT_EXT A
where --component_id='rdbms'
ORIGINATING_TIMESTAMP > SYSDATE - INTERVAL '1400' MINUTE
--and
 --message_text like '%ORA-%'
order by ORIGINATING_TIMESTAMP;