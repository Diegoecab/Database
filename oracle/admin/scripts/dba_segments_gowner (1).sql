select owner,round(sum(bytes/1024/1024/1024),1) GB from dba_Segments group by owner order by 2,1
/
