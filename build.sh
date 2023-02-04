#!/usr/bin/env bash

rm_config() {
echo -n "Would you like to delete all configs (Y/N)"
read delete_config 

if [[ $delete_config == "Y" ]]; then
	##Remove alias
	sed -i -e '/alias package=/d' ~/.bashrc
	##Remove mounting directory & command to link to server
	sudo rm -rf /mnt/server
	sed -i -e '/sudo sshfs/d' ~/.bashrc
	##Remove ssh key
	rm -rf ~/.ssh/id*
else
	echo "Ok, keeping current config"
fi
}

current_config() {
	sudo ls -als /mnt
	ls -als ~/.ssh
	echo ".bashrc configs:"
	cat ~/.bashrc | grep "alias package"
	echo ".bashrc configs:"
	cat ~/.bashrc | grep "sudo sshfs"
}

appending_config() {
	FILE=~/.ssh/config
	if test -f "$FILE"; then
		echo "Host * 
			AddKeysToAgent yes 
			IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config
	else
		touch ~/.ssh/config
		echo "Host * 
			AddKeysToAgent yes  
			IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config
	fi
}





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
				source ~/.bashrc
			fi
        sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
		xargs sudo apt-get install -y <packages/ubuntu_package.txt
		xargs sudo pip install <packages/pip_list.txt
	fi


	if [ -d "$DIR" ];
	then
		echo "Directory exists, skipping server mount!!"
	else
		sudo mkdir /mnt/server
		
	fi

    if grep -Fxq "sudo sshfs -o allow_other,IdentityFile=/$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server/" ~/.bashrc; then
        echo "Exists"
        source ~/.bashrc
    else
        echo "sudo sshfs -o allow_other,IdentityFile=/$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server/" >> ~/.bashrc
	    source ~/.bashrc
    fi

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






