
COLUMN con_name FORMAT A20
COLUMN instance_name FORMAT A20

SELECT con_name, instance_name, state FROM dba_pdb_saved_states;