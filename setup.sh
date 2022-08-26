#!/usr/bin/bash

DIR0=`pwd`
DIR1="$HOME"
PROG="bspwm sxhkd polybar kitty picom rofi"
PROG_NO_CONF="flameshot pulsemixer xorg-xbacklight nitrogen xorg-server xorg-xinit sddm wget adwaita-icon-theme ntfs-3g"

sudo pacman -Syy noto-fonts --noconfirm --needed --asdeps
sudo pacman -S $PROG $PROG_NO_CONF --noconfirm --needed

if [ -d "$DIR1/.config" ]
then
	mkdir $DIR1/.config_backups

	for i in $PROG
	do
		cp -vr $DIR1/.config/$i $DIR1/.config_backups
		rm -vrf $DIR1/.config/$i
	done
else
	mkdir $DIR1/.config
fi

dload()
{
	if ! wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip"
	then
		dload
	fi
}
dload

if [ ! -d "$DIR1/.fonts" ]
then
	mkdir "$DIR1/.fonts"
fi

cd "$DIR1/.fonts"
mkdir Hack && cd Hack
unzip -x $DIR0/Hack.zip
cd $DIR0
rm Hack.zip

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

echo "Xcursor.theme: Adwaita" >> $DIR1/.Xresources

while true
do
	read -p "Do you want to reboot now [y/N]: " yn
	case $yn in
		[Yy]* ) reboot;;
		[Nn]* ) break;;
		* ) break;;
	esac
done
