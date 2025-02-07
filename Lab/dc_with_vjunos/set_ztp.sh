#!/bin/bash

Network configuration for ztp 

cat << EOF  | sudo tee /etc/netplan/01-netcfg.yaml
network:
    version: 2
    # renderer: networkd
    ethernets:
        eth0:
            dhcp4: false
            addresses: [ 172.16.10.3/24]
            gateway4: 172.16.10.1
            nameservers:
                addresses: [ 10.49.32.95, 10.49.32.95 ]
EOF

sudo netplan apply

mkdir ~/.ssh
scp ubuntu@172.16.10.1:~/.ssh/* ~/.ssh/

/containers_data/status/app/aos.conf


cat << EOF | sudo tee /containers_data/status/app/aos.conf
{
    "ip": "172.16.10.2",
    "user": "ztp",
    "password": "J4k4rt4#01"
}
EOF

docker restart status

/containers_data/tftp/ztp.json


cat << EOF | sudo tee /containers_data/tftp/junos_custom1.sh
#!/bin/sh 
cli -c "configure; set system commit synchronize; set chassis evpn-vxlan-default-switch-support; commit and-quit"
EOF
sudo chmod +x /containers_data/tftp/junos_custom1.sh

export JUNOS_VERSION="23.4R1.10"
#export JUNOS_VERSION="23.2R1.14"
sudo sed -i -e "s/junos-version1/${JUNOS_VERSION}/" /containers_data/tftp/ztp.json
sudo sed -i -e "s/junos-version2//" /containers_data/tftp/ztp.json
export LINE_JUNOS=`grep -n '"junos": {' /containers_data/tftp/ztp.json | cut -f 1 -d ":"`
sudo sed -i -e "${LINE_JUNOS}a    \"custom-config\": \"junos_custom1.sh\"," /containers_data/tftp/ztp.json

docker restart tftp


cat << EOF | sudo tee /containers_data/tftp/junosevo_custom1.sh
#!/bin/sh 
cli -c "configure; set forwarding-options tunnel-termination; commit and-quit"
EOF
sudo chmod +x /containers_data/tftp/junosevo_custom1.sh


/containers_data/dhcp/dhcpd.conf

line1=`grep -n "Step 2"  /containers_data/dhcp/dhcpd.conf | cut -f 1 -d ":"`
line1=`expr $line1 + 1`
line2=`grep -n "Step3"  /containers_data/dhcp/dhcpd.conf | cut -f 1 -d ":"`
line2=`expr $line2 - 1`
sudo sed -i -e "${line1},${line2}d" /containers_data/dhcp/dhcpd.conf
sudo sed -i -e 's/dc1.yourdatacenter.com/vmmlab.juniper.net/' /containers_data/dhcp/dhcpd.conf
sudo sed -i -e 's/10.1.2.13, 10.1.2.14/10.49.32.95, 10.49.32.95/' /containers_data/dhcp/dhcpd.conf

cat ~/ztp_config.txt | sudo tee -a  /containers_data/dhcp/dhcpd.conf

docker restart dhcpd



Apstra flow configuration

cat << EOF  | sudo tee /etc/netplan/01-netcfg.yaml
network:
    version: 2
    # renderer: networkd
    ethernets:
        eth0:
            dhcp4: false
            addresses: [ 172.16.10.4/24]
            gateway4: 172.16.10.1
            nameservers:
                addresses: [ 10.49.32.95, 10.49.32.95 ]
EOF

sudo netplan apply

sudo sed -i -e 's/EF_JUNIPER_APSTRA_API_HOSTNAME: ""/EF_JUNIPER_APSTRA_API_HOSTNAME: "https:\/\/172.16.10.2"/' /etc/juniper/flowcoll.yml
sudo sed -i -e 's/EF_JUNIPER_APSTRA_API_PASSWORD: ""/EF_JUNIPER_APSTRA_API_PASSWORD: "J4k4rt4#01"/' /etc/juniper/flowcoll.yml
sudo sed -i -e 's/EF_JUNIPER_APSTRA_API_USERNAME: ""/EF_JUNIPER_APSTRA_API_USERNAME: "admin"/' /etc/juniper/flowcoll.yml

sudo systemctl restart flowcoll
sudo systemctl restart opensearch
sudo systemctl restart opensearch-dashboards

