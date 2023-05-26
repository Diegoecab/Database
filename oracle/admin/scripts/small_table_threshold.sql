--small_table_threshold.sql
select nam.ksppinm NAME,val.KSPPSTVL VALUE from x$ksppi nam, x$ksppsv val where nam.indx = val.indx and nam.ksppinm = '_small_table_threshold';

alter session set "_small_table_threshold"=500000;