#!/usr/bin/env bash

used=$(free -h|awk '/^Mem/{print $3}'| grep -Eo '[0-9].[0-9]')
if echo $used | grep "\." &> /dev/null
then
  echo $(echo "$used*1.07" | bc )GB
else
  echo $(echo "$used*1.048576" | bc | cut -d'.' -f1)MB
fi
