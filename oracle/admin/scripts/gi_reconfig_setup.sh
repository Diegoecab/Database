deconfig Oracle Home.

[grid@lxdesaora1 product]$ ./gridSetup.sh -silent INVENTORY_LOCATION=/oracle/app/oraInventory SELECTED_LANGUAGES=en ORACLE_BASE=$ORACLE_BASE ORACLE_HOME=$ORACLE_HOME oracle.install.option=HA_SWONLY oracle.install.asm.OSDBA=asmdba oracle.install.asm.OSOPER=asmoper oracle.install.asm.OSASM=asmadmin -ignorePrereqFailure


[grid@lxdesaora1 product]$ cat /oracle/app/grid/product/grid/install/root_lxdesaora1_2021-02-22_19-48-20-757972512.log                                                                                                                                                 Performing root user operation.

The following environment variables are set as:
    ORACLE_OWNER= grid
    ORACLE_HOME=  /oracle/app/grid/product/grid
   Copying dbhome to /usr/local/bin ...
   Copying oraenv to /usr/local/bin ...
   Copying coraenv to /usr/local/bin ...

Entries will be added to the /etc/oratab file as needed by
Database Configuration Assistant when a database is created
Finished running generic part of root script.
Now product-specific root actions will be performed.

To configure Grid Infrastructure for a Cluster or Grid Infrastructure for a Stand-Alone Server execute the following command as grid user:
/oracle/app/grid/product/grid/gridSetup.sh
This command launches the Grid Infrastructure Setup Wizard. The wizard also supports silent operation, and the parameters can be passed through the response file that is available in the installation media.

[grid@lxdesaora1 product]$
