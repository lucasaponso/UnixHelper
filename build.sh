#!/usr/bin/env bash
FILE_GIT=~/.ssh/id_ed25519

if test -f "$FILE_GIT"; then
	
	distro_type=$(cat /etc/*-release | grep DISTRIB_ID=Ubuntu)
	echo $distro_type
	if [[ $distro_type == "DISTRIB_ID=Ubuntu" ]]; then
		echo "Using apt packet manager to install packages!!"

			if cat ~/.bashrc | tr "," "\n" | grep -xqF "alias package='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y'"; then
				echo -e "Exists"
			else
				echo "alias package='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y'" >> ~/.bashrc
				source ~/.bashrc
			fi

		sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
		xargs sudo apt-get install -y <packages/ubuntu_package.txt
		##xargs sudo pip install <packages/pip_list.txt
	fi


    if grep -Fxq "sudo sshfs -o allow_other,IdentityFile=/$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server/" ~/.bashrc; then
        echo "Exists"
    else
        echo "sudo sshfs -o allow_other,IdentityFile=/$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server/" >> ~/.bashrc
	    source ~/.bashrc
    fi

	DIR=/mnt/server
	if [ -d "$DIR" ];
	then
		echo "Directory exists, skipping server mount!!"
	else
		sudo mkdir /mnt/server
		sudo sshfs -o allow_other,IdentityFile=/$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server/
		echo "sudo sshfs -o allow_other,IdentityFile=/$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server/" >> ~/.bashrc
		
	fi
else
	sudo apt install git ssh scp
	echo "Creating SSH Key"
	ssh-keygen -t ed25519 -C lucasaponso@outlook.com
	eval "$(ssh-agent -s)"


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
	
	scp ~/.ssh/id_ed25519 root@172.105.180.73:/var/www/html/
	echo "Tell admin to create ssh key"
fi