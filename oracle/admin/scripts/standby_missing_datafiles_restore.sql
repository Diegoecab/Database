select file#, name, status, BYTES from v$datafile;


select file#, name, status, BYTES from v$datafile where bytes = 0;


select 'restore datafile '||file#||' from service CSIBSP_PRIMARY;' from v$datafile where bytes = 0;