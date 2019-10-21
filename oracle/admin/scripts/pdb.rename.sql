alter session set container=PDB_new;

alter pluggable database close;

alter pluggable database open restricted;
alter pluggable database rename global_name to PDB;