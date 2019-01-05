#!/bin/bash
#17.181.30.231 Is the openvpn Client NAT IP Address
#Other 17.181.30.X is the internal NAT IP address
# https://serverfault.com/questions/586486/how-to-do-the-port-forwarding-from-one-ip-to-another-ip-in-same-network

iptables -F
iptables -t nat -F
iptables -X

## Web Servers
iptables -t nat -A PREROUTING -p tcp --dport 443 -j DNAT --to-destination 17.181.30.9:443
iptables -t nat -A POSTROUTING -p tcp -d 17.181.30.9 --dport 443 -j SNAT --to-source 17.181.30.231

## Web Servers
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 17.181.30.9:80
iptables -t nat -A POSTROUTING -p tcp -d 17.181.30.9 --dport 80 -j SNAT --to-source 17.181.30.231

## Minecraft PE
iptables -t nat -A PREROUTING -p udp --dport 19132 -j DNAT --to-destination 17.181.30.9:19132
iptables -t nat -A POSTROUTING -p udp -d 17.181.30.9 --dport 19132 -j SNAT --to-source 17.181.30.231

## Emby
iptables -t nat -A PREROUTING -p tcp --dport 8920 -j DNAT --to-destination 17.181.30.10:8920
iptables -t nat -A POSTROUTING -p tcp -d 17.181.30.10 --dport 8920 -j SNAT --to-source 17.181.30.231

## openvpn
iptables -t nat -A PREROUTING -p udp --dport 1194 -j DNAT --to-destination 17.181.30.8:1194
iptables -t nat -A POSTROUTING -p udp -d 17.181.30.8 --dport 1194 -j SNAT --to-source 17.181.30.231

## RDP
iptables -t nat -A PREROUTING -p tcp --dport 3389 -j DNAT --to-destination 17.181.30.13:3389
iptables -t nat -A POSTROUTING -p tcp -d 17.181.30.13 --dport 3389 -j SNAT --to-source 17.181.30.231

## RDP
iptables -t nat -A PREROUTING -p udp --dport 3389 -j DNAT --to-destination 17.181.30.13:3389
iptables -t nat -A POSTROUTING -p udp -d 17.181.30.13 --dport 3389 -j SNAT --to-source 17.181.30.231
