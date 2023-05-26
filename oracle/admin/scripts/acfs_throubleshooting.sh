[root@rgbipdbpr2309 ~]# acfsroot enable                                                                                                                     
ACFS-9459: ADVM/ACFS is not supported on this OS version: '2.6.32-696.20.1.el6.x86_64'                                                                      
[root@rgbipdbpr2309 ~]#                                 

acfsdriverstate installed

acfsdriverstate supported


crsctl query crs activeversion


acfsload start

[root@rgbipdbpr2309 usm]# lsmod | grep oracle                                                                                                               
oracleasm              54233  1                                                                                                                             
[root@rgbipdbpr2309 usm]#     


[root@rgbipdbpr2309 2.6.32-696]# acfsload start                                                                                                             
ACFS-9391: Checking for existing ADVM/ACFS installation.                                                                                                    
ACFS-9392: Validating ADVM/ACFS installation files for operating system.                                                                                    
ACFS-9393: Verifying ASM Administrator setup.                                                                                                               
ACFS-9308: Loading installed ADVM/ACFS drivers.                                                                                                             
ACFS-9154: Loading 'oracleoks.ko' driver.                                                                                                                   
ACFS-9226: ADVM/ACFS drivers not correct for this OS - cannot load.                                                                                         
ACFS-9399: Calling 'acfsroot install' to install compatible ADVM/ACFS drivers.                                                                              
ACFS-9459: ADVM/ACFS is not supported on this OS version: '2.6.32-696.20.1.el6.x86_64'  



[root@rgbipdbpr2309 2.6.32-696]# acfsdriverstate version                                                                                                    
ACFS-9325:     Driver OS kernel version = 2.6.32-279.el6.x86_64(x86_64).                                                                                    
ACFS-9326:     Driver Oracle version = 170822.                                                                                                              
[root@rgbipdbpr2309 2.6.32-696]#                                         


[root@rgbipdbpr2309 x86_64]# uptime                                                                                                                         
 16:04:10 up 4 days, 12:40,  4 users,  load average: 0.51, 0.52, 0.47                                                                                       
[root@rgbipdbpr2309 x86_64]#                         



[root@rgbipdbpr2309 x86_64]# find /lib/modules | grep oracle                                                                                                
/lib/modules/2.6.32-696.el6.x86_64/extra/oracleasm                                                                                                          
/lib/modules/2.6.32-696.el6.x86_64/extra/oracleasm/oracleasm.ko                                                                                             
/lib/modules/2.6.32-696.20.1.el6.x86_64/weak-updates/usm/oracleacfs.ko                                                                                      
/lib/modules/2.6.32-696.20.1.el6.x86_64/weak-updates/usm/oracleadvm.ko                                                                                      
/lib/modules/2.6.32-696.20.1.el6.x86_64/weak-updates/usm/oracleoks.ko                                                                                       
/lib/modules/2.6.32-696.20.1.el6.x86_64/weak-updates/oracleasm                                                                                              
/lib/modules/2.6.32-696.20.1.el6.x86_64/weak-updates/oracleasm/oracleasm.ko                                                                                 
/lib/modules/4.1.12-37.4.1.el6uek.x86_64/kernel/drivers/block/oracleasm                                                                                     
/lib/modules/4.1.12-37.4.1.el6uek.x86_64/kernel/drivers/block/oracleasm/oracleasm.ko                                                                        
/lib/modules/4.1.12-37.4.1.el6uek.x86_64/kernel/drivers/net/ethernet/oracle                                                                                 
/lib/modules/4.1.12-37.4.1.el6uek.x86_64/kernel/drivers/net/ethernet/oracle/hxge                                                                            
/lib/modules/4.1.12-37.4.1.el6uek.x86_64/kernel/drivers/net/ethernet/oracle/hxge/hxge.ko                                                                    
/lib/modules/4.1.12-37.4.1.el6uek.x86_64/kernel/drivers/net/ethernet/oracle/sxgevf                                                                          
/lib/modules/4.1.12-37.4.1.el6uek.x86_64/kernel/drivers/net/ethernet/oracle/sxgevf/sxgevf.ko                                                                
/lib/modules/4.1.12-37.4.1.el6uek.x86_64/kernel/drivers/net/ethernet/oracle/sxge                                                                            
/lib/modules/4.1.12-37.4.1.el6uek.x86_64/kernel/drivers/net/ethernet/oracle/sxge/sxge.ko                                                                    
/lib/modules/2.6.32-279.el6.x86_64/extra/usm/oracleacfs.ko                                                                                                  
/lib/modules/2.6.32-279.el6.x86_64/extra/usm/oracleadvm.ko                                                                                                  
/lib/modules/2.6.32-279.el6.x86_64/extra/usm/oracleoks.ko   
                                                             
