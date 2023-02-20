#!/usr/bin/env bash

##################################################################################
## function: rm_config()
## Remove all configurations including aliases, mount points and keys
## Steps of function:
## 1. source .bashrc file & ask user delete configs
## 2. if yes remove alias, mounting point and ssh key
## 3. if no echo ok
##################################################################################

sudo inc/log.sh apt
sudo inc/log.sh git
sudo inc/log.sh run
sudo inc/log.sh data

rm_config() {

. ~/.bashrc
echo -n "Would you like to delete all configs (Y/N)"
read delete_config 

if [[ $delete_config == "Y" ]]; then
	sed -i -e '/alias package=/d' ~/.bashrc
	sudo rm -rf /mnt/server
	sed -i -e '/sudo sshfs/d' ~/.bashrc
	rm -rf ~/.ssh/id*
else
	echo "Ok, keeping current config"
fi
. ~/.bashrc
}

##################################################################################
## function: current_config()
## Prints current configuration.
## Steps of function:
## 1. list /mnt directory to check for mount point
## 2. list ~/.ssh to check for ssh key
## 3. print .bashrc to check for configs
##################################################################################

current_config() {
	sudo ls -als /mnt
	ls -als ~/.ssh
	. ~/.bashrc
	echo ".bashrc configs:"
	cat ~/.bashrc | grep "alias package"
	echo ".bashrc configs:"
	cat ~/.bashrc | grep "sudo sshfs"
	
}

appending_config() {
	. ~/.bashrc
	FILE=~/.ssh/config
	if test -f "$FILE"; then
		echo "Host * 
			AddKeysToAgent yes 
			IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
	else
		touch ~/.ssh/config
		echo "Host * 
			AddKeysToAgent yes  
			IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
	fi
}

process_networking() {

echo "Wireless Interface:"
echo $(ip a | grep "wlp3s0")
echo "Physical Interface:"
echo $(ip a | grep "eth0")

inc/ping.sh 142.250.70.174
inc/ping.sh 172.105.180.73
inc/ping.sh 192.168.1.1
inc/ping.sh 192.168.0.1

echo "View systemctl processes (Y/N:)"
read answer
if [[ $answer == 'Y' ]]; then
	sudo systemctl list-units --type=service -all
	echo "$(date)" >> /mnt/server/processes.txt
	sudo systemctl list-units --type=service -all >> /mnt/server/processes.txt
	echo "\n" >> /mnt/server/processes.txt
	sudo ls -als /mnt/server
fi
}

echo $(date)
echo $(uptime)
echo "Logged In User:"
echo $(whoami)

gcc -w inc/led.c -o inc/obj/led
inc/obj/led

process_networking
current_config
rm_config

FILE_GIT=~/.ssh/id_ed25519.pub
DIR=/mnt/server
distro_type=$(cat /etc/*-release | grep DISTRIB_ID=Ubuntu)
raspberry_type=$(cat /etc/*-release | grep ID=raspbian)

if test -f "$FILE_GIT"; then
	git fetch
	git pull
    echo $distro_type
	if [[ $distro_type == "DISTRIB_ID=Ubuntu" || $raspberry_type == "ID=raspbian" ]]; then
		echo "Using apt packet manager to install packages!!"

			if cat ~/.bashrc | tr "," "\n" | grep -xqF "alias package='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y'"; then
				echo ""
			else
				echo "alias package='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y'" >> ~/.bashrc
				. ~/.bashrc
			fi
        sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
		xargs sudo apt-get install -y <packages/ubuntu_package.txt
		##xargs sudo pip install <packages/pip_list.txt
	fi


	if [ -d "$DIR" ];
	then
		echo "Directory exists, skipping server mount!!"
	else
		sudo mkdir /mnt/server
		. ~/.bashrc
	fi

    	if grep -Fxq "sudo sshfs -o allow_other,IdentityFile=$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server" ~/.bashrc; then
        	. ~/.bashrc
		echo "Exists"
    	else
		. ~/.bashrc
		echo $(sudo sshfs -o allow_other,IdentityFile=$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server)
       		echo "sudo sshfs -o allow_other,IdentityFile=$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server" >> ~/.bashrc
    	fi
	. ~/.bashrc

else
	sudo apt install git ssh
	echo "Creating SSH Key"
	ssh-keygen -t ed25519 -C lucasaponso@outlook.com
	eval "$(ssh-agent -s)"
	appending_config
	scp ~/.ssh/id_ed25519.pub root@172.105.180.73:/var/www/html/
	echo "Tell admin to create ssh key"
fi
current_config
rm_config

##git clone https://github.com/ClaireGuerin/bash-install-vscode.git 
##cd bash-install-vscode
##chmod 777 install_vscode.sh
##source install_vscode.sh
##cd ..
##rm -rf bash-install-vscode
##echo "Would you like to install GUI applications(Y/N)"
##read answer

##if [[ $answer == 'Y' ]];
##then
##	echo "Ok"
##	sudo apt update
##	sudo apt install software-properties-common apt-transport-https wget -y
##	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
##	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
##	sudo apt install code
##	code --version
##
##	sudo wget -O- https://download.sublimetext.com/sublimehq-pub.gpg | gpg –dearmor | sudo tee /usr/share/keyrings/sublimehq.gpg
##	echo ‘deb [signed-by=/usr/share/keyrings/sublimehq.gpg] https://download.sublimetext.com/ apt/stable/’ | sudo tee /etc/apt/sources.list.d/sublime-text.list
##	sudo apt update
##	sudo apt install sublime-text
##
##	sudo apt install software-properties-common apt-transport-https wget
##	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
##	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main"
##	sudo apt update
##	sudo apt install microsoft-edge-stable
##
##	sudo apt update
##	sudo apt install -y build-essential
##	sudo bash VMware-Workstation-Full-16.2.4-20089737.x86_64.bundle
##	sudo vmware-modconfig --console --install-all
##
##	sudo apt update
##	sudo add-apt-repository ppa:micahflee/ppa
##	sudo apt update
##	sudo apt install torbrowser-launcher
##else
##	echo "Ok, not installing GUI options"
##fi
. ~/.bashrc



echo "Would You Like to clone via ssh"
read answer

if [[ $answer == "Y" ]]; then
	git clone git@github.com:lucasaponso/UnixHelper.git ~
fi
