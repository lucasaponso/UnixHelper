#!/bin/bash
##uname -r
##sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -Y
##sudo rpi_update
##uname -r

wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.0.7.tar.xz
tar xvf linux-6.0.7.tar.xz
sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison
rm -rf linux-6.0.7.tar.xz
cd linux-6.0.7
cp -v /boot/config-$(uname -r) .config
make menuconfig
make
sudo make modules_install
sudo make install
sudo update-initramfs -c -k 6.0.7
sudo update-grub
sudo reboot
