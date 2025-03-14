SELECT 'PROMPT SNAPSHOT '||LOG_OWNER||'.'||MASTER||'...
CREATE MATERIALIZED VIEW LOG ON '||LOG_OWNER||'.'||MASTER||'
TABLESPACE GEMLOGS
NOLOGGING
WITH ROWID, PRIMARY KEY
INCLUDING NEW VALUES;' FROM DBA_SNAPSHOT_LOGS WHERE PRIMARY_KEY='YES' AND ROWIDS='YES' AND INCLUDE_NEW_VALUES='YES'
UNION
SELECT 'PROMPT SNAPSHOT '||LOG_OWNER||'.'||MASTER||'... 
CREATE MATERIALIZED VIEW LOG ON '||LOG_OWNER||'.'||MASTER||'
TABLESPACE GEMLOGS
NOLOGGING
WITH ROWID
INCLUDING NEW VALUES;' FROM DBA_SNAPSHOT_LOGS WHERE PRIMARY_KEY='NO' AND ROWIDS='YES' AND INCLUDE_NEW_VALUES='YES'
UNION
SELECT 'PROMPT SNAPSHOT '||LOG_OWNER||'.'||MASTER||'... 
CREATE MATERIALIZED VIEW LOG ON '||LOG_OWNER||'.'||MASTER||'
TABLESPACE GEMLOGS
NOLOGGING
WITH PRIMARY KEY
INCLUDING NEW VALUES;' FROM DBA_SNAPSHOT_LOGS WHERE PRIMARY_KEY='YES' AND ROWIDS='NO' AND INCLUDE_NEW_VALUES='YES';