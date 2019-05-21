select 'alter index '||index_name||
' rebuild '||chr(10)||
' pctfree 0 TABLESPACE '||
decode(sign(s.bytes - 32000000),1, 'INDEX2  STORAGE (INITIAL 10M NEXT 10M PCTINCREASE 0 MAXEXTENTS 1024);',
decode(sign(s.bytes - 4000000),1, 'INDEX1  STORAGE (INITIAL 128k NEXT 128k PCTINCREASE 0 MAXEXTENTS 1024);',
'INDEX0 STORAGE (INITIAL 16k NEXT 16k PCTINCREASE 0 MAXEXTENTS 1024);'))
from user_indexes i,user_segments s
where index_name = segment_name
and segment_type='INDEX'
--and s.tablespace_name='INDEX0'
--and bytes>5000000
and INDEX_NAME like '&&1%'
order by bytes desc
/
