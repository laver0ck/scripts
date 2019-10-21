#!/bin/bash

SECS=3600 # total seconds for which monitoring is to be performed
UNIT_TIME=60 # interval in seconds between each samling

STEPS=$(( $SECS / $UNIT_TIME ))

echo Watching CPU usage... ;

for ((i=0;i<STEPS;i++))
do
    ps -eocomm,pcpu | tail -n +2 >> /tmp/cpu_usage.$$
    sleep $UNIT_TIME
done

echo
echo CPU eaters :

cat /tmp/cpu_usage.$$ |  \
awk '
{ process[$1]+=$2; }
END{
    for(i in process)
    {
        printf("%-20s %s\n",i, process[i]) ;
    }
   }' | sort -nrk 2 | head

rm /tmp/cpu_usage.$$
