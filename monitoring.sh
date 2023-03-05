#!/bin/bash

while true
do
  # Get system information
  architecture=$(uname -m)
  kernel_version=$(uname -r)
  num_physical_cpus=$(grep -c "^processor" /proc/cpuinfo)
  num_virtual_cpus=$(grep -c "^processor" /proc/cpuinfo)
  mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  mem_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
  mem_utilization=$(echo "scale=2;100-($mem_free/$mem_total*100)" | bc)
  cpu_utilization=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
  last_reboot=$(who -b | awk '{print $3,$4}')
  lvm_status=$(systemctl status lvm2-lvmetad.service | grep "Active:" | awk '{print $2}')
  num_connections=$(netstat -an | grep -c | wc -l)
  num_users=$(who | wc -l)
  ipv4_address=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}')
  mac_address=$(ip addr show | grep 'link/ether' | awk '{print $2}')
  num_sudo_cmds=$(grep -c "sudo:" /var/log/auth.log)

  # Display information to all terminals
  ```
  echo "=================================================" | wall
  ```
  echo "System Information:" | wall
  echo "Architecture: $architecture" | wall
  echo "Kernel Version: $kernel_version" | wall
  echo "Number of Physical CPUs: $num_physical_cpus" | wall
  echo "Number of Virtual CPUs: $num_virtual_cpus" | wall
  echo "RAM Total: $mem_total kB" | wall
  echo "RAM Free: $mem_free kB" | wall
  echo "RAM Utilization Rate: $mem_utilization %" | wall
  echo "CPU Utilization Rate: $cpu_utilization" | wall
  echo "Last Reboot: $last_reboot" | wall
  echo "LVM Status: $lvm_status" | wall
  echo "Numberof Active Connections: $num_connections" | wall
  echo "Number of Users: $num_users" | wall
  echo "IPv4 Address: $ipv4_address" | wall
  echo "MAC Address: $mac_address" | wall
  echo "Number of sudo Commands: $num_sudo_cmds" | wall

  # Wait for 10 minutes before displaying information again
  sleep 600
done
```

# This script uses various commands to gather system information and then displays it using the "wall" command which sends a message to all logged-in users. The script runs in an infinite loop, waiting for 10 minutes between each display of information.

You can modify the script to add a banner by adding an extra `echo` statement before the information is displayed. For example, you could add the following line before the first `echo` statement to display a banner:

```
echo "===================================" | wall
```
