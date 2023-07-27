#!/bin/bash

echo -ne "#Architecture: "; uname -a # Print system architecture
echo -ne "#CPU physical : "; grep -c ^processor /proc/cpuinfo # Print the number of physical CPU cores
echo -ne "#vCPU : "; cat /proc/cpuinfo | grep processor | wc -l # Print the number of virtual CPU cores (vCPU)
echo -ne "#Memory Usage: "; free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }' # Print memory usage
echo -ne "#Disk Usage: "; df -h | awk '$NF=="/"{printf "%d/%dGB (%s)\n", $3,$2,$5}' # Print disk usage
echo -ne "#CPU load: "; top -bn1 | grep load | awk '{printf "%.2f%%\n", $(NF-2)}' # Print CPU load
echo -ne "#Last boot: "; who | awk '{print $3}' | tr '\n' ' ' && who | awk '{print $4}' # Print last boot time
echo -ne "#LVM use: "; if cat /etc/fstab | grep -q "/dev/mapper/"; then echo "yes"; else echo "no"; fi # Check if LVM is in use and print the result
echo -ne "#Connexions TCP : "; cat /proc/net/tcp | wc -l | awk '{print $1-1}' | tr '\n' ' ' && echo "ESTABLISHED" # Print the number of established TCP connections
echo -ne "#User log : "; w | wc -l | awk '{print$1-2}'  # Print the number of logged-in users
echo -ne "#Network : "; echo -n "IP " && ip route list | grep link | awk '{print $9}' | tr '\n' ' ' && echo -n "(" && ip link show | grep link/ether | awk '{print $2}' | tr '\n' ')' && printf "\n" # Print network information
echo -ne "#Sudo : "; cat /var/log/sudo.log | wc -l | tr '\n' ' ' && echo "cmd" # Print the number of sudo commands executed
printf "\n"
