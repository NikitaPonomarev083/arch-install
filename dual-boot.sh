#!/bin/bash

ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

#echo "LANG=ru_RU.UTF-8" >> /etc/locale.conf
#echo "KEYMAP=ru" >> /etc/vconsole.conf
#echo "FONT=cyr-sun16" >> /etc/vconsole.conf

echo "arch" >> /etc/hostname
echo "127.0.0.1    localhost" >> /etc/hosts
echo "::1          localhost" >> /etc/hosts
echo "127.0.1.1    arch.localdomain    arch" >> /etc/hosts
echo root:passwd | chpasswd

pacman -S nano sudo grub efibootmgr networkmanager dosfstools mtools ntfs-3g os-prober ntfs-3g

mkdir /boot/efi
mount /dev/_windows_efi_system_partition_ /boot/efi
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable firewalld
systemctl enable fstrim.timer

useradd -m user
echo user:passwd | chpasswd
usermod -aG audio,video,storage user

echo "user ALL=(ALL) ALL" >> /etc/sudoers.d/user

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




