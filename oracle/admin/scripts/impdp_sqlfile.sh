$ORACLE_HOME/bin/impdp \'/ as sysdba\' \
DIRECTORY=ibsclr \
dumpfile=EXPREC_BD_CHILE_210120_%U.dmp \
CONTENT=METADATA_ONLY \
INCLUDE="INDEX" \
sqlfile=create_indexes.sql
