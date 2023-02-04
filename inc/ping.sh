#!/usr/bin/env bash
ping_status() {
ping -c1 $1 1>/dev/null 2>/dev/null
SUCCESS=$?

if [ $SUCCESS -eq 0 ]
then
  echo "$1 has replied"
  echo "Ping Was Successful" | festival --tts
else
  echo "$1 didn't reply"
  echo "Ping Was Fail" | festival --tts
fi
}
ping_status


