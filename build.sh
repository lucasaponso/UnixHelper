#!/usr/bin/env bash
distro_type=$(cat /etc/*-release | grep DISTRIB_ID=Ubuntu)
echo $distro_type
if [[ $distro_type == "DISTRIB_ID=Ubuntu" ]]; then
	 echo "Using apt packet manager to install packages!!"
	 echo "alias package='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y'" >> $HOME/.bashrc
     source $HOME/.bashrc
	 sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
     xargs sudo apt-get install -y <packages/ubuntu_package.txt
fi

DIR=/mnt/server/


if test -f "$DIR"; then

	echo "sudo sshfs -o allow_other,IdentityFile=$HOME/.ssh/id_rsa root@172.105.180.73:/var/www/html/ /mnt/server/" >> $HOME/.bashrc
	source $HOME/.bashrc
else
	sudo mkdir /mnt/server
	echo "sudo sshfs -o allow_other,IdentityFile=$HOME/.ssh/id_rsa root@172.105.180.73:/var/www/html/ /mnt/server/" >> $HOME/.bashrc
	source $HOME/.bashrc


read -p "Give me ur email!!!" email_addr
ssh-keygen -t ed25519 -C $email_addr
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
##echo "Await for admin's approval of key creation!!"