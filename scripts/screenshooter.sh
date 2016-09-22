#!/bin/bash
# script for making screenshots using scrot
# full - everything on screen
# focus - only focused window
# select - select a space via mouse
if [ ! -d ~/screenshots ]; then
  mkdir ~/screenshots
fi
 
date=`date "+%m-%d_%H:%M:%S"`
case $1 in
  "full") scrot ~/screenshots/${date}.png;;
  "focus") scrot -u ~/screenshots/${date}.png;;
  "select") scrot -s ~/screenshots/${date}.png;;
esac

