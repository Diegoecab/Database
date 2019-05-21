 select * from xmltable('VaPolicies/VaPolicy' passing xmltype(bfilename('EXP_MQ38255','citi-ora-udr-dsm6-v32037.xml'), nls_charset_id('AL32UTF8'))
	columns
policy_name varchar(2000) path 'name',
keywords varchar(2000) path 'keywords',
state varchar(2000) path 'state',
obsolete varchar(2000) path 'obsolete',
classification varchar(2000) path 'classification',
severity varchar(2000) path 'severity',
category varchar(2000) path 'category',
db_type varchar(2000) path 'db_type',
exec_type varchar(2000) path 'exec_type',
serverLevel varchar(2000) path 'serverlevel',
maxcollectedresults varchar(2000) path 'maxCollectedResults',
description varchar(2000) path 'description',
impactedVersions varchar(2000) path 'impactedVersions',
otherReferences varchar(2000) path 'otherReferences',
overview varchar(2000) path 'overview',
policyReference varchar(2000) path 'policyReference',
remediationAdvice varchar(2000) path 'remediationAdvice',
resultColumnLabels varchar(2000) path 'resultColumnLabels',
resultColumnNames varchar(2000) path 'resultColumnNames',
osType varchar(2000) path 'cmd/osType',
source varchar(2000) path 'cmd/source'
)
/

Los ‘path’ son los tag xml
El bfilename es el directorio y el file,
Y el primer argumento serian los tag de raíz del xml.
