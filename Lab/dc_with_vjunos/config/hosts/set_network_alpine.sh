cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.14.134/24
  gateway 192.168.14.254
iface eth0 inet6 static
  address fc00:dead:beef:a014::1000:134/64
  gateway fc00:dead:beef:a014::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm4kvm3
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 172.16.15.11/24
  gateway 172.16.15.1
iface eth0 inet6 static
  address fc00:dead:beef:ff15::1000:11/64
  gateway fc00:dead:beef:ff15::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
ext1
EOF

