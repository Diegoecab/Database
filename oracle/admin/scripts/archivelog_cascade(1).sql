En ibsve:
alter system set fal_server=ibsdrvz,DTVPRDCS sid='*' scope=both;
alter system set log_archive_config='DG_CONFIG=(DTVPRDCS,ibsdrvz,ibsve,D1,veoggp)' sid='*' scope=both;


En ibsdrvz (sid DTVPRDCS):
alter system set log_archive_dest_10='SERVICE=ibsve LGWR ASYNC COMPRESSION=ENABLE VALID_FOR=(STANDBY_LOGFILES,STANDBY_ROLE) DB_UNIQUE_NAME=ibsve';
alter system set log_archive_dest_state_10='ENABLE';

