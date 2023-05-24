#If you have successful connection then end of the line it will show “0” which means successful completion. 
#If you see any other number (Oracle error number from the TNS range >12000) that means the connection was not successful and you have to investigate then.
#Using the following command you can see those line that does not end with “0”
grep AUG listener.log| awk  '{ if ( $NF != 0 ) print $0 }'