# NATBreaker
IPtable scripts for forwarding traffic through a tunnel interface.

After initializing VPN (Using Openvpn), these scripts have a server and a client version that will forward and transmit packet inside a NAT if a user does not have an external IPv4 address.  Requires a VPS of some sort with a dedicated IPv4 address.

*NOTES*
eth0 is the name of your primary interface. I am using an OpenVZ container from RamNode which uses venet0

Make sure:
net.ipv4.ip_forward = 1

is listed in /etc/sysctl.conf

Edit - Trying to move to EasyRSA3
https://www.sys-dev.cat/blog/3/
