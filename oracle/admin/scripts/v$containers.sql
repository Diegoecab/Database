col PDBName for a30
select con_id "PDBID", name "PDBName", application_root "AppRoot", application_pdb "AppPDB", 
application_seed "AppSeed" , application_root_con_id "AppRootID" from v$containers;