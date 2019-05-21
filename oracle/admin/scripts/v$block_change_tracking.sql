col filename for a50
select status,filename,round(bytes/1024/1024,1) MB from v$block_change_tracking
/