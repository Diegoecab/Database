set echo off veri off
accept 1 prompt 'Enter BUG number: '

prompt AD_BUGS
prompt =======
select * from apps.ad_bugs where bug_number = '&&1';

prompt AD_APPLIED_PATCHES
prompt =======
select * from apps.AD_APPLIED_PATCHES  where patch_name = '&&1';