[root@rgbipdbpr2309 usm]# ls -l /lib/modules/2.6.32-696.20.1.el6.x86_64/weak-updates/usm/oracleacfs.ko                                                      
lrwxrwxrwx 1 root root 58 Feb 20  2018 /lib/modules/2.6.32-696.20.1.el6.x86_64/weak-updates/usm/oracleacfs.ko -> /lib/modules/2.6.32-279.el6.x86_64/extra/usm/oracleacfs.ko                                                                                                                                             
[root@rgbipdbpr2309 usm]#          
															 
[root@rgbipdbpr2309 x86_64]# uname -a                                                                                                                       
Linux rgbipdbpr2309 2.6.32-696.20.1.el6.x86_64 #1 SMP Thu Jan 25 15:32:38 PST 2018 x86_64 x86_64 x86_64 GNU/Linux                                           
[root@rgbipdbpr2309 x86_64]#                                                     










ACA YA NO FUNCIONABA


[root@rgbipdbpr2310 ~]# acfsroot enable                                                                                                                     
ACFS-9459: ADVM/ACFS is not supported on this OS version: '2.6.32-696.18.7.el6.x86_64'  





ls -ltr $ORACLE_HOME/install/usm/Oracle/EL6/x86_64/



[root@rgbipdbpr2309 ~]# ls -ltr $ORACLE_HOME/usm/install/Oracle/EL6/x86_64/                                                                                 
total 16                                                                                                                                                    
drwxr-xr-x 3 grid oinstall 4096 Feb  2  2018 2.6.32-71                                                                                                      
drwxr-xr-x 3 grid oinstall 4096 Feb  2  2018 2.6.32-279                                                                                                     
drwxr-xr-x 3 grid oinstall 4096 Feb  2  2018 2.6.32-220                                                                                                     
drwxr-xr-x 3 grid oinstall 4096 Aug  3  2019 2.6.32-696                                                                                                     
[root@rgbipdbpr2309 ~]# uname -a                                                                                                                            
Linux rgbipdbpr2309 2.6.32-696.20.1.el6.x86_64 #1 SMP Thu Jan 25 15:32:38 PST 2018 x86_64 x86_64 x86_64 GNU/Linux                                           
[root@rgbipdbpr2309 ~]#                            


[root@rgbipdbpr2310 ~]# ls -ltr $ORACLE_HOME/usm/install/Oracle/EL6/x86_64/                                                                                 
total 16                                                                                                                                                    
drwxrwxr-- 3 grid oinstall 4096 Feb  2  2018 2.6.32-71                                                                                                      
drwxrwxr-- 3 grid oinstall 4096 Feb  2  2018 2.6.32-279                                                                                                     
drwxrwxr-- 3 grid oinstall 4096 Feb  2  2018 2.6.32-220                                                                                                     
drwxr-xr-x 3 grid oinstall 4096 Aug  3  2019 2.6.32-696                                                                                                     
[root@rgbipdbpr2310 ~]#                            
[root@rgbipdbpr2310 ~]# uname -a                                                                                                                            
Linux rgbipdbpr2310 2.6.32-696.18.7.el6.x86_64 #1 SMP Wed Jan 3 16:42:16 PST 2018 x86_64 x86_64 x86_64 GNU/Linux                                            
[root@rgbipdbpr2310 ~]#         


ls -laRt $ORACLE_HOME/usm/install






/u01/app/12.1.0/grid/usm/install/Oracle/EL6/x86_64/


mv /u01/app/12.1.0/grid/usm/install/Oracle/EL6/x86_64/2.6.32-696 /u01/app/12.1.0/grid/usm/install/Oracle/EL6/x86_64/2.6.32-696.20200520




