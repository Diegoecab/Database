alter pluggable database pdb_new close immediate;
ALTER PLUGGABLE DATABASE ALL EXCEPT pdb1 CLOSE IMMEDIATE;

ALTER PLUGGABLE DATABASE ALL CLOSE IMMEDIATE;

alter pluggable database pdb_new close force;
