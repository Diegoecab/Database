select B.SID, C.USERNAME, C.OSUSER, C.TERMINAL,
DECODE(B.ID2, 0, A.OBJECT_NAME,
'Trans-'||to_char(B.ID1)) OBJECT_NAME,
B.TYPE,
DECODE(B.LMODE,0,'--Waiting--',
1,'Null',
2,'Row Share',
3,'Row Excl',
4,'Share',
5,'Sha Row Exc',
6,'Exclusive',
'Other') "Lock Mode",
DECODE(B.REQUEST,0,' ',
1,'Null',
2,'Row Share',
3,'Row Excl',
4,'Share',
5,'Sha Row Exc',
6,'Exclusive',
'Other') "Req Mode"
from DBA_OBJECTS A, V$LOCK B, V$SESSION C
where A.OBJECT_ID(+) = B.ID1
and B.SID = C.SID
and C.USERNAME is not null
and A.owner = '&1'
A.object_name = '&2
order by B.SID, B.ID2;
