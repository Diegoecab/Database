echo @off
set connstring=%1
set script=%3
set user=%2
sqlcmd -U %user% -S %connstring% -i %script%