# This document provide guideline on how to install bbecloud setup

## Nodes in the lab

deployer: jump host to run the installation script
node1, node2, node3: kubernetes nodes

## steps
1. On your workstation, run ansible playbook [update_system.yaml](linux_node/update_system.yaml) to update system software on kubernetes nodes and to create the disk partitions required by bbecloud software

        cd linux_node
        ansible-playbook update_system.yaml

2. open ssh session into node **deployer**, create new ssh key, and upload this key to the kubernetes nodes 

        ssh deployer
        ssh-keygen -f ~/.ssh/key1
        for i in ubuntu@172.16.11.11{1..3}
        do
            ssh-copy-id -i ~/.ssh/key1.pub ${i}
        done

3. upload the bbecloudsetup package into node deployer

        scp bbecloudsetup-v2.0.0.tgz deployer:~/

4. open ssh session into node deployer, and extract bbecloudsetup installation package

        ssh deployer
        tar xvfz bbecloudsetup-v2.0.0.tgz

5. create configuration template for bbecloudsetup. (copy the exampleconfig.yaml to config.yaml, and edit file config.yaml). Set the parameters inside file config.yaml

        cd bbecloudsetup
        cp exampleconfig.yaml config.yaml
        vi config.yaml

4. on node deployer, start ssh-agent and add ssh-key **key1** into the agent

        eval $(ssh-agent)
        ssh-add ~/.ssh/key1

5. on node deployer, start the installation process of bbecloudsetup

        tmux
        cd ~/bbecloudsetup
        sudo -E ./bbecloudsetup -d install -template ./config.yaml



