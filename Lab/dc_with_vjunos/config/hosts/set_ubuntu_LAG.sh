sudo hostname svr4
hostname | sudo tee /etc/hostname
cat << EOF | sudo tee /etc/netplan/01_net.yaml

network:
  ethernets:
    eth0:
      dhcp4: no
    eth1:
      dhcp4: no
  bonds:
    bond0:
      macaddress: 56:04:1b:00:84:6b
      interfaces:
        - eth0
        - eth1
      parameters:
         mode: 802.3ad
      addresses: [ 192.168.13.4/24, fc00:dead:beef:a013::1000:4/64]
      routes:
      - to: 0.0.0.0/0
        via: 192.168.13.254
      - to: ::/0
        via: fc00:dead:beef:a013::1
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
EOF

uuidgen | sed -e "s/-//g" | sudo tee /etc/machine-id