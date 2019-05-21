undefine all
define tbs=&1
set lines 185
set pages 40
set serveroutput on
col file_id for 99999
col end_block for 9,999,999,999,999
col end_bytes for 9,999,999,999,999,999
col aloc_bytes for 9,999,999,999,999,999
col used_bytes for 9,999,999,999,999,999

declare
v_tbs varchar(35) := upper('&tbs');
v_file_name varchar(100);
v_fileid integer;
v_mb integer;
v_resize_bytes integer;
v_rec_space integer := 0;
sqlstr varchar(1000);

cursor df_cursor
is
select df.file_id, df.file_name, bytes/1024/1024 mb, (nvl(end,0)+1)*tb.block_size resize_bytes
from dba_tablespaces tb
, dba_data_files df
, (select tablespace_name,file_id,max(ext.block_id+ext.blocks) end
    from dba_extents ext
    group by tablespace_name,file_id
) ext
where tb.TABLESPACE_NAME like upper('%&tbs%')
and tb.tablespace_name=df.tablespace_name
and df.tablespace_name=ext.tablespace_name (+)
and ((bytes/1024/1024) - (((nvl(end,0)+1)*tb.block_size )/1024/1024)) > &mbtoshrink
and df.file_id=ext.file_id (+)
order by ext.file_id
;

begin

open df_cursor;
loop
        fetch df_cursor into v_fileid, v_file_name, v_mb, v_resize_bytes;
EXIT WHEN df_cursor%NOTFOUND; 
if v_resize_bytes < 10*1024*1024 -- 10mb
then v_resize_bytes := 10*1024*1024;
end if;
v_rec_space := v_rec_space + (v_mb - (v_resize_bytes/1024/1024));
sqlstr :='alter database datafile '''||v_file_name||''' resize '||v_resize_bytes;
dbms_output.put_line(' -- Current size '||v_mb||', resize mb: '||(v_resize_bytes/1024/1024)||', diff MB: '||(v_mb - (v_resize_bytes/1024/1024)));
dbms_output.put_line(sqlstr);
dbms_output.put_line('/');
--execute immediate sqlstr;
--sqlstr :='alter database datafile '||v_fileid||' autoextend off ';
--execute immediate sqlstr;

end loop;
dbms_output.put_line('Reclaimed space: '||v_rec_space||' MB');
end;
/
