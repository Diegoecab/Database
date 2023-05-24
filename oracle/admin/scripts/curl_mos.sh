
for i in `ls`; do echo "uploading file $i"; curl -T $i -u user@oracle.com:testssPassw# https://transport.oracle.com/upload/issue/3-23925640933/ ; done;

for i in `ls dblxoperdesa07*.zip`; do echo "uploading file $i"; curl -T $i -u usuario:password# https://transport.oracle.com/upload/issue/3-25852358301/ ; done;
