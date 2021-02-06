#!/bin/bash

arrivaleRate="$1"
timeOut="$2"
time_start=$SECONDS

if [ $# -ne 2 ]; then
  echo "Usage: user_request.sh <arraivalRate> <timeOut>"
  exit 
fi

# echo $arrivaleRate
# echo $timeOut

rd=0

function genRandom {
    rd=$(echo "$[(1 + $RANDOM % 1000)]/1000" | bc -l)
}

k=0
function Poisson_dist {
    p=1
    l=$(echo "e(-$arrivaleRate)" |bc -l)
    echo $l
    while [ $(bc <<< "$p > $l") -eq 1 ]; do
        genRandom
        echo "random = $rd" 
        p=$(echo "$p * $rd" |bc -l)
        echo "p = $p"
        echo "l = $l"
        k=$(echo "$k + 1" |bc -l)
    done
}

while [ $time_start -lt $timeOut ]; do
    Poisson_dist
    echo $k
    for i in `seq 1 $k`;
        do
            #TODO: write the request here!
            
        done 
    sleep 1s
done
