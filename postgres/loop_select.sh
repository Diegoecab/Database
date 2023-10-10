while true;
do
psql  postgres -c 'select now() ,inet_server_addr(), pg_postmaster_start_time() '; 
echo -e "\n\n"
sleep 10
done

