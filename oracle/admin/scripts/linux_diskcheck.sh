#!/bin/bash



#This script is to evaluate iostate data for couple of minutes to check
#if particular disk r/s and w/s is less then 50 and disk utilization is greater then 98%
#then raise alert for that disk as it is candidate for replacement

# check if tmp.txt file exit if exits delete it

if [ -f tmp.txt ]
then
rm -f tmp.txt
fi

#create new tmp.txt file to store disk device name and number of
#time it met the condition
touch tmp.txt

#populate the tmp.txt file with device name and count value to 0 for
#each of the disk device
#iostat -x -k |grep dm- | while read LINE
iostat -x -k   in `multipath -l |grep HDD  | awk '{print  $3}'` 1 3  | tac | sed '/Device/q' |tac |grep dm- | while read LINE
do
device=`echo $LINE | awk -F ' ' '{print $1}'`
echo "$device 0" >> tmp.txt
done

# upper for loop to run the inner loop n number of times
# as delay we are keeping for innder loop is 3 second
# with middle parameter you can control how long data you want to analyze
# for example if you keep it 60 it will analyze data for 3 minutes.

for ((i=1;i <=20; i++))
do

count=0

# inner loop to evaluate data every 3 second

#iostat -x -k |grep dm- | while read LINE
iostat -x -k   in `multipath -l |grep HDD  | awk '{print  $3}'` 1 3  | tac | sed '/Device/q' |tac |grep dm- | while read LINE

do
let count++
# folloing used for different column of iostate output
# rs -> read/sec  ws -> write/sec  and util -> utilization
# device -> disk device
device=`echo $LINE | awk -F ' ' '{print $1}'`
rs=`echo $LINE | awk -F ' ' '{print $4}'`
ws=`echo $LINE | awk -F ' ' '{print $5}'`
util=`echo $LINE | awk -F ' ' '{print $12}'`

#   if read/s and write/s is less then 50 and disk utilization is greater then 98 %
#   then for that device increment counter in tmp.txt file

if ([ $(bc <<< " $rs <= 50" ) -eq 1 ]) && ([ $(bc <<< " $ws <= 50" ) -eq 1 ]) && ([ $(bc <<< " $util >= 96" ) -eq 1 ])
then

cntr=`grep $device tmp.txt | awk -F ' ' '{print $2}'`
cntrold=$cntr
let cntr++
sed -i "s/${device} ${cntrold}/${device} ${cntr}/g" tmp.txt
#echo "sed -i "s/${device} ${cntrold}/${device} ${cntr}/g" tmp.txt"

echo " $device  $rs  $ws $util  "
fi
done
sleep 3
echo `date`
done

# date is analyzed and for each disk we have counter in tmp.txt
# now read the counter for device test if particular device met condition at least 50 times
# raise alert

cat tmp.txt |while read line
do
dev=`echo $line | awk -F ' ' '{print $1}'`
cnt=`echo $line | awk -F ' ' '{print $2}'`

if [ $(bc <<< " $cnt >= 18" ) -eq 1 ]
then
echo "count for $dev is $cnt"
echo "$dev is candidate disk for replacement"
fi
done

rm -f tmp.txt

