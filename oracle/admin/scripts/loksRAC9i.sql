-- Detalle de session por proceso ( x nodo )
select * from gv$session  where paddr in  ( SELECT addr FROM gv$process where spid = 22235 )

--- Detecta que usuario está lockeado ----------------------------

select inst_id,username, program, status, lockwait
from gv$session
where username is not null
and lockwait is not null

--------------- DETECTAR LOCKEOS - QUIEN LOCKEA Y QUIEN ESTA LOCKEADO

SELECT   sn.username, sn.inst_id, sn.sid, sn.serial#, m.TYPE,           
         DECODE (                                                       
            m.lmode,                                                    
            0, 'None',                                                  
            1, 'Null',                                                  
            2, 'Row Share',                                             
            3, 'Row                                                     
        Excl.',                                                         
            4, 'Share',                                                 
            5, 'S/Row Excl.',                                           
            6, 'Exclusive',                                             
            LTRIM (TO_CHAR (lmode, '990'))                              
         ) lmode,                                                       
         DECODE (                                                       
            m.request,                                                  
            0, 'None',                                                  
            1, 'Null',                                                  
            2, 'Row Share',                                             
            3, 'Row                                                     
        Excl.',                                                         
            4, 'Share',                                                 
            5, 'S/Row Excl.',                                           
            6, 'Exclusive',                                             
            LTRIM (TO_CHAR (m.request, '990'))                          
         ) request,                                                     
         m.id1, m.id2, logon_time,program                                                   
    FROM gv$session sn, gv$lock m                                       
   WHERE (sn.inst_id = m.inst_id AND sn.sid = m.sid AND m.request ! = 0)
      OR ( sn.inst_id = m.inst_id AND  sn.sid = m.sid                                            
          AND m.request = 0                                             
          AND lmode != 4                                                
          AND (id1, id2) IN (SELECT s.id1, s.id2                        
                               FROM gv$lock s                            
                              WHERE request != 0                        
                                AND s.id1 = m.id1                       
                                AND s.id2 = m.id2)                      
         )                                                              
ORDER BY id1, id2, m.request;                                           

-----------------------------------------------------------

-- Muestra el sql que está ejecutando la sessión que está lockeada  --
select sess.sid, sess.serial#, do.owner, do.object_name, do.object_type, s.sql_text 
from v$locked_object lo, dba_objects do, v$session sess, v$sql s 
where lo.object_id=do.data_object_id 
and lo.session_id=sess.sid 
and sess.sql_hash_value=s.hash_value; 

-- QUE EJECUTA QUIEN --
select S.inst_id,S.SID,S.SERIAL#, S.username,S.module,S.program, S.status, S.lockwait, sql.* 
from gv$session s, gv$sql sql
WHERE s.sql_address = sql.address(+) 
AND s.sql_hash_value = sql.hash_value (+)
and S.OSUSER = 'SNOOP'

-- Detalle Session x Usuario ( Ambos nodos )
select inst_id,username, sid, serial#,status from gv$session where username = 'CGARRIDO'

-- Sessiones activas ( ambos nodos )
select inst_id, username, server, machine from gv$session where status = 'ACTIVE' and username is not null order by 2
    

-- no se que hace pero hay que revisarlo
select dbms_rowid.rowid_block_number(rowid),pkey from cl_inventory


-- Metadata para matar una session cuando hay bloqueos
select 'alter system kill session '||''''||sid||','||serial#||''''||';',status, username, inst_id
from gv$session 
where username = 'ASILVA'
--and inst_id = 2


-- Para saber quien está bloqueando exactamente que  --

select sid,ROW_WAIT_obj#, ROW_WAIT_FILE#,ROW_WAIT_BLOCK#,ROW_WAIT_ROW# from v$session; 

select object_type,owner,object_name from dba_objects where object_id=30855; 
select object_type,owner,object_name from dba_objects where object_id=ROW_WAIT_obj#; 

SELECT * FROM hernan.EDS_TMP_REL_CONVERSION WHERE rowid=DBMS_ROWID.ROWID_CREATE(1, 30855, 9, 262, 1); 
SELECT * FROM owner.object_name WHERE rowid=
DBMS_ROWID.ROWID_CREATE(1,ROW_WAIT_obj#, ROW_WAIT_FILE#,ROW_WAIT_BLOCK#,ROW_WAIT_ROW#)

