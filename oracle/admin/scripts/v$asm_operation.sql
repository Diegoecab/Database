set lines 1200 pages 1000
col error_code form a30
col name for a12
select dg.name, o.* from gv$asm_operation o, v$asm_diskgroup dg where o.group_number = dg.group_number;