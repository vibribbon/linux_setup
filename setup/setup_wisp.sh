#!/bin/bash

# ----------------------------------------------------------------------
### NOTES ###
# Debian setup
# Modular file - comment/uncomment as required for your setup.
# Install your Debian setup of choice first - use a STABLE version not testing (no security updates)
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### CONFIGURE CORE DEBIAN REPOS ###
# this file contains all the non-open repos and backports for debian 11
cp $HOME/linux_setup/resources/apt/sources.list /etc/apt/
apt-get update
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### SETUP SUDO ###
# Install sudo and add user to sudoers / allow shutdown without password
apt-get install -y sudo
echo 'vibri   ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo 'vibri ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown' >> /etc/sudoers
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### SETUP ENVIRONMENT ###
# add the path environment for sbin to ease typing
echo 'export PATH="/sbin:$PATH"' >> $HOME/.profile
# setup bashrc
cp $HOME/linux_setup/resources/.bashrc $HOME/.bashrc
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### PACKAGE MANAGERS & SOURCE CODE REPOS ###
# Setup flatpak for cutting edge packages
apt-get install -y flatpak
# Add flathub repo to flatpak.
 flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Setup git source code repo tool
apt-get install -y git # code project management
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### INSTALL & SETUP TERMINAL APPS ###
apt-get install -y p7zip-full p7zip-rar # full 7zip package
apt-get install -y ranger # cli file manager
apt-get install -y tree # folder tree mapping
apt-get install -y ncdu # disk usage analyser
apt-get install -y ufw # simple firewall
apt-get install -y aria2 # wget alternative download manager
apt-get install -y curl # flexible download manager
apt-get install -y iftop # internet monitor
apt-get install -y nethogs # list apps using the most bandwidth
apt-get install -y ssh # remote terminal
apt-get install -y htop # system performance
apt-get install -y powertop # system energy usage
apt-get install -y rsync # backup and folder sync tool
apt-get install -y cups # printer server
apt-get install -y ncal # basic calendar
apt-get install -y slock # simple screen locker
apt-get install -y icdiff # colorised file compare (diff)

apt-get install -y nano # cli text editor (often installed by default)
# Setup nanorc
 cp $HOME/linux_setup/resources/nano/nanorc $HOME/.nanorc

# apt-get install -y vim # advanced cli text editor
# Setup vimrc
# cp $HOME/linux_setup/resources/.vimrc $HOME/.vimrc

# useful optional extras
# apt-get install -y bc # basic interactive calculator
# apt-get install -y mc # midnight commander file manager
# apt-get install -y nmap # port mapper for diagnostics
# apt-get install -y traceroute # internet traceroute for diagnostics
# apt-get install -y xfce4-terminal # alternative xfce terminal
# apt-get install -y moc # terminal music player
# apt-get install -y w3m # terminal web browser
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### SCRIPTS ###
# setup local scripts folder and make executable (requires git)
git clone https://github.com/vibribbon/scripts
chown -R root $HOME/scripts/
chmod -R 755 $HOME/scripts/

