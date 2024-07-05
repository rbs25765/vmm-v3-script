#!/bin/bash
cat << EOF | sudo tee /etc/netplan/02_net.yaml
network:
  bridges:
    ce1eth1: {}
    ce2eth1: {}
    ce3eth1: {}
    ce4eth1: {}
    ce5eth1: {}
    ce6eth1: {}
    ce7eth1: {}
    ce8eth1: {}
    ovs1:
      openvswitch: {}
      interfaces: [eth1]
    ovs2:
      openvswitch: {}
      interfaces: [eth2]
EOF

sudo netplan apply

for i in ce{1..8}eth1
do
   sudo sysctl -w "net.ipv6.conf.${i}.disable_ipv6=1"
done
