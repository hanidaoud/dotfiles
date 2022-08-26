#!/usr/bin/bash

DIR0=`pwd`
DIR1="$HOME"
PROG="bspwm sxhkd polybar kitty picom rofi"
PROG_NO_CONF="flameshot pulsemixer xbacklight nitrogen xorg-server xorg-xinit sddm"

sudo pacman -Syy
sudo pacman -S $PROG $PROG_NO_CONF

mkdir $DIR1/.config_backups

for i in $PROG
do
	cp -vr $DIR1/.config/$i $DIR1/.config_backups
	rm -vrf $DIR1/.config/$i
done

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
