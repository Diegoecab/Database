/* Ejemplo 1 */
select    OS_USER_NAME USUARIO_SISTEMA_OPERATIVO,
    PROCESS NUMERO_PROCESO,
    ORACLE_USERNAME USUARIO_BD,
    l.SID SID_USUARIO,
    decode(TYPE,
        'MR', 'Media Recovery',
        'RT', 'Redo Thread',
        'UN', 'User Name',
        'TX', 'Transaction',
        'TM', 'DML',
        'UL', 'PL/SQL User Lock',
        'DX', 'Distributed Xaction',
        'CF', 'Control File',
        'IS', 'Instance State',
        'FS', 'File Set',
        'IR', 'Instance Recovery',
        'ST', 'Disk Space Transaction',
        'TS', 'Temp Segment',
        'IV', 'Library Cache Invalidation',
        'LS', 'Log Start or Switch',
        'RW', 'Row Wait',
        'SQ', 'Sequence Number',
        'TE', 'Extend Table',
        'TT', 'Temp Table', type) TIPO_LOCKEO,
    decode(LMODE,
        0, 'None',
        1, 'Null',
        2, 'Row-S (SS)',
        3, 'Row-X (SX)',
        4, 'Share',
        5, 'S/Row-X (SSX)',
        6, 'Exclusive', lmode) MODO_LOCKEO,
    decode(REQUEST,
        0, 'None',
        1, 'Null',
        2, 'Row-S (SS)',
        3, 'Row-X (SX)',
        4, 'Share',
        5, 'S/Row-X (SSX)',
        6, 'Exclusive', request) LOCKEO_PEDIDO,
    decode(BLOCK,
        0, 'Not Blocking',
        1, 'Blocking',
        2, 'Global', block) ESTADO,
    OWNER,
    OBJECT_NAME OBJETO
from    v$locked_object lo,
    dba_objects do,
    v$lock l
where     lo.OBJECT_ID = do.OBJECT_ID
AND     l.SID = lo.SESSION_ID


/* Ejemplo 2 */



select distinct table_name, constraint_name from dba_constraints where constraint_type='R' and table_name in (

select distinct table_name from dba_constraints where constraint_type='R' and table_name in (
select object_name table_name from lockeos)

/* Ejemplo 3 */

select s.sid, 
       s.username "Wait User", 
       l2.sid, 
       s2.username "Lock User",
       us.name "Owner",
       ob.name "Object"
  from v$session s, 
       v$lock l, 
       v$lock l2,
       v$session s2,
       v$resource re,
       sys.obj$ ob,
       sys.user$ us
 where s.lockwait is not null
   and l.sid = s.sid
   and l2.id1 = l.id1
   and s2.sid = l2.sid
   and s.sid != l2.sid
--   and l.lmode = 0
   and l2.id2 = 0
   and ob.owner# = us.user#
   and re.id1 = ob.obj#
   and l2.id1 = re.id1
 order by 1



/* Ejemplo 4 */

SELECT
substr(sess.username,1,9) username,
substr(sess.machine,1,5) machine,
sess.sid sid,
sess.serial# serial,
proc.pid pid,
proc.spid spid,
sess.terminal term,
decode(lck.type, 'RW','Rw wt enq','TM','DML enq',
'TX','Trans enq','UL','Usr sppld',
lck.type)||'('||
decode(lck.lmode,1,'Null', 2,'Row shr', 3,'Row excl',
4,'Shr', 5,'Shr row excl', 6,'Excl')||')' lock_type,
substr(decode(obj$.name,null,'?',obj$.name),1,30) obj_name,
substr(decode(obj$.type#, 0, 'NEXT OBJ', 1, 'INDEX ', 2, 'TABLE ',
3, 'CLUSTER ', 4, 'VIEW ', 5, 'SYNONYM ',
6, 'SEQUENCE', 7, 'PROC ', 8, 'FUNCTION',
9, 'PACKAGE ', 11, 'PKG BODY', 12, 'DATE ',
23, 'RAW ', 24, 'LONG RAW', 69, 'ROWID ',
96, 'CHAR ',105, 'MLSLABEL',106, 'MLSLABEL',
'? '),1,8) obj_type,
decode(lck.request,0,'Owner','...Waiter') wait
FROM
v$lock lck,
v$session sess,
sys.obj$,
v$process proc
WHERE
lck.sid = sess.sid AND
obj$.obj#(+) = lck.id1 AND
proc.addr = sess.paddr AND sess.username is not null AND
lck.id1||lck.type IN
(SELECT lck1.id1 || lck1.type
FROM v$lock lck1
WHERE lck1.request=0)
ORDER BY
obj_name,
wait desc
