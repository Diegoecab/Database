# Oracle Database specific environment
export PS1="11g-\$ORACLE_SID [\u@\h \W]\$"
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export PATH=$ORACLE_HOME/bin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/bin:/home/oracle/scripts

#export ORACLE_SID=prod
