#!/bin/bash

func_install() {
    if pacman -Qi $1 &> /dev/null; then
	tput setaf 2
  	echo "###############################################################"
  	echo "# The package " $1 " is already installed"
      	echo "###############################################################"
      	echo
	tput sgr0
    else
    	tput setaf 3
    	echo "###############################################################"
    	echo "# Installing package " $1
    	echo "###############################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

package_list=(
    acpid
    avahi
    cronie
    dhcpcd
    docker
    docker-compose
    networkmanager
    tlp
    ufw
)

service_list=(
    acpid
    avahi-daemon
    cronie
    dhcpcd
    docker
    NetworkManager
    tlp
    ufw
)

count=0

for name in "${package_list[@]}" ; do
    count=$[count+1]
    tput setaf 3;echo "Installing package nr. " $count " " $name;tput sgr0;
    func_install $name
done

for name in "${service_list[@]}" ; do
    tput setaf 4;echo "Enabling " $name;tput sgr0;
    systemctl enable $name
done

tput setaf 11;
echo "################################################################"
echo "# Services have been installed"
echo "################################################################"
echo;tput sgr0
