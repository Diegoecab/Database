rman target sys/npd-sys-2014@CELULARP auxiliary sys/npd-sys-2014@CELULARD


run {
allocate channel primary1 type disk;
allocate channel primary2 type disk;
allocate channel primary3 type disk;
allocate channel primary4 type disk;
allocate auxiliary channel aux1 type disk;
allocate auxiliary channel aux2 type disk;
allocate auxiliary channel aux3 type disk;
allocate auxiliary channel aux4 type disk;
duplicate target database to 'CELULARD' from active database;
}



run {

CONFIGURE DEVICE TYPE DISK PARALLELISM 4 BACKUP TYPE TO COMPRESSED BACKUPSET;

BACKUP DATABASE;
}

