#!/bin/bash

cmd="ffmpeg -r 30 -f lavfi -i testsrc -vf scale=1280:960 -vcodec libx264 -profile:v baseline -pix_fmt yuv420p -f flv rtmp://$SERVER_IP:1935/live/test" 
eval $cmd &
