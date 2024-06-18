#!/bin/bash
cat << EOF | sudo tee /etc/netplan/02_net.yaml
network:
  vlans:
    eth1v101:
      id: 101
      link: eth1
    eth3v101:
      id: 101
      link: eth3
    eth1v102:
      id: 102
      link: eth1
    eth3v102:
      id: 102
      link: eth3
    eth1v103:
      id: 103
      link: eth1
    eth3v103:
      id: 103
      link: eth3
    eth1v104:
      id: 104
      link: eth1
    eth3v104:
      id: 104
      link: eth3
    eth1v105:
      id: 105
      link: eth1
    eth3v105:
      id: 105
      link: eth3
  bridges:
    pe11gev101:
      interfaces: [eth1v101]
    ce1eth1: {}
    pe12gev101:
      interfaces: [eth3v101]
    ce2eth1: {}
    pe11gev102:
      interfaces: [eth1v102]
    ce3eth1: {}
    pe12gev102:
      interfaces: [eth3v102]
    ce4eth1: {}
    pe11gev103:
      interfaces: [eth1v103]
    pe12gev103:
      interfaces: [eth3v103]
    pe11gev104:
      interfaces: [eth1v104]
    pe12gev104:
      interfaces: [eth3v104]
    ce5eth1: {}
    ce6eth1: {}
    pe11gev105:
      interfaces: [eth1v105]
    pe12gev105:
      interfaces: [eth3v105]
    ce7eth1: {}
    ce8eth1: {}
EOF

sudo netplan apply

for i in ce{1..8}eth1 pe11gev10{1..5} pe12gev10{1..5}
do
   sudo sysctl -w "net.ipv6.conf.${i}.disable_ipv6=1"
done
