--Scripts which can be used to fetch the ranges/buckets for the boundaries from the source table:
SELECT nt, Max(<column_name>), Count(*) 
FROM (SELECT <column_name>, Ntile(4) over( ORDER BY <column_name>) nt FROM <table_name>) 
GROUP BY nt 
ORDER BY nt;
