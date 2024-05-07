#!/bin/bash
VM=vm1
DISK=${VM}.img
VLAN=101
LAN=ovs0
virt-install --name ${VM} \
  --disk ./${DISK},device=disk,bus=virtio \
  --ram 256 --vcpu 1 --osinfo alpinelinux3.18 \
  --network=bridge:${LAN},model=virtio,virtualport_type=openvswitch \
  --xml "./devices/interface/vlan/tag/@id=${VLAN}" \
  --xml "./devices/interface/target/@dev=${VM}_e0" \
  --console pty,target_type=serial \
  --noautoconsole \
  --hvm --accelerate \
  --vnc \
  --virt-type=kvm \
  --boot hd --noreboot


cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.101.101/24
  gateway 192.168.101.254
iface eth0 inet6 static
  address fc00:dead:beef:a101::1000:101/64
  gateway fc00:dead:beef:a101::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm1kvm1
EOF


cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.102.101/24
  gateway 192.168.102.254
iface eth0 inet6 static
  address fc00:dead:beef:a102::1000:101/64
  gateway fc00:dead:beef:a102::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm1kvm2
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.101.102/24
  gateway 192.168.101.254
iface eth0 inet6 static
  address fc00:dead:beef:a101::1000:102/64
  gateway fc00:dead:beef:a101::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm2kvm2
EOF




cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.201.103/24
  gateway 192.168.201.254
iface eth0 inet6 static
  address fc00:dead:beef:a201::1000:103/64
  gateway fc00:dead:beef:a201::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm3kvm1
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
extsvr1
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.202.103/24
  gateway 192.168.202.1
iface eth0 inet6 static
  address fc00:dead:beef:a202::1000:103/64
  gateway fc00:dead:beef:a202::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm3kvm2
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.202.104/24
  gateway 192.168.202.254
iface eth0 inet6 static
  address fc00:dead:beef:a202::1000:104/64
  gateway fc00:dead:beef:a202::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm4kvm1
EOF


cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.101.131/24
  gateway 192.168.101.254
iface eth0 inet6 static
  address fc00:dead:beef:a101::1000:131/64
  gateway fc00:dead:beef:a101::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm1kvm3
EOF


cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.102.132/24
  gateway 192.168.102.254
iface eth0 inet6 static
  address fc00:dead:beef:a102::1000:132/64
  gateway fc00:dead:beef:a102::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm2kvm3
EOF


cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.201.133/24
  gateway 192.168.201.254
iface eth0 inet6 static
  address fc00:dead:beef:a201::1000:133/64
  gateway fc00:dead:beef:a201::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm3kvm3
EOF


cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.202.134/24
  gateway 192.168.202.254
iface eth0 inet6 static
  address fc00:dead:beef:a202::1000:134/64
  gateway fc00:dead:beef:a202::1
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
  address 192.168.131.151/24
  gateway 192.168.131.254
iface eth0 inet6 static
  address fc00:dead:beef:a131::1000:151/64
  gateway fc00:dead:beef:a131::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm1kvm5
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.132.162/24
  gateway 192.168.132.254
iface eth0 inet6 static
  address fc00:dead:beef:a132::1000:162/64
  gateway fc00:dead:beef:a132::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm2kvm6
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.51.5/24
  gateway 192.168.51.254
iface eth0 inet6 static
  address fc00:dead:beef:a051::1000:5/64
  gateway fc00:dead:beef:a051::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm5kvm1
EOF




cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.52.3/24
  gateway 192.168.52.254
iface eth0 inet6 static
  address fc00:dead:beef:a052::1000:3/64
  gateway fc00:dead:beef:a052::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm3kvm6
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.55.6/24
  gateway 192.168.55.254
iface eth0 inet6 static
  address fc00:dead:beef:a055::1000:6/64
  gateway fc00:dead:beef:a055::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm6kvm1
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.55.4/24
  gateway 192.168.55.254
iface eth0 inet6 static
  address fc00:dead:beef:a055::1000:4/64
  gateway fc00:dead:beef:a055::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm4kvm6
EOF


cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.61.4/24
  gateway 192.168.61.254
iface eth0 inet6 static
  address fc00:dead:beef:a061::1000:4/64
  gateway fc00:dead:beef:a061::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm4kvm2
EOF


cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.61.7/24
  gateway 192.168.61.254
iface eth0 inet6 static
  address fc00:dead:beef:a061::1000:7/64
  gateway fc00:dead:beef:a061::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm7kvm1
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.61.25/24
  gateway 192.168.61.254
iface eth0 inet6 static
  address fc00:dead:beef:a061::1000:25/64
  gateway fc00:dead:beef:a061::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm2kvm5
EOF


cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.65.8/24
  gateway 192.168.65.254
iface eth0 inet6 static
  address fc00:dead:beef:a065::1000:8/64
  gateway fc00:dead:beef:a065::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm8kvm1
EOF



cat << EOF | sudo tee /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 192.168.65.56/24
  gateway 192.168.65.254
iface eth0 inet6 static
  address fc00:dead:beef:a065::1000:56/64
  gateway fc00:dead:beef:a065::1
EOF

cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hostname
vm5kvm6
EOF


#!/bin/bash
VM=vm1
DISK=${VM}.img
VLAN=101
LAN=ovs0
virt-install --name ${VM} \
  --disk ./${DISK},device=disk,bus=virtio \
  --disk ./seed.iso,device=cdrom \
  --ram 256 --vcpu 1 --osinfo ubuntu22.04 \
  --network=bridge:${LAN},model=virtio,virtualport_type=openvswitch \
  --xml "./devices/interface/vlan/tag/@id=${VLAN}" \
  --xml "./devices/interface/target/@dev=${VM}_e0" \
  --console pty,target_type=serial \
  --noautoconsole \
  --hvm --accelerate \
  --vnc \
  --virt-type=kvm \
  --boot hd 


#!/bin/bash
VM=dhcp1
DISK=${VM}.img
VLAN=101
LAN=ovs0
virt-install --name ${VM} \
  --disk ./${DISK},device=disk,bus=virtio \
  --disk ./seed.iso,device=cdrom \
  --ram 2048 --vcpu 1 --osinfo ubuntu22.04 \
  --network=bridge:${LAN},model=virtio,virtualport_type=openvswitch \
  --xml "./devices/interface/target/@dev=${VM}_e0" \
  --console pty,target_type=serial \
  --noautoconsole \
  --hvm --accelerate \
  --vnc \
  --virt-type=kvm \
  --boot hd 




set protocols bgp group to_dc3 neighbor 10.1.101.16 peer-as 4200003105
set protocols bgp group to_dc3 neighbor 10.1.101.18 peer-as 4200003106
set protocols bgp group to_dc3 neighbor fc00:dead:beef:ff01::16 peer-as 4200003105
set protocols bgp group to_dc3 neighbor fc00:dead:beef:ff01::18 peer-as 4200003106
set protocols bgp group to_dc3 neighbor 10.1.101.20 peer-as 4200003105
set protocols bgp group to_dc3 neighbor 10.1.101.22 peer-as 4200003106
set protocols bgp group to_dc3 neighbor fc00:dead:beef:ff01::20 peer-as 4200003105
set protocols bgp group to_dc3 neighbor fc00:dead:beef:ff01::22 peer-as 4200003106

