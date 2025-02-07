# How setup the lab
## topology

![topology](images/topology_lab.jpg)

## note
Tested with paragon automation version 24.1
based on this [documentation](https://www.juniper.net/documentation/us/en/software/paragon-automation24.1/paragon-automation-installation-guide/topics/topic-map/pa-ubuntu-multinode-install.html) and the paragon nodes require unformatted partition or disk for ceph storage.

Therefore for paragon automation installation on Juniper VMM, I have created another image (ubuntu22.04.qcow2), where it has one harddisk with the size of 300G, 250G has been allocated for base OS, and 50G is free unused disk space.


## Devices in the lab

- VMX : pe1, pe2, pe3, pe4, p1, p2, p3, p4, pe5
- Linux client: client (to provide test traffic) (linux ubuntu)
- Bridge : br1, br2, br3 ( linux bridge between junos node to simulate link failure, delay and packet loss) (linux alpine)

- Kubernetes cluster for Paragon Automation
    - Node1, Node2, Node3 : Linux ubuntu 22.04, to run kubernetes nodes

## Bridges
node | bridges | device A | device Z
|--|--|--|--|
|br1|pe1p1| pe1| p1|
| | p1p2 | p1 | p2|
| | pe2p2 | pe2 | p2|
| | pe1p2| pe1 |p2|
| | pe2p1| pe2 |p1|

node | bridges | device A | device Z
|--|--|--|--|
|br2|p1p3a| p1| p3|
| | p1p3b | p1 | p3|
| | p2p5 | p2 | p5|
| | p1p5 | p1 | p5|
| | p4p5 | p4 | p5|
| | p3p5 | p3 | p5|


node | bridges | device A | device Z
|--|--|--|--|
|br3|pe3p3| pe3| p3|
| | pe4p4 | pe4 | p4|
| | p3p4 | p3 | p4|
| | pe3p4 | pe3 | p4|
| | pe4p3 | pe4 | p3|



## Credential to access devices
- Ubuntu linux
    - user: ubuntu
    - password: pass01
- Alpine linux/Bridge
    - user: alpine
    - password: pass01
- JUNOS vMX
    - user: admin
    - password: pass01

## To create the lab topology and initial configuration of VMs
1. Go to directory [Paragon Lab](./)
2. Edit file [lab.yaml](./lab.yaml). Set the following parameters to choose which vmm server that you are going to use and the login credential:
    - vmmserver 
    - jumpserver
    - user 
    - adpassword
    - ssh_key_name ( please select the ssh key that you want to use, if you don't have it, create one using ssh-keygen and put it under directory **~/.ssh/** on your workstation )
3. If you want to add devices or change the topooogy of the lab, then edit file [lab.yaml](lab.yaml)
4. use [vmm.py](../../vmm.py) script to deploy the topology into the VMM. Run the following command from terminal

        ../../vmm.py upload  <-- to create the topology file and the configuration for the VMs and upload them into vmm server
        ../../vmm.py start   <-- to start the topology in the vmm server

5. Verify that you can access node **gw** using ssh (username: ubuntu,  password: pass01 ). You may have to wait for few minutes for node **gw** to be up and running
6. Run script [vmm.py](../../vmm.py) to send and run initial configuration on node **gw**. This will configure ip address on other interfaces (such ase eth1, eth2, etc) and enable dhcp server on node gw

        ../../vmm.py set_gw

7. Verify that you can access other nodes (linux and junos VM), such **control**, **node1**, **nod21**, etc. Please use the credential to login.

        ssh control

8. Run script [vmm.py](../../vmm.py) to send and run initial configuration on linux nodes. This script will also reboot the VM. So wait before you test connectivity into the VM

        ../../vmm.py set_host

9. Verify that you can access linux and junos VMs, such **control**, **node1**, **node2**, without entering the password. You may have to wait for few minutes for the nodes to be up and running

        ssh control
        ssh node1
        ssh r1

## update system using ansible playbook
note: the ansible script will install and setup the system to meet the requirement for paragon sotware installation.
this ansible playbook will configure the paragon nodes according to the following:
- https://www.juniper.net/documentation/us/en/software/paragon-automation24.1/paragon-automation-installation-guide/topics/topic-map/pa-ubuntu-install-prereqs.html

### Steps

1. On your workstation, go into directory linux_node

        cd linux_node
2. Run the ansible playbook update_system.yaml, to update system on the nodes.

        ansible-playbook update_system.yaml

![update_system](images/update_system.png)

3. The ansible playbook will update node1, node2, node3, control and client

## network configuration on node gw and vmx nodes
1. Add the following configuration on node **gw**. These configuration is for SNAT (Source NAT) for any session from PA nodes (node1, node2, node3), toward network devices

       sudo iptables -t nat -A POSTROUTING -o eth3 --source 172.16.11.0/28 --destination 10.100.1.0/24 -j SNAT --to 172.16.255.0
       sudo iptables -t nat -A POSTROUTING -o eth3 --source 172.16.11.0/28 --destination 10.100.0.0/24 -j SNAT --to 172.16.255.0
       sudo iptables -t nat -A POSTROUTING -o eth3 --source 172.16.12.0/24 --destination 10.100.1.0/24 -j SNAT --to 172.16.255.0
       sudo iptables -t nat -A POSTROUTING -o eth3 --source 172.16.12.0/24 --destination 10.100.0.0/24 -j SNAT --to 172.16.255.0


2. to make it permanent on node **gw**, add those into file /usr/local/bin/startup.sh

       export LINENUM=`grep -n 'exit ' /usr/local/bin/startup.sh | cut -f 1 -d ":"`
       sudo sed -i -e "${LINENUM}d" /usr/local/bin/startup.sh
       cat << EOF | sudo tee -a /usr/local/bin/startup.sh
       sudo iptables -t nat -A POSTROUTING -o eth3 --source 172.16.11.0/28 --destination 10.100.1.0/24 -j SNAT --to 172.16.255.0
       sudo iptables -t nat -A POSTROUTING -o eth3 --source 172.16.11.0/28 --destination 10.100.0.0/24 -j SNAT --to 172.16.255.0
       sudo iptables -t nat -A POSTROUTING -o eth3 --source 172.16.12.0/24 --destination 10.100.1.0/24 -j SNAT --to 172.16.255.0
       sudo iptables -t nat -A POSTROUTING -o eth3 --source 172.16.12.0/24 --destination 10.100.0.0/24 -j SNAT --to 172.16.255.0
       exit 1
       EOF

3. add the following configuration on node **gw** for BGP on FRR

       ssh gw
       sudo apt -y update && sudo apt -y upgrade
       sudo vtysh 
       config t
       router bgp 65412
       no bgp ebgp-requires-policy
       neighbor 172.16.11.11 remote-as 65420
       neighbor 172.16.11.12 remote-as 65420
       neighbor 172.16.11.13 remote-as 65420
       exit
       exit
       write mem
       exit
       sudo reboot

4. From one of paragon node (node1, node2, node3), verify connectivity to loopback of the network devices , and verify that the session is coming from ip address 172.16.255.0 (SNAT configured on step 2)

       ssh node1
       ping 10.100.1.1
       ping 10.100.1.11
       ssh admin@10.100.1.15
       show system users

5. go to [this directory ](./config/router/router_config), and ansible playbook [update_router.yaml](./config/router/router_config/update_router.yaml) to put additional configuration into network devices (VMX)

       cd config/router/router_config
       ansible-playbook update_router.yaml

## Uploading Paragon Automation installation file and start the installation

1. Upload paragon automation installation file into node **control** ( Caution: The size of the installation (as for version 24.1) is around 15G, so it may take time to upload the file into node **control** from your workstation

        scp Paragon_24.1.tar.gz control:~/

2. the ansible playbook from the previous script has installed docker into node control. verify that docker has been installed on node control

3. Extract Paragon installation file 

         tar xpvfz Paragon24.1.tar.gz


4. Run file **run** from paragon installation file  to initialize configuration directory **configdir**

        chmod +x Paragon_24.1/run 
        Paragon_24.1/run -c configdir init

![init.png](images/pa23.2.init.jpg)

5. Run file **run** from paragon installation to fill initial configuration (ip addresses of kubernetes nodes, and password)
       
        Paragon_24.1/run -c configdir inv

![inv.png](images/pa23.2.inv.jpg)

6. Copy RSA public key into directory **configdir**

       cp ~/.ssh/id_rsa ~/configdir

7. Run file **run** from paragon installation to configure paragon parameter
        
       ./Paragon_24.1/run -c configdir conf

![run_conf.png](images/pa23.2.conf.1.jpg)

![run_conf.png](images/pa23.2.conf.2.jpg)

![run_conf.png](images/pa23.2.conf.3.jpg)

8. Edit file configdir/config.yml, and enable parameter to enable BGP for Metallb.

change the following 

       # alternatively, for metallb in L3 (BGP) mode, enable the following:
       # metallb_mode: l3
       # metallb_asn: 64500
       # metallb_peer_asn: 64501
       # metallb_peer_address: 192.168.10.1

into 

       # alternatively, for metallb in L3 (BGP) mode, enable the following:
       metallb_mode: l3
       metallb_asn: 65420
       metallb_peer_asn: 65412
       metallb_peer_address: 172.16.11.1

9. Start Paragon automation installation process. The installation proccess may take up to 90 minutes to finish.

       tmux
       ./Paragon_24.1/run -c configdir  deploy -e ignore_iops_check=yes -e offline_install=true

![deploy.png](images/pa23.2.deploy.jpg)

![finish.png](images/pa23.2.finish.jpg)


## Accessing Web Interface of Paragon automation
There are three options to access Web UI of paragon.
1. Using wireguard VPN
2. using sock proxy with SSH dynamic forwarding
3. Using ssh forwarding

## Accessing Apstra Web UI using wireguard VPN
1. on your workstation, install wiregauard vpn 

        brew install wireguard-go

2. If wireguard configuration has not been created, then create it using vmm.py script

        ../../vmm.py create_wg_config

3. it will create to configuration file, tmp/wg0_ws.conf which is the wireguard configuration for your workstation, and tmp/wg0_gw.conf, which is the wireguard configuration for node gw

4. upload file tmp/wg0_gw.conf into node gw, put it into file /etc/wireguard/wg0.conf, and start wireguard services

        scp tmp/wg0_gw.conf gw:~/
        ssh gw "sudo cp ~/wg0_gw.conf /etc/wireguard/wg0.conf"
        ssh gw "sudo wg-quick up wg0"

5. copy file tmp/wg0_ws.conf into your workstation wireguard directory

        cp tmp/wg0_ws.conf /usr/local/etc/wireguard/wg0.conf
        sudo wg-quick up wg0

6. Verify that from your workstation you can access apstra controller

        ping 172.16.255.1
        curl -k https://172.16.255.1
        
7. open dashboard of apstra controller

## Accessing Apstra WEB UI using sock proxy with SSH dynamic forwarding
1. from your workstation, open ssh session to node **proxy** and keep the session open

        ssh proxy

2. Use firefox web browser, open setting configuration, and search for proxy configuration.
3. Under **Configure Proxy Access to the Internet**, and set to **Manual proxy configuratio**
4. under **SOCKS Host** set ip address to **127.0.0.1** and Port to **1080**, and clik **OK** to save it
5. on the URL bar, open access to apstra dashboard https://172.16.255.1

![firefox](images/firefox_proxy.jpg)


## Accessing Apstra WEB UI using ssh forwarding
1. open ssh session with forwarding to ip address of apstra server (172.16.10.2) and port 443

        ssh -L 9191:172.16.10.2:443 gw

2. from webbrowser on your workstation, open https session to https://127.0.0.1:9191




1. From your workstation, open ssh session to node **gw** with ssh port forwarding for port 9191 to IP 172.16.255.1 port 443, and keep this session open if you need to access the web dashboard of Paragon Automation platform

        ssh -L 9191:172.16.255.1:443 gw


4. Open http session to https://127.0.0.1:9191, and login using default credential, user/password: admin/Admin123!, and change the password  
![web1](images/web1.png) 
![web2](images/web2.png) 
![web3](images/web3.png) 

5. By default, no license is installed on Paragon Automation platform, and access to Paragon automation function, Pathfinder, Planner and Insight, are disabled. Get the license from [Agile Internal Licensing Portal](https://internal-license.juniper.net/nckt/)

![license1](images/license1.png)

6. Install the license into Paragon automation platform, then menu to access Paragon automation function, Pathfinder, Insight, and Planner, will be accessible

![license2](images/license2.png)

or you can use [this](install/paragon_automation.txt) 

7. To enable proxy on javaws to access access into Paragon Planner Desktop, from terminal run **javaws -viewer**, and set the proxy

![java_cp](images/java_cp.png)
![network_settings](images/network_settings.png)
![socks_proxy](images/socks_proxy.png)

7. Now you can explore the Paragon automation platform. You can start doing [initial setup](Initial_setup.md)

## getting opendistro username/password

        kubectl get secret -n kube-system opendistro-es-account -o jsonpath={..username} | base64 -d
        kubectl get secret -n kube-system opendistro-es-account -o jsonpath={..password} | base64 -dk

## enable LSP latency calculation on paragon pathfinder
do the following enable LSP latency calculation

        # kubectl  -n northstar get pods | grep bmp
        # kubectl -n northstar exec -it `kubectl -n northstar get pods | grep bmp | tr -s " " | cut -f 1 -d " "` -c crpd cli
        # kubectl  -n northstar exec -it `kubectl  -n northstar get pods | grep cmgd | cut -f 1 -d " "`  -c ns-cmgd cli
        kubectl -n northstar exec -it `kubectl -n northstar get pods | grep cmgd | tr -s " " | cut -f 1 -d " "` -c ns-cmgd cli
        edit
        set northstar path-computation-server lsp-latency-interval 60s
        commit
 

 