#!/bin/bash
#echo 1 > /proc/sys/net/ipv4/ip_forward

interfaceName="eth0"
tunInterface="tun0"
clientIP="192.168.255.6"
serverIP="192.168.255.1"

declare -a ports
ports=( 443 32400 )


##Allow crosstalk
iptables -A FORWARD -i ${tunInterface} -o ${interfaceName} -j ACCEPT
iptables -A FORWARD -i ${interfaceName} -o ${tunInterface} -j ACCEPT
iptables -A FORWARD -i ${interfaceName} -o ${tunInterface} -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i ${tunInterface} -o ${interfaceName} -m state --state ESTABLISHED,RELATED -j ACCEPT

for port in "${ports[@]}"

do
  	echo $port
        iptables -t nat -A PREROUTING -i ${interfaceName} -p tcp --dport $port -j DNAT --to-destination ${clientIP}:$port
        iptables -t nat -A POSTROUTING -p tcp -d ${clientIP} --dport $port -j SNAT --to-source ${serverIP}

done
