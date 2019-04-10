#!/bin/bash

# A busy loop function in shell
function busyloop() {
  i="200"
  j=0
  while [ $i -gt 0 ]
  do
    case $j in
      0) k="|" ;;
      1) k="/" ;;
      2) k="-" ;;
      3) k="\\" ;;
    esac
    echo -en "\rwaiting...$k"
    sleep 0.5
    j=$(((j+1) % 4))
    i=$((i-10))
  done
  echo "done:hello world" > /tmp/1
}
