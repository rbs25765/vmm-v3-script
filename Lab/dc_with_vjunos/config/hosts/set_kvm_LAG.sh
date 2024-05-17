cat << EOF | sudo tee /etc/netplan/02_net.yaml
network:
  ethernets:
    eth1:
      dhcp4: no
      mtu: 9000
    eth2:
      dhcp4: no
      mtu: 9000
  bridges:
    ovs0:
      openvswitch: {}
      interfaces:
      - bond0
  bonds:
    bond0:
      macaddress: 56:04:1b:00:6f:98
      mtu: 9000
      interfaces:
        - eth1
        - eth2
      parameters:
         mode: 802.3ad
EOF