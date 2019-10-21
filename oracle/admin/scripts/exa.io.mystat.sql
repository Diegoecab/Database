select s.name, m.value/1024/1024 MB from v$sysstat s, v$mystat m
where s.statistic# = m.statistic# and
(s.name like 'physical%total bytes' or s.name like 'cell phy%'
or s.name like 'cell IO%');