# copy the files and remove their extension
for i in $HOME/scripts/*.sh
do
     cp -a $i ${i%%.sh}
done

# Cleanup and move to /usr/local/bin for systemwide usage
rm $HOME/scripts/*.sh
rm $HOME/scripts/README.md $HOME/scripts/LICENSE
cp $HOME/scripts/* /usr/local/bin/
rm -r $HOME/scripts/
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
# vv GUI SYSTEMS ONLY vv

# ----------------------------------------------------------------------
### DRIVERS & FIRMWARE ###
# non-free optional firmware if required for specific hardware
# apt-get install -y firmware-linux firmware-linux-nonfree

# AMD Graphics latest drivers - ONLY INSTALL ONE VERSION
# Standard desktop
apt-get install -y firmware-amd-graphics linux-image-amd64
# More modern drivers for gaming systems only
# apt-get install -y firmware-amd-graphics linux-image-amd64 -t bullseye-backports
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### INSTALL BASIC OS GUI ###
# Install xorg display manager, openbox window manager, obconf utility
apt-get install -y xorg openbox obconf
 mkdir $HOME/.config
 cp -r /etc/xdg/openbox $HOME/.config
 cp -r $HOME/linux_setup/resources/openbox $HOME/.config
# set resolution to 1440p
 echo 'exec xrandr --output HDMI-A-0 --mode 2560x1440 &' >> $HOME/.config/openbox/autostart
 echo 'exec xrandr --output HDMI-1 --mode 2560x1440 &' >> $HOME/.config/openbox/autostart

# if you want a lightweight login manager & configs
# apt-get install -y slim
#  cp $HOME/linux_setup/resources/slim/slim.conf /etc
#  cp $HOME/linux_setup/resources/slim/background.jpg /usr/share/slim/themes/default

# Optional conventional desktop additions
# apt-get install -y tint2 # task bar
# apt-get install -y ivman # mounts volumes
# apt-get install -y parcellite # clipboard manager
# apt-get install -y nitrogen # wallpaper manager if you dont like feh
# apt-get install -y plank # osx style launcher
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### INSTALL GUI APPS ###
apt-get install -y pcmanfm # file manager
 cp -r $HOME/linux_setup/resources/pcmanfm/default $HOME/.config/pcmanfm/default
apt-get install -y feh # frameless image viewer
apt-get install -y mupdf # pdf viewer
apt-get install -y geany # text editor IDE
 cp -r $HOME/linux_setup/resources/geany/ $HOME/.config/
apt-get install -y firefox-esr # firefox browser
apt-get install -y libreoffice-writer # document writing
apt-get install -y libreoffice-impress # slideshow design
apt-get install -y libreoffice-calc # spreadsheet creation
apt-get install -y scribus # desktop publishing layout creator
# apt-get install -y calibre # ebook mangement
# apt-get install -y pandoc # document conversion
# apt-get install -y r-base # r development
apt-get install -y gimp # photo editor
# apt-get install -y inkscape # technical drawing package
# apt-get install -y shotcut # non-linear video editor
# apt-get install -y handbrake # audio video encoder
# apt-get install -y audacity # non-linear audio editor
# apt-get install -y blender # rendering and 3d printing
# apt-get install -y krita # painting package
# apt-get install -y darktable # image viewer and organiser

### UTILITIES ###
apt-get install -y pulseaudio pavucontrol # sound settings and volume control
apt-get install -y xsensors # system temperature monitoring
apt-get install -y gnome-disk-utility # partition manager
apt-get install -y bleachbit # system cleanup
apt-get install -y youtube-dl # youtube downloader & media player
apt-get install -y xarchiver # compression front end
apt-get install -y arandr # monitor resolution set
apt-get install -y gufw # ufw firewall front end (if using ufw)
apt-get install -y clamav clamtk # virus scanner and interface

### FLATPAK APPS ###
sudo flatpak install flatseal # security for flatpak containers
# sudo flatpak install rstudio # front end dev envirnment for r

### COMMON OPTIONAL ALTERNATIVES ###
# apt-get install -y chromium # chromium browser
# apt-get install -y mirage # image viewer
# apt-get install -y vlc # media player
# apt-get install -y notepadqq # text editor api (notepad++ port)
# apt-get install -y synaptic # visual package manager
# apt-get install -y gparted # partition manager
# apt-get install -y thunar # file manager
# apt-get install -y transmission # download manager
# apt-get install -y digikam # image viewer and organiser
# apt-get install -y conky # system monitor
# apt-get install -y stacer # system monitor
# apt-get install -y galculator # calculator
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### PROGRAMMING ENVIROMNENTS ###
apt-get install -y python3 python3-pip # install python
# apt-get install -y build-essential ccache # install c/c++ compiler
# apt-get install -y mariadb-server
#  sudo mysql_secure_installation # config for mariadb
# apt-get install -y apache2 #www server
# apt-get install -y php libapache2-mod-php pch-cli php-mysql php-zip php-curl php-xml #php and addons
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### GAMING SYSTEMS ONLY ###
# install steam (requires the i386 architecture)
# dpkg --add-architecture i386
# apt-get update
# apt-get install -y steam

# Install Lutris
# sudo flatpak install lutris
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### LOGIN OPTIONS ###
# Auto start GUI (startx) once correct password entered
echo '' >> $HOME/.profile
echo '# run startx at login (/dev/tty1 is the default tty terminal)' >> $HOME/.profile
echo '[ "$(tty)" = "/dev/tty1" ] && exec startx' >> $HOME/.profile

# Auto enter username at logon (password still required)
mkdir /etc/systemd/system/getty@tty1.service.d
cp $HOME/linux_setup/resources/agetty/override.conf /etc/systemd/system/getty@tty1.service.d/

# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
### CONVERT FOLDER OWNERSHIP ###
# change to the required username
chown -R vibri $HOME
# ----------------------------------------------------------------------

