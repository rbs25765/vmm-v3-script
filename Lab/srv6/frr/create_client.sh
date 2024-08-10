#!/bin/bash
# for i in c{1..4}evpn1
# do
#     echo "creating LXC ${i}"
#     lxc copy client ${i}
# done


export LXC_NAME=c2
export VLAN=101
export OVS=ovs2
echo "Creating container ${LXC_NAME}"
lxc copy client ${LXC_NAME}
lxc query --request PATCH /1.0/instances/${LXC_NAME} --data "{
  \"devices\": {
    \"eth0\" :{
       \"name\": \"eth0\",
       \"nictype\": \"bridged\",
       \"parent\": \"${OVS}\",
       \"vlan\" : \"${VLAN}\",
       \"type\": \"nic\"
    }
  }
}"

lxc start ${LXC_NAME}


cat << EOF | sudo tee /etc/radvd.conf

interface eth3.101
{
	AdvSendAdvert on;
	MinRtrAdvInterval 30;
	MaxRtrAdvInterval 100;
	prefix fc00:dead:beef:a012::/64
	{
		AdvOnLink on;
		AdvAutonomous on;
		AdvRouterAddr on;
	};
};
EOF
sudo systemctl restart radvd


cat << EOF | sudo tee /etc/dhcp/dhcpd.conf
default-lease-time 600;
max-lease-time 7200;
ddns-update-style none;
subnet 192.168.12.0 netmask 255.255.255.0 {
   range 192.168.12.11 192.168.12.200;
   option routers 192.168.12.1;
}
EOF

sudo systemctl restart isc-dhcp-server


cat << EOF | sudo tee /etc/dhcp/dhcpd6.conf
default-lease-time 2592000;
preferred-lifetime 604800;
option dhcp-renewal-time 3600;
option dhcp-rebinding-time 7200;
allow leasequery;
option dhcp6.info-refresh-time 21600;
subnet6 fc00:dead:beef:a011::/64 {
    range6 fc00:dead:beef:a011::1000:1 fc00:dead:beef:a011::1000:ffff;
}
EOF


EOF

sudo dhcpd -user dhcpd -group dhcpd -6 -pf /run/dhcp-server/dhcpd6.pid -cf /etc/dhcp/dhcpd6.conf eth3.101
