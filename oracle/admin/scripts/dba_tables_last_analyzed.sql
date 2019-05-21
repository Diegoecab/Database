set linesize 150
SELECT   TO_CHAR(TRUNC (last_analyzed),'DD/MM/YYYY') fecha,
         (CASE
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 0
                THEN 'Domingo'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 1
                THEN 'Lunes'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 2
                THEN 'Martes'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 3
                THEN 'Miercoles'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 4
                THEN 'Jueves'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 5
                THEN 'Viernes'
             WHEN TO_CHAR (TRUNC (last_analyzed), 'D') = 6
                THEN 'Sabado'
          END
         ) dia,
         MIN (last_analyzed), MAX (last_analyzed)
    FROM dba_tables
   WHERE last_analyzed IS NOT NULL
GROUP BY TRUNC (last_analyzed)
ORDER BY TRUNC (last_analyzed) DESC
/