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


read -p "Would you like to create a ssh key, p.s access to logs are unavailable if ssh key is not generated (Y/N):" sshkey

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

DIR=/mnt/server
if [ -d "$DIR" ];
then
	echo "Directory exists, skipping server mount!!"
	

else
	sudo mkdir /mnt/server
	sudo sshfs -o allow_other,IdentityFile=/$HOME/.ssh/id_ed25519 root@172.105.180.73:/var/www/html /mnt/server/
	
fi



##cd tortoise-tts
##pwd
##sudo pip3 install -U scipy
##sudo pip3 install transformers==4.19.0
##sudo pip3 install -r $HOME/UnixHelper/packages/requirements.txt
##sudo python3 setup.py install




##pip3 install requirements
##python3 setup.py install

