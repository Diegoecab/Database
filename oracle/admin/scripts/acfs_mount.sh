Mounting ACFS File Systems
If the ACFS file system is used by Oracle database software, then perform Steps 1 and 2.

Execute the following command to find the names of the CRS managed ACFS file system resource.

As root user execute:

# crsctl stat res -w "TYPE = ora.acfs.type" -p | grep VOLUME
Execute the following command to start and mount the CRS managed ACFS file system resource with the resource name found from Step 1.

As root user execute:

# srvctl start filesystem -d <volume device path> -n <node to start file system on>
If the ACFS file system is not used for Oracle Database software and is registered in the ACFS registry, these file systems should get automatically mounted when the CRS stack comes up. Perform Steps 1 and 2 if it is not already mounted.

Execute the following command to find all ACFS file system mount points.

As the root user execute:

# /sbin/acfsutil registry
Mount ACFS file systems found in Step 1.

As the root user execute:

# /bin/mount <mount-point>

Note:

On Solaris operating system use: /sbin/mount.

On AIX operating system, use: /etc/mount.