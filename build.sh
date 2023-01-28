#!/usr/bin/env bash
distro_type=$(cat /etc/*-release | grep DISTRIB_ID=Ubuntu)
echo $distro_type
if [[ $distro_type == "DISTRIB_ID=Ubuntu" ]]; then
	 echo "Using apt packet manager to install packages!!"
	 echo "alias package='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y'" >> $HOME/.bashrc
     source ~/.bashrc
	 sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
     xargs sudo apt-get install -y <packages/ubuntu_package.txt
	 xargs sudo pip install <packages/pip_list.txt
fi


read -p "Would you like to create a ssh key (Y/N):" sshkey

if [[ $sshkey == 'Y' || $sshkey == 'y' ]]; then
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
fi

git fetch
git pull
