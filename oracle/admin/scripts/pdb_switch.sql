prompt All PDBS within CDB
set lines 600
select pdb_id, PDB_NAME from cdb_pdbs;
show con_name;
alter session set container = CRGBITDP_RGBITDP;

alter session set container = CRGBILKP_SHLAKP;


