srvctl config service -db rgibsp1


srvctl config service -db rgibsp1


-service rgbirp.dtvpan.com



srvctl config service -db rgibsp1 -service aribsasms					 is running on instance(s) rgibsp11,rgibsp12 
srvctl config service -db rgibsp1 -service aribsbgs								 is running on instance(s) rgibsp11
srvctl config service -db rgibsp1 -service aribsins 						is running on instance(s) rgibsp11
srvctl config service -db rgibsp1 -service aribsques 					is running on instance(s) rgibsp12
srvctl config service -db rgibsp1 -service aribsreps 				is running on instance(s) rgibsp12
srvctl config service -db rgibsp1 -service rgibsp1_bkup1 				is running on instance(s) rgibsp11
srvctl config service -db rgibsp1 -service rgibsp1_bkup2					 is running on instance(s) rgibsp12
srvctl config service -db rgibsp1 -service aribsesbs				 is running on instance(s) rgibsp12





srvctl status service -db rgibsp1 -service aribsasms		
srvctl status service -db rgibsp1 -service aribsbgs			
srvctl status service -db rgibsp1 -service aribsins 		
srvctl status service -db rgibsp1 -service aribsques 		
srvctl status service -db rgibsp1 -service aribsreps 		
srvctl status service -db rgibsp1 -service rgibsp1_bkup1 	
srvctl status service -db rgibsp1 -service rgibsp1_bkup2	
srvctl status service -db rgibsp1 -service aribsesbs		





srvctl modify service -db rgibsp1 -service aribsques -modifyconfig -available rgibsp12



srvctl modify service -db rgibsp1 -service aribsesbs -modifyconfig -preferred rgibsp12 -available rgibsp11,rgibsp12



srvctl modify service -db rgibsp1 -service aribsreps -modifyconfig -i rgibsp11,rgibsp12


srvctl modify service -db rgibsp1 -service rgibsp1_bkup2 -modifyconfig -i rgibsp11,rgibsp12




srvctl start service -db rgibsp1 -service rgibsp1_bkup2 -i rgibsp12
srvctl stop service -db rgibsp1 -service rgibsp1_bkup2 -i rgibsp12

srvctl status service -db pribsp1 -service rgibsp1_bkup2 -i rgibsp12




srvctl relocate service -db db_unique_name -service service_name -oldinst     pribsp11 -newinst pribsp12 



srvctl modify service -db pribsp1 -service ASM_SRVPR -modifyconfig -i pribsp11,pribsp12

srvctl modify service -db pribsp1 -service pribsp1_bkup1 -modifyconfig -i pribsp11,pribsp12

srvctl relocate service -db pribsp1 -service pribsp1_bkup1 -oldinst     pribsp12 -newinst pribsp11 


srvctl relocate service -db pribsp1 -service BG_SRVPR -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service pribsp1_bkup1 -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service INTEGRATION_SRVPR -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service pribsasms -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service pribsnag -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service pribsp1_bkup1 -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service pribsp1_bkup2 -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service pribsreps -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service pribssats -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service pribsstats -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service QUEUE_SRVPR -oldinst     pribsp12 -newinst pribsp11 
srvctl relocate service -db pribsp1 -service REPORTING_SRVPR -oldinst     pribsp12 -newinst pribsp11 

srvctl stop service -db pribsp1 -s ASM_SRVPR -i pribsp12
srvctl stop service -db pribsp1 -s pribsp1_bkup1 -i pribsp12
srvctl stop service -db pribsp1 -s INTEGRATION_SRVPR -i pribsp12
srvctl stop service -db pribsp1 -s pribsasms -i pribsp12
srvctl stop service -db pribsp1 -s pribsnag -i pribsp12
srvctl stop service -db pribsp1 -s pribsp1_bkup1 -i pribsp12
srvctl stop service -db pribsp1 -s pribsp1_bkup2 -i pribsp12
srvctl stop service -db pribsp1 -s pribsreps -i pribsp12
srvctl stop service -db pribsp1 -s pribssats -i pribsp12
srvctl stop service -db pribsp1 -s pribsstats -i pribsp12
srvctl stop service -db pribsp1 -s QUEUE_SRVPR -i pribsp12
srvctl stop service -db pribsp1 -s REPORTING_SRVPR -i pribsp12





srvctl start service -db pribsp1 -s ASM_SRVPR -i pribsp11
srvctl start service -db pribsp1 -s pribsp1_bkup1 -i pribsp11
srvctl start service -db pribsp1 -s INTEGRATION_SRVPR 
srvctl start service -db pribsp1 -s pribsasms -i pribsp11
srvctl start service -db pribsp1 -s pribsnag -i pribsp11
srvctl start service -db pribsp1 -s pribsp1_bkup1 -i pribsp11
srvctl start service -db pribsp1 -s pribsp1_bkup2 -i pribsp11
srvctl start service -db pribsp1 -s pribsreps -i pribsp11
srvctl start service -db pribsp1 -s pribssats -i pribsp11
srvctl start service -db pribsp1 -s pribsstats -i pribsp11
srvctl start service -db pribsp1 -s QUEUE_SRVPR -i pribsp11
srvctl start service -db pribsp1 -s REPORTING_SRVPR -i pribsp11


srvctl stop service -db pribsp1 -service ASM_SRVPR -i pribsp11




srvctl relocate service ASM_SRVPR -db pribsp1 -service ASM_SRVPR -i pribsp12
srvctl relocate service ASM_SRVPR -db pribsp1 -service ASM_SRVPR -i pribsp11


srvctl modify service -db pribsp1 -service ASM_SRVPR -modifyconfig -i pribsp12

srvctl modify service -db rgibsp1 -service aribsreps -modifyconfig -i rgibsp11,rgibsp12