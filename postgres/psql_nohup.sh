export PGPASSWORD=passwd
nohup psql -h myhost -U postgres -d trnpds -p 15050 -f pk_create.sql &

