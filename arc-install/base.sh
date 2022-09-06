#!/bin/bash

ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

echo "LANG=ru_RU.UTF-8" >> /etc/locale.conf
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf

echo "arch" >> /etc/hostname
echo "127.0.0.1    localhost" >> /etc/hosts
echo "::1          localhost" >> /etc/hosts
echo "127.0.1.1    arch.localdomain    arch" >> /etc/hosts
echo root:passwd | chpasswd

pacman -S reflector rsync curl
cp /etc/pacman.d/mirrorlist mirrorlist.bak
reflector -a 20 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

pacman -S nano sudo grub efibootmgr networkmanager firewalld nvidia nvidia-utils alsa-lib alsa-utils pulseaudio

mkdir /boot/efi
mount /dev/_efi_system_partition_ /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable --now firewalld

firewall-cmd --add-port=1025-65535/tcp --permanent
firewall-cmd --add-port=1025-65535/udp --permanent
firewall-cmd --reload

useradd -m user
echo user:passwd | chpasswd
usermod -aG audio,video,storage user

echo "user ALL=(ALL) ALL" >> /etc/sudoers.d/user

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




