cat << EOF | sudo tee /etc/netplan/02_net.yaml
network:
  ethernets:       
    eth3:
      dhcp4: false
      mtu: 9000
       
    eth1:
      dhcp4: false
      mtu: 9000
      addresses:
        - 10.100.1.4/31
        - fc00:dead:beef:ffff::4/127
       
    eth2:
      dhcp4: false
      mtu: 9000
      addresses:
        - 10.100.1.6/31
        - fc00:dead:beef:ffff::6/127
  vlans:
    eth3.101:
      dhcp4: false
      id: 101
      link: eth3
      addresses:
        - 192.168.12.1/24
        - fc00:dead:beef:a012::1/64
EOF

sudo netplan apply

sudo sed -i -e "s/isisd=no/isisd=yes/" /etc/frr/daemons 

cat << EOF | sudo tee -a /etc/frr/frr.conf
interface eth1
 ip router isis test1
 ipv6 router isis test1
 isis circuit-type level-2-only
 isis network point-to-point
exit
!
interface eth2
 ip router isis test1
 ipv6 router isis test1
 isis circuit-type level-2-only
 isis network point-to-point
exit
!
interface eth3.101
 ip router isis test1
 ipv6 router isis test1
exit
!
router isis test1
 is-type level-2-only
 net 49.0001.0001.0001.0012.00
exit
!
end
EOF

sudo systemctl restart frr
