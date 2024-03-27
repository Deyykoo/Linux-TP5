#!/usr/bin/bash

machine_name=$(hostnamectl --static)
os=$(cat source /etc/os-release | grep NAME | cut -d'"' -f2 | head -n 1)
kernel=$(uname -r)
local_ip=$( ip a | grep '2: ' -A2 | grep inet | tr -s ' ' | cut -d ' ' -f3)
total_memory=$(free -h | grep 'Mem:' | tr -s ' ' | cut  -d' ' -f2)
available_memory=$(free -h | grep 'Mem:' | tr -s ' ' | cut  -d' ' -f7)
storage=$(df -h | grep root | tr -s ' ' | cut -d' ' -f4)
process=$(ps aux --sort=-%mem | tr -s ' ' | cut -d' ' -f1 | head -n 6 | tail -n 5)
cat=$( curl     "https://cdn2.thecatapi.com/images/0VDLLByGi.jp")
echo "Machine name : $machine_name"
echo "0S $os and kernel version is $kernel"
echo "IP : $local_ip"
echo "RAM : $available_memory memory available on $total_memory total memory"
echo "Disk : $storage space left"


echo "Top 5 processes by RAM usage :"
    echo "$process" | sed 's/^/- /'


echo "Listening ports :"
    ss -utlne | sed -n '2p;4p' | while read ss; do
        port=$(echo "$ss" | tr -s ' ' | cut -d ' ' -f5 | grep -v "::" | cut -d ":" -f2)
        protocol=$( echo "$ss" | tr -s ' ' | grep -v "::" | cut -d' ' -f1)
        program=$(echo "$ss" | tr -s ' ' | cut -d ' ' -f9 | cut -d'/' -f3 | cut -d '.' -f1)
    echo "  - $port $protocol : $program"
    done


echo PATH directories :
    echo "$PATH" | tr ':' '\n' | while read -r directory; do
    echo "  - $directory"
    done

echo "Here is your random cat (jpg file) : $cat"

