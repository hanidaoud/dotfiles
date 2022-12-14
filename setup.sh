#!/usr/bin/bash

cd $( dirname -- "$0" )
DIR0=`pwd`
DIR1="$HOME"
PROG="bspwm sxhkd polybar kitty picom rofi"
PROG_NO_CONF="flameshot pulsemixer xorg-server xorg-xinit xorg-xbacklight xorg-xsetroot nitrogen sddm wget adwaita-icon-theme ntfs-3g unzip"

sudo pacman -Syy noto-fonts --noconfirm --needed --asdeps
sudo pacman -S $PROG $PROG_NO_CONF --noconfirm --needed

if [ -d "$DIR1/.config" ]
then
	mkdir -p $DIR1/.config_backups

	for i in $PROG
	do
		cp -vr $DIR1/.config/$i $DIR1/.config_backups
		rm -vrf $DIR1/.config/$i
	done
else
	mkdir $DIR1/.config
fi

nerd()
{
	if ! wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip"
	then
		nerd
	fi
}
nerd

fontello()
{
	if ! wget "https://drive.google.com/u/0/uc?id=1---jby1yN9iesH4S45JIGYEW4VBWtIWT&amp;export=download" -O fontello.zip
	then
		fontello
	fi
}
fontello

if [ ! -d "$DIR1/.fonts" ]
then
	mkdir "$DIR1/.fonts"
fi

cd "$DIR1/.fonts"
mkdir Hack && cd Hack
unzip -x $DIR0/Hack.zip
cd $DIR0
rm Hack.zip
unzip -x fontello.zip
cd "$DIR1/.fonts"
unzip -x $DIR0/fontello-029ace21.zip
cd $DIR0
rm fontello-029ace21.zip fontello.zip

fc-cache -vf


cp -vr $DIR0/dotfiles/* $DIR1/.config/

sudo systemctl enable sddm

echo -ne '
# Aliases
alias ls="ls --color=auto -alh"
alias logout="bspc quit"
' >> $DIR1/.bashrc

echo -ne '
# Aliases
alias ls="ls --color=auto -alh"
alias logout="bspc quit"
' >> $DIR1/.zshrc

if [ ! -d $DIR1/.icons ]
then
	mkdir $DIR1/.icons
else
	mkdir -p $DIR1/.icons/.backup
	cp $DIR1/.icons/index.theme $DIR1/.icons/.backup
	rm $DIR1/.icons/index.theme
fi

echo -ne '
[Icon Theme]
Inherits=Adwaita' >> $DIR1/.icons/index.theme

while true
do
	read -p ":: $(tput bold)Do you want to reboot now [y/N] $(tput sgr0)" yn
	case $yn in
		[Yy]* ) reboot;;
		[Nn]* ) break;;
		* ) break;;
	esac
done
