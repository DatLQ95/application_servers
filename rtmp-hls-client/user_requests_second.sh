#!/bin/bash

arrivaleRate="$1"
timeOut="$2"
granuality="$3"
time_start=$SECONDS
echo "arrival rate $arrivaleRate"
arrival_time=$(echo "$granuality*20/$arrivaleRate" |bc -l)
echo "arrival time $arrival_time"
if [ $# -ne 3 ]; then
  echo "Usage: user_request.sh <arraivalRate> <timeOut> <granuality>"
  exit 
fi

rd=0
function genRandom {
    rd=$(echo "$[(1 + $RANDOM % 1000)]/1000" | bc -l)
}

k=0
function Poisson_dist {
    p=1
    l=$(echo "e(-$arrival_time)" |bc -l)
    while [ $(bc <<< "$p > $l") -eq 1 ]; do
        genRandom
        p=$(echo "$p * $rd" |bc -l)
        k=$(echo "$k + 1" |bc -l)
    done
    k=$(echo "$k - 1" |bc -l)
}

total=0
time_test=0
while [ $(bc <<< "$time_test <  $timeOut") -eq 1 ]; do
    Poisson_dist
    time_test=$(echo "$time_test + $k/20" |bc -l)
    total=$(echo "$total + 1" |bc -l)
    #TODO: write the request here!
    cmd="ffmpeg -i rtmp://$SERVER_IP/vod/bbb.mp4 -y -t 10 -f flv emre.flv" # > output-stdout/stdout$i"
    # echo $cmd
    eval $cmd &
    # echo $(echo "$k/20" |bc -l)
    sleep $(echo "$k/20" |bc -l)
    k=0
    # echo $total
    # echo $time_test
    # echo $timeOut
done
echo "$total ," >> data.txt
