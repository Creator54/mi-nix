#!/usr/bin/env bash

set -e -o pipefail

temp=0
cores=0
loadavg=$(grep -o "^[^ ]*" /proc/loadavg)
cpu_temps=$(sensors | awk '{print $3}' | head -n 15 | tail -n 4 | cut -d'+' -f2 | cut -d'.' -f1)

for x in $cpu_temps; do
	cores=$((cores + 1))
	temp=$((temp + x))
done

temp=$((temp / cores))
echo "$loadavg/$temp°C"
