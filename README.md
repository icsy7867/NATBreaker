# NATBreaker
IPtable scripts for forwarding traffic through a tunnel interface.

After initializing VPN (Using Openvpn), these scripts have a server and a client version that will forward and transmit packet inside a NAT if a user does not have an external IPv4 address.  Requires a VPS of some sort with a dedicated IPv4 address.  Examples include 443 and 32400.

*NOTES*
eth0 is the name of your primary interface. I am using an OpenVZ container from RamNode which uses venet0

```
Make sure:
net.ipv4.ip_forward = 1
is listed in /etc/sysctl.conf
```

While this does not cover setting up OpenVPN or another tunnel service, I am using https://github.com/kylemanna/docker-openvpn/ for openvpn via Docker in my VPS (OpenVZ container hosted by RamNode).

I am using https://github.com/dperson/openvpn-client for my internal client.

# Server Config:
Set your server openvpn IP address and the destination openvpn IP address (The Kylemanna container issues a 192.168.255.X).  Also set the ports you are forwarding in the array:
```
#for ports 443 and 32400 through the tunnel
ports=( 443 32400 )

```

# Client Config:
Set the same client and server OpenVPN IP addresses, as well as the same destination ports.  Additionally, though, you need to direct the packets to their final destinations.  The `destinations` array should be in the same order as your `ports` array.

So for:

```
ports=( 443 32400 )
destinations=( 17.181.30.18 17.181.30.10 )
```

443 will get routed to the internal network of 17.181.30.18
and 32400 will get routed to 17.181.30.10.
