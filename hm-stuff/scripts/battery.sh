#!/usr/bin/env bash

set -e -o pipefail

case "$1" in
  "state")
    acpi -i | head -n 1 | cut -d' ' -f3 | cut -d',' -f1
    ;;
  "%")
    battery_percent=$(acpi -i | head -n 1 | cut -d' ' -f4 | cut -d',' -f1 | cut -d'%' -f1)
    echo "$battery_percent%"
    if [ "$battery_percent" -le 50 ] && [ "$battery_percent" -gt 30 ]; then
      notify-send -u normal "Battery at $battery_percent%" "Battery level is getting low."
    elif [ "$battery_percent" -le 30 ] && [ "$battery_percent" -gt 10 ]; then
      notify-send -u critical "Battery at $battery_percent%" "Battery level is critically low. Please save your work and connect to a power source."
    elif [ "$battery_percent" -le 10 ]; then
      notify-send -u critical "Battery at $battery_percent%" "Battery level is critically low. Please connect to a power source immediately."
    fi
    ;;
  "rem")
    rem=$(acpi -i | head -n 1 | cut -d' ' -f5)
    rem_check=$(acpi -i | head -n 1 | cut -d' ' -f5 | cut -d':' -f1)
    if [ ! -z "$rem" ]; then
      if [ "$rem_check" -eq 0 ]; then
        rem=$(echo "$rem" | cut -d':' -f2,3 | sed 's/:/m:/;s/$/s/')
      elif [[ "$rem_check" =~ ^[0-9]+$ ]]; then
        rem=$(echo "$rem" | sed 's/:/h:/;s/:/m:/2;s/$/s/')
      fi

      if ! [[ "$rem" =~ discharging|unknown ]]; then
        printf "[%s]" "$(echo "$rem" | cut -d':' -f1,2)"
      fi
    fi
    ;;
  "fancy")
    state=$($0 state)
    if [ "$state" = "Discharging" ]; then
      icon=""
    elif [ "$state" = "Full" ]; then
      icon=""
      rem="full"
    else
      icon="ﮣ"
    fi
    printf "%s %s %s\n" "$icon" "$($0 %)" "$($0 rem)"
    ;;
  "info")
    acpi -i
    ;;
  *)
    echo "usage: $0 {state|%|rem|fancy|info}"
    echo
    echo "state   :  charging/discharging"
    echo "%       :  battery left"
    echo "rem     :  time left to charge/discharge"
    echo "fancy   :  fancy battery info"
    echo "info    :  battery info verbose"
    ;;
esac

