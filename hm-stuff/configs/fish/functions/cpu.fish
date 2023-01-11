function cpu
  set cpu_val (grep -o "^[^ ]*" /proc/loadavg)
  sensors > /tmp/cpu_data
  set core_0 (printf "%d" (cat /tmp/cpu_data|grep 'Core 0:' | awk '{ print $3}') 2>/dev/null)
  set core_1 (printf "%d" (cat /tmp/cpu_data|grep 'Core 1:' | awk '{ print $3}') 2>/dev/null)
  set core_2 (printf "%d" (cat /tmp/cpu_data|grep 'Core 2:' | awk '{ print $3}') 2>/dev/null)
  set core_3 (printf "%d" (cat /tmp/cpu_data|grep 'Core 3:' | awk '{ print $3}') 2>/dev/null)
  set temp (math -s0 "($core_0+$core_1+$core_2+$core_3)"/4)
  echo "$cpu_val/$temp°C"
end
