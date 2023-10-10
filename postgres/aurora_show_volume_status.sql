\! echo 
\! echo Disks — The total number of logical blocks of data for the DB cluster volume.
\! echo Nodes — The total number of storage nodes for the DB cluster volume.
\! echo ""
SELECT * FROM aurora_show_volume_status();
