#!/usr/bin/env bash

set -e -o pipefail

if [ -z "$1" ]; then
  if [ "$(amixer get Master toggle | xargs | awk '{print $NF}')" = "[off]" ]; then
    printf "婢 %s" "$(amixer sget Master | awk -F"[][]" '/Left/ { print $2 }'|cut -d'%' -f1 | xargs)"
  else
    printf " %s" "$(amixer sget Master | awk -F"[][]" '/Left/ { print $2 }'|cut -d'%' -f1 | xargs)"
  fi

  #if bluetoothctl info "$1" | grep -q "Connected: yes"; then
  #  printf ":%s\n" "$(bluetooth_battery "$1" | cut -d' ' -f6)"
  #fi
else
  echo "Help : "
  echo "audio     : shows volume % + battery info if BT device connected"
fi

