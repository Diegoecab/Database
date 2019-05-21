/* Este script me da una lista de tablas a las que hace referencia una tabla en particular*/
SELECT DISTINCT B.TABLE_NAME FROM ALL_CONSTRAINTS A ,ALL_CONSTRAINTS B 
WHERE A.TABLE_NAME='NOMBRE_DE_TABLA' AND A.CONSTRAINT_TYPE ='R'
AND A.R_CONSTRAINT_NAME=B.CONSTRAINT_NAME

/* Este script busca las tablas hijas de una tabla en particular*/
SELECT TABLE_NAME, CONSTRAINT_NAME
  FROM ALL_CONSTRAINTS
 WHERE CONSTRAINT_TYPE = 'R'
   AND R_CONSTRAINT_NAME IN (
                  SELECT CONSTRAINT_NAME
                    FROM ALL_CONSTRAINTS
                   WHERE TABLE_NAME = 'ENT_ENTIDADES'
                         AND CONSTRAINT_TYPE = 'P')