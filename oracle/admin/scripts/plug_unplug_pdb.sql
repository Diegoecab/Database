alter pluggable database pdb1 close;

alter pluggable database pdb1
unplug into '/tmp/pdb1.pdb';

create pluggable database pdb_new
using '/tmp/pdb1.pdb';

alter pluggable database pdb1
unplug into '/tmp/pdb1.xml' encrypt using "tpwd1";

create pluggable database pdb_new
using '/tmp/pdb1.xml' keystore identified by pass
decrypt using "tpwd1";



show pdbs;

drop pluggable database pdb1;


