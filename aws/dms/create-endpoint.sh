for r in {11..100}
do
	aws dms create-endpoint \
    --endpoint-type source \
	--engine-name oracle \
	--endpoint-identifier src-endpoint-$r-orcl \
    --oracle-settings file://orcl-endpoint-settings.json
done
	

{
  "DatabaseName": "ORCL",
  "Password": "oraadmin1",
  "Port": 1521,
  "ServerName": "testing",
  "Username": "string"
}

