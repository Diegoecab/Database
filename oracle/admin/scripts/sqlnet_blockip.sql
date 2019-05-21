Block or Accept Oracle access by IP Address
You sometimes may wish to access to logon to your database filtered by IP address. Suppose you will allow to connect to database having a list of IP address. Or you like to ban a list of IP addresses in order to deny logon as a database user.

With oracle this scenario can be achieved, however this seems to me a bit of fun.

The secret lies in the SQLNET.ORA file. On UNIX system this file resides in $ORACLE_HOME/network/admin directory along with tnsnames.ora and listener.ora.

In order to put any filtering by IP address open the sqlnet.ora file with any editor and insert the following line,

tcp.validnode_checking = yes

This in fact, turns on the hostname/IP checking for your listeners. After this, with
tcp.invited_nodes /tcp.excluded_nodes you can supply lists of nodes to enable/disable, as such:


tcp.invited_nodes = (hostname1, hostname2)
tcp.excluded_nodes = (192.168.100.101,192.168.100.160)

Note that if you only specify invited nodes with tcp.invited_nodes, all other nodes will be excluded, so there is really no reason to do both. The same is true for excluded nodes. If you put tcp.excluded_nodes = (192.168.100.101,192.168.100.160) then IP containing 192.168.100.101 and 192.168.100.160 will be excluded/denied to connect to database as a database user while allowing others to connect.

Some rules for entering invited/excluded nodes:

1. You cannot use wild cards in your specifications.
2. You must put all invited nodes in one line; likewise for excluded nodes.
3. You should always enter localhost as an invited node.

Once you have set up your rules and enabled valid node checking, you must restart your listeners to reap the benefits.

To do so,
$lsnrctl stop
$lsnrctl start

A simple example: Suppose in your database server you simply allow the host containing IP Address 192.168.100.2 and 192.168.100.3. Then your sqlnet.ora file look like,

tcp.validnode_checking = yes
tcp.invited_nodes = (localhost,192.168.100.2,192.168.100.3)