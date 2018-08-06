#!/bin/bash
flag1="FLAG1"
flag2="FLAG2"
user="USER"
tmp_path="/tmp"
while :
do
  sleep 30
  directories=$(find $tmp_path -maxdepth 1 -type d -user $user)
  for d in $directories
  do
    cd $d
    if [ -f itsmine.txt ] && [ $(find itsmine.txt -perm 600) ]; then
      echo $flag2 > flag2.txt
    else
      su $user -c "echo $flag1 > flag1.txt"
    fi
  done
done