[grid@rgbipdbpr2310 ~]$ mv /u01/app/12.1.0/grid/usm/install/Oracle/EL6/x86_64/2.6.32-696 /u01/app/12.1.0/grid/usm/install/Oracle/EL6/x86_64/2.6.32-696.20200520                                                                                                                                                         
[root@rgbipdbpr2310 ~]# acfsroot install                                                                                                                    
ACFS-9300: ADVM/ACFS distribution files found.                                                                                                              
ACFS-9312: Existing ADVM/ACFS installation detected.                                                                                                        
ACFS-9314: Removing previous ADVM/ACFS installation.                                                                                                                               
ACFS-9315: Previous ADVM/ACFS components successfully removed.                                                                                              
ACFS-9307: Installing requested ADVM/ACFS software.                                                                                                         
ACFS-9308: Loading installed ADVM/ACFS drivers.                                                                                                             
ACFS-9321: Creating udev for ADVM/ACFS.                                                                                                                     
ACFS-9323: Creating module dependencies - this may take some time.                                                                                          
ACFS-9154: Loading 'oracleoks.ko' driver.                                                                                                                   
ACFS-9154: Loading 'oracleadvm.ko' driver.                                                                                                                  
ACFS-9154: Loading 'oracleacfs.ko' driver.                                                                                                                  
ACFS-9327: Verifying ADVM/ACFS devices.                                                                                                                     
ACFS-9156: Detecting control device '/dev/asm/.asm_ctl_spec'.                                                                                               
ACFS-9156: Detecting control device '/dev/ofsctl'.                                                                                                          
ACFS-9309: ADVM/ACFS installation correctness verified.                                                                                                     
[root@rgbipdbpr2310 ~]# lsmod | grep oracle                                                                                                                 
oracleacfs           3708626  0                                                                                                                             
oracleadvm            625457  0                                                                                                                             
oracleoks             522006  2 oracleacfs,oracleadvm                                                                                                       
oracleasm              54233  1                                                                                                                             
[root@rgbipdbpr2310 ~]#                                                                                                                                     
[root@rgbipdbpr2310 ~]# acfsdriverstate version                                                                                                             
ACFS-9325:     Driver OS kernel version = 2.6.32-279.el6.x86_64(x86_64).                                                                                    
ACFS-9326:     Driver Oracle version = 190321.1.                                                                                                            
[root@rgbipdbpr2310 ~]#                                                                                                                                     
[root@rgbipdbpr2310 ~]# nuame -a                                                                                                                            
-bash: nuame: command not found                                                                                                                             
[root@rgbipdbpr2310 ~]# uname -a                                                                                                                            
Linux rgbipdbpr2310 2.6.32-696.18.7.el6.x86_64 #1 SMP Wed Jan 3 16:42:16 PST 2018 x86_64 x86_64 x86_64 GNU/Linux                                            
[root@rgbipdbpr2310 ~]# acfsdriverstate supported                                                                                                           
ACFS-9200: Supported        
[root@rgbipdbpr2310 ~]# acfsroot enable                                                                                                                     
ACFS-9382: Modification of ADVM/ACFS drivers resource succeeded.                                                                                            
[root@rgbipdbpr2310 ~]#   




[root@rgbipdbpr2310 ~]# /bin/mount /export /dev/asm/export_vol-215                                                                                          
mount: you must specify the filesystem type                                                                                                                 
[root@rgbipdbpr2310 ~]# mount -t acfs /dev/asm/export_vol-215 /export                                                                                       
mount.acfs: CLSU-00100: operating system function: open64 failed with error data: 2                                                                         
mount.acfs: CLSU-00101: operating system error message: No such file or directory                                                                           
mount.acfs: CLSU-00103: error location: OOF_1                                                                                                               
mount.acfs: CLSU-00104: additional error information: open64 (/dev/asm/export_vol-215)                                                                      
mount.acfs: ACFS-02017: Failed to open volume /dev/asm/export_vol-215. Verify the volume exists.                                                            
[root@rgbipdbpr2310 ~]# su - grid                                                                                                                           
[grid@rgbipdbpr2310 ~]$ asmcmd                                                                                                                              
-bash: asmcmd: command not found                                                                                                                            
[grid@rgbipdbpr2310 ~]$ . oraenv                                                                                                                            
ORACLE_SID = [grid] ? +ASM2                                                                                                                                 
The Oracle base has been set to /u01/app/grid                                                                                                               
[grid@rgbipdbpr2310 ~]$ asmcmd                                                                                                                              
ASMCMD> volinfo --all                                                                                                                                       
ASMCMD-9470: ASM proxy instance unavailable                                                                                                                 
ASMCMD-9473: volume STATE will show as REMOTE                                                                                                               
Diskgroup Name: FRA                                                                                                                                         
                                                                                                                                                            
         Volume Name: EXPORT_VOL                                                                                                                            
         Volume Device: /dev/asm/export_vol-215                                                                                                             
         State: REMOTE                                                                                                                                      
         Size (MB): 1669120                                                                                                                                 
         Resize Unit (MB): 512                                                                                                                              
         Redundancy: UNPROT                                                                                                                                 
         Stripe Columns: 8                                                                                                                                  
         Stripe Width (K): 1024                                                                                                                             
         Usage: ACFS                                                                                                                                        
         Mountpath: /export                                                                                                                                 
                                                                                                                                                            
ASMCMD> volenable -G FRA -a                                                                                                                                 
ASMCMD-9470: ASM proxy instance unavailable                                                                                                                 
ASMCMD-9471: cannot enable or disable volumes               


[root@rgbipdbpr2309 export]# crsctl stat res ora.proxy_advm -t                                                                                              
--------------------------------------------------------------------------------                                                                            
Name           Target  State        Server                   State details                                                                                  
--------------------------------------------------------------------------------                                                                            
Local Resources                                                                                                                                             
--------------------------------------------------------------------------------                                                                            
ora.proxy_advm                                                                                                                                              
               ONLINE  ONLINE       rgbipdbpr2309            STABLE                                                                                         
               ONLINE  ONLINE       rgbipdbpr2310            STABLE                                                                                         
--------------------------------------------------------------------------------                                                                            
[root@rgbipdbpr2309 export]#                  
