
# Makefiel setup
.PHONY: default all prepare
default: all
all: prepare install

# Makefile Config
include /etc/os-release
DOCKER_DIR := /mnt/wsl/shared-docker
VERSION := $(shell dpkg --status tzdata|grep Provides|cut -f2 -d'-')

prepare:
	sudo apt update
	curl -fsSL https://download.docker.com/linux/${ID}/gpg | sudo apt-key add -
	-sudo rm /etc/apt/sources.list.d/docker.list
	echo "deb [arch=amd64] https://download.docker.com/linux/${ID} ${VERSION} stable" | sudo tee /etc/apt/sources.list.d/docker.list
	sudo apt update

install:
	sudo apt install docker-ce docker-ce-cli containerd.io docker-compose
	sudo usermod -aG docker $$USER
	echo "%$$USER     ALL=(ALL) NOPASSWD: /usr/bin/dockerd" | sudo tee -a /etc/sudoers
	echo '# Start wsl2 docker daemon' >> ~/.bashrc
	echo 'RUNNING=`ps aux | grep dockerd | grep -v grep`' >> ~/.bashrc
	echo 'if [ -z "$$RUNNING" ]; then' >> ~/.bashrc
	echo '    sudo dockerd > /dev/null 2>&1 &' >> ~/.bashrc
	echo '    disown' >> ~/.bashrc
	echo 'fi' >> ~/.bashrc

