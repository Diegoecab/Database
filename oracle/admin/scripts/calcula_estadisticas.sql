select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') from dual;
begin
  for r in (select distinct owner
            from dba_tables
            where owner not in ('SYS','SYSTEM','OUTLN','CTXSYS','DBSNMP'))
  loop
     dbms_stats.GATHER_SCHEMA_STATS( r.owner, dbms_stats.AUTO_SAMPLE_SIZE, CASCADE=>true);
  end loop;
end;
/
exit
