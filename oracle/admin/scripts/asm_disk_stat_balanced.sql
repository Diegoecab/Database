SELECT dg.group_number "GROUP#",
       dg.name,
       DECODE (total_dg.total_io, 0, 100, 100 * (DECODE (SIGN (1 - df.sum_io / total_dg.total_io), -1, 0, (1 - df.sum_io / total_dg.total_io)))) "IO_BALANCED"
  FROM (SELECT d.group_number group_number,
                 SUM (ABS ((d.reads + d.writes) - tot.avg_io)) sum_io
            FROM v$asm_disk_stat d,
                 (SELECT group_number,
                           SUM (reads) + SUM (writes),
                           DECODE (COUNT (*), 0, 0, (SUM (reads) + SUM (writes)) / COUNT (*)) avg_io
                      FROM v$asm_disk_stat
                     WHERE header_status = 'MEMBER'
                  GROUP BY group_number) tot
           WHERE header_status = 'MEMBER' AND tot.group_number = d.group_number
        GROUP BY d.group_number) df,
       (SELECT group_number,
                 SUM (reads) + SUM (writes) total_io
            FROM v$asm_disk_stat
           WHERE header_status = 'MEMBER'
        GROUP BY group_number) total_dg,
        V$ASM_DISKGROUP dg
 WHERE df.group_number = total_dg.group_number
 AND df.group_number = dg.group_number;