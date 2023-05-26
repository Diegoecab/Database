set lines 500
var p1 number;
exec :p1:=1414332422;

select CHR (BITAND (:p1, -16777216) / 16777215)
|| CHR (BITAND (:p1, 16711680) / 65535)
“Name”,
(BITAND (:p1, 65535))”Mode”
from dual;
