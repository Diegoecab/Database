SET PAGESIZE 60
SET LINESIZE 300
SET VERIFY OFF
 
COLUMN scn FOR 999999999999999
COLUMN Incar FOR 99
COLUMN name FOR A25
COLUMN storage_size FOR 9999999999999
COLUMN guarantee_flashback_database FOR A3
 
SELECT 
      database_incarnation# as Incar,
      scn,
      name,
      time,
      storage_size/1024/1024,
      guarantee_flashback_database
FROM 
      v$restore_point
ORDER BY 4
/