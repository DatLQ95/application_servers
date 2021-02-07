#!/bin/bash

arrivalRate=(100 80 60 46 42 40 38 50 66 80 96 108 116 120 124 128 124 122 120 144 174 180 166 156 ) # numner requests/granuality
timeOut=60 #seconds
granuality=60 #seconds
START_TIME=$SECONDS
ELAPSED_TIME=$(($SECONDS - $START_TIME))

for i in `seq 0 6`; 
do
    scale=$(echo "0.75 + $[($RANDOM % 100)]/200" | bc -l)
    echo $scale
    for rate in ${arrivalRate[@]}; 
    do
        /root/user_requests_second.sh $(echo "$rate * $scale" |bc -l) $timeOut $granuality
    done
done
