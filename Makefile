
# --- Makefile setup ----------------------------------------------------------
default: help
.PHONY: default help prepare dotfiles snippets homedir min key net dev txt \
	flux gui-tools essentials server developer worker desktop-min desktop-tools

# --- Makefile config ---------------------------------------------------------
APT_TRANSPORT       := apt-transport-https ca-certificates curl gnupg2 wget
APT_ESSENTIALS      := git vim sudo htop cowsay psmisc
APT_ARCHIVES        := zip unzip bzip2 dtrx
APT_BUILD           := gcc gdb build-essential
APT_NETWORK         := net-tools iptables tcpdump whois ssh nmap netcat dnsutils
APT_TEXTPROC        := textlive-full pandoc
APT_GUI_ESSENTIALS  := galculator gedit gedit-plugins numlockx arandr
APT_GUI_TERMINAL    := gnome-terminal xterm lxterminal tilda
APT_GUI_ICONS       := lxde-icon-theme gnome-extra-icons
APT_GUI_WEB_CLIENTS := firefox-esr thunderbird
APT_GUI_TXT_CLIENTS := evince gedit gedit-plugins
APT_GUI_MM_CLIENTS  := vlc
APT_DSK_X           := xorg xserver-xorg-video-nouveau xserver-xorg-video-vesa
APT_DSK_FLUXBOX     := fluxbox lightdm
APT_DSK_BARS        := wbar wbar-config conky wmctrl tint2
APT_DSK_THUNAR      := thunar thunar-data thunar-archive-plugin \
						thunar-media-tags-plugin thunar-volman \
						xfce4-goodies xfce4-places-plugin \
						thunar-gtkhash thunar-vcs-plugin file-roller

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

# --- HOME folder -------------------------------------------------------------
dotfiles:
	cp dotfiles/.vimrc ~
	cp dotfiles/.bashrc ~
	cp dotfiles/.gitconfig ~
snippets:
	mkdir -p ~/snippets
	cp snippets/* ~/snippets/
	chmod a+x ~/snippets/*
key:
	-ssh-keygen
homedir: dotfiles snippets key
	mkdir -p ~/scratch
	mkdir -p ~/repo
	mkdir -p ~/tools

# --- APT Installers ----------------------------------------------------------
min: 
	sudo apt install $(APT_TRANSPORT) $(APT_ESSENTIALS) $(APT_ARCHIVES) -y
net:
	sudo apt install $(APT_NETWORK) -y
dev:
	sudo apt install $(APT_BUILD) -y
txt:
	sudo apt install $(APT_BUILD) -y
flux:
	sudo apt install $(APT_DSK_X) $(APT_DSK_FLUXBOX) \
		$(APT_DSK_BARS) $(APT_DSK_THUNAR) -y
gui-tools:
	sudo apt install $(APT_GUI_ESSENTIALS) $(APT_GUI_TERMINAL) $(APT_GUI_ICONS) \
		$(APT_GUI_WEB_CLIENTS) $(APT_GUI_TXT_CLIENTS) $(APT_GUI_MM_CLIENTS) -y

# --- Meta-Targets ------------------------------------------------------------
essentials: min homedir
server: essentials net
developer: server dev
worker: developer txt
desktop-min: worker flux
desktop-tools: desktop-min gui-tools

