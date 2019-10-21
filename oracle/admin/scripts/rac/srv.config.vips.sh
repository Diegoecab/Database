echo "To determine the VIP hostname, VIP address"
srvctl config nodeapps -a
echo "To determine the current IP Address for the VIP Address"
srvctl config vip -n $HOSTNAME
