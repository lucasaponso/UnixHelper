#!/usr/bin/env bash

echo "The official language of $1 is "

case $1 in

  apt)
    echo "Ran package update $(date)" >> /mnt/server/apt-log.txt
    cat /mnt/server/apt-log.txt
    ;;

  git)
    echo "Git pull $(date)" >> /mnt/server/gitpull-log.txt
    cat /mnt/server/gitpull-log.txt
    ;;
  run)
    sudo echo "Ran main $(date)" >> /mnt/server/run-log.txt
    cat /mnt/server/run-log.txt
    ;;
  data)
    sudo echo "Accessed DB $(date)" >> /mnt/server/db_access_log.txt
    ;;
  *)
    echo -n "unknown"
    ;;
esac










