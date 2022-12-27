# --- Makefile setup ----------------------------------------------------------
default: essentials
all: worker
.PHONY: all default help prepare neovim fonts dotfiles snippets homedir \
	bs min net dev txt essentials server developer worker
# --- Makefile config (APT) ---------------------------------------------------
APT_TRANSPORT       := apt-transport-https ca-certificates curl gnupg2 wget
APT_ESSENTIALS      := git vim sudo htop psmisc tree neofetch
APT_BULLSHIT        := cowsay fortune fortunes-de fortunes-off cmatrix
APT_ARCHIVES        := zip unzip bzip2 dtrx
APT_BUILD           := gcc gdb build-essential
APT_NETWORK         := net-tools iptables tcpdump iw ssh nmap netcat dnsutils
APT_TEXTPROC        := textlive-full pandoc
# --- Makefile config (VIM) ---------------------------------------------------
VIMPLUG				:= ~/.vim/autoload/plug.vim
NVIMPLUG			:= ~/.local/share/nvim/site/autoload/plug.vim 
# --- Help --------------------------------------------------------------------
help:
	@echo "Usage: make TARGET"
	@echo ""
	@echo "  Targets:"
	@echo "     essentials    : Bare minimum"
	@echo "     server        : essentials   + network tools"
	@echo "     developer     : server       + build essentials"
	@echo "     worker        : developer    + text processing"
	@echo ""
# --- Update ------------------------------------------------------------------
prepare:
	sudo apt update -y && sudo apt upgrade -y

# --- Vim Plugins -------------------------------------------------------------
$(VIMPLUG):
	-curl -fLo $(VIMPLUG) --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$(NVIMPLUG):
	-mkdir ~/.config/nvim
	-sh -c 'curl -fLo $(NVIMPLUG) --create-dirs \
       		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
neovim: $(VIMPLUG) $(NVIMPLUG)
	@if [ ! -f /usr/bin/nvim ] ; then \
		sudo apt remove --purge neovim ; \
		sudo apt autoremove ; \
		curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb ; \
		sudo dpkg -i nvim-linux64.deb ; \
		sudo rm nvim-linux64.deb ; \
	fi
# --- HOME folder -------------------------------------------------------------
fonts:
	#-mkdir ~/.fonts
	-mkdir -p ~/.local/share/fonts
	#cp -r fonts/* ~/.fonts/
	cp -r fonts/* ~/.local/share/fonts
dotfiles: 
	cp dotfiles/.vimrc ~
	cp dotfiles/.bashrc ~
	cp dotfiles/.gitconfig ~
	cp -r dotfiles/.config/neofetch/ ~/.config/
	cp -r dotfiles/.config/nvim/ ~/.config/
snippets:
	mkdir -p ~/snippets
	cp snippets/* ~/snippets/
	chmod a+x ~/snippets/*
~/.ssh/id_rsa.pub:
	ssh-keygen ;
homedir: fonts dotfiles snippets ~/.ssh/id_rsa.pub
	mkdir -p ~/scratch
	mkdir -p ~/repo
	mkdir -p ~/tools
# --- APT Installers ----------------------------------------------------------
bs:
	sudo apt install  $(APT_BULLSHIT) -y
min:
	sudo apt install  $(APT_ESSENTIALS) $(APT_ARCHIVES) $(APT_TRANSPORT) -y
net:
	sudo apt install $(APT_NETWORK) -y
dev:
	sudo apt install $(APT_BUILD) -y
txt:
	sudo apt install $(APT_BUILD) -y
# --- Meta-Targets ------------------------------------------------------------
essentials: min homedir neovim bs
server: essentials net
developer: server dev
worker: developer txt

