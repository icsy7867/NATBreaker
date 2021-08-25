#!/bin/bash

# https://serverfault.com/questions/586486/how-to-do-the-port-forwarding-from-one-ip-to-another-ip-in-same-network

interfaceName="eth0"
tunInterface="tun0"
clientIP="192.168.255.6"
serverIP="192.168.255.1"

declare -a ports
ports=( 443 32400 )
declare -a destinations
destinations=( 172.20.30.18 172.20.30.10 )
hostIP=$(hostname -i)



iptables -F
iptables -t nat -F
iptables -X

for i in "${!ports[@]}"

do
        port=${ports[$i]}
        echo $port
        destination=${destinations[$i]}
        echo $destination

        iptables -t nat -A PREROUTING -p tcp --dport $port -j DNAT --to-destination $destination:$port
        iptables -t nat -A POSTROUTING -p tcp -d $destination --dport $port -j SNAT --to-source ${hostIP}

done
