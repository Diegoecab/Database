set lines 1500
col mode_requested for a10
col lock_id1 for a10
col lock_id2 for a10

select
sid session_id,
decode(type,
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
'TT', 'Temp Table',
type) lock_type,
decode(lmode,
0, 'None', /* Mon Lock equivalent */
1, 'Null', /* N */
2, 'Row-S (SS)', /* L */
3, 'Row-X (SX)', /* R */
4, 'Share', /* S */
5, 'S/Row-X (SSX)', /* C */
6, 'Exclusive', /* X */
to_char(lmode)) mode_held,
decode(request,
0, 'None', /* Mon Lock equivalent */
1, 'Null', /* N */
2, 'Row-S (SS)', /* L */
3, 'Row-X (SX)', /* R */
4, 'Share', /* S */
5, 'S/Row-X (SSX)', /* C */
6, 'Exclusive', /* X */
to_char(request)) mode_requested,
to_char(id1) lock_id1, to_char(id2) lock_id2,
ctime last_convert,
decode(block,
0, 'Not Blocking', /* Not blocking any other processes */
1, 'Blocking', /* This lock blocks other processes */
2, 'Global', /* This lock is global, so we can't tell */
to_char(block)) blocking_others
from v$lock;