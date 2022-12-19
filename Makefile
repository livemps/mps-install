

# --- Makefile setup ----------------------------------------------------------
default: all
all: desktop-full
.PHONY: all default help prepare dotfiles snippets homedir fonts min key net dev txt \
	flux gui-tools essentials server developer worker desktop-min desktop-full

# --- Makefile config (APT) ---------------------------------------------------
APT_TRANSPORT       := apt-transport-https ca-certificates curl gnupg2 wget
APT_ESSENTIALS      := git vim neovim sudo htop psmisc tree
APT_BULLSHIT        := cowsay fortune fortunes-de fortunes-off cmatrix
APT_ARCHIVES        := zip unzip bzip2 dtrx
APT_BUILD           := gcc gdb build-essential
APT_NETWORK         := net-tools iptables tcpdump iw whois ssh nmap netcat dnsutils
APT_TEXTPROC        := textlive-full pandoc
APT_GUI_ESSENTIALS  := galculator gedit gedit-plugins numlockx arandr
APT_GUI_TERMINAL    := gnome-terminal xterm lxterminal
APT_GUI_ICONS       := lxde-icon-theme gnome-extra-icons
APT_GUI_WEB_CLIENTS := firefox-esr thunderbird
APT_GUI_TXT_CLIENTS := evince gedit gedit-plugins
APT_GUI_MM_CLIENTS  := vlc
APT_DSK_X           := xorg xserver-xorg-video-nouveau xserver-xorg-video-vesa
#APT_DSK_FLUXBOX     := fluxbox lightdm
#APT_DSK_BARS        := wbar wbar-config conky wmctrl tint2
APT_DSK_THUNAR      := thunar thunar-data thunar-archive-plugin \
						thunar-media-tags-plugin thunar-volman \
						xfce4-goodies xfce4-places-plugin \
						thunar-gtkhash thunar-vcs-plugin file-roller
APT_DSK_I3          := lightdm i3 compton rxvt-unicode rofi arc-theme
APT_DSK_X           := xbacklight
APT_DSK_GNOME_TOOLS := gnome-system-monitor python3-netifaces gitsome 
APT_PYTHON          := python3-pygit2 python3-netifaces 

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
	@echo "     desktop-min   : worker       + fluxbox"
	@echo "     desktop-tools : desktop-min  + gui tools"
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
		curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb ; \
		sudo dpkg -i nvim-linux64.deb ; \
		sudo rm nvim-linux64.deb ; \
	fi
# --- I3  ---------------------------------------------------------------------
wallpaper:
	cp -r dotfiles/.config/images/ ~/.config/

i3-desktop:
	cp -r dotfiles/.config/i3/ ~/.config/
	cp -r dotfiles/.config/rofi/ ~/.config/
	cp -r dotfiles/.config/kitty/ ~/.config/
	cp -r dotfiles/.config/compton.conf ~/.config/
	sudo apt install $(APT_DSK_I3) $(APT_DSK_X) $(APT_DSK_GNOME_TOOLS) $(APT_PYTHON)

# --- HOME folder -------------------------------------------------------------
fonts:
	-mkdir ~/.fonts
	cp fonts/* ~/.fonts/

dotfiles: 
	cp dotfiles/.vimrc ~
	cp dotfiles/.bashrc ~
	cp dotfiles/.gitconfig ~
	cp dotfiles/.config/mimeapps.list ~/.config/
	cp -r dotfiles/.config/neofetch/ ~/.config/
	cp -r dotfiles/.config/nvim/ ~/.config/

snippets:
	mkdir -p ~/snippets
	cp snippets/* ~/snippets/
	chmod a+x ~/snippets/*

key:
	@if [ ! -f ~/.ssh/id_rsa.pub ] ; then \
	  ssh-keygen ; \
	fi

homedir: fonts dotfiles snippets key
	xdg-user-dirs-update
	mkdir -p ~/scratch
	mkdir -p ~/repo
	mkdir -p ~/tools

# --- APT Installers ----------------------------------------------------------
min: neovim 
	sudo apt install  $(APT_ESSENTIALS) $(APT_BULLSHIT) \
		$(APT_ARCHIVES) $(APT_TRANSPORT) -y
net:
	sudo apt install $(APT_NETWORK) -y
dev:
	sudo apt install $(APT_BUILD) -y
txt:
	sudo apt install $(APT_BUILD) -y
gui-tools:
	sudo apt install $(APT_GUI_ESSENTIALS) $(APT_GUI_TERMINAL) $(APT_GUI_ICONS) \
		$(APT_GUI_WEB_CLIENTS) $(APT_GUI_TXT_CLIENTS) $(APT_GUI_MM_CLIENTS) -y

# --- Meta-Targets ------------------------------------------------------------
essentials: min homedir
server: essentials net
developer: server dev
worker: developer txt
desktop-min: worker i3-desktop
desktop-full: desktop-min gui-tools

