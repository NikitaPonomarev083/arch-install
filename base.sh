#!/bin/bash

user=
hostname=
root_passwd=
passwd=
#efi_system_partition=sda1
#windows_efi_system_partition=sda1
Region=
City=

### TIME AND LOCALES ###
ln -sf /usr/share/zoneinfo/$Region/$City /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

### LANGUAGE SETUP ###
# echo "LANG=ru_RU.UTF-8" >> /etc/locale.conf
# echo "KEYMAP=ru" >> /etc/vconsole.conf
# echo "FONT=cyr-sun16" >> /etc/vconsole.conf

###  HOSTNAME  HOSTS ###
echo "$hostname" >> /etc/hostname
echo "127.0.0.1    localhost" >> /etc/hosts
echo "::1          localhost" >> /etc/hosts
echo "127.0.1.1    $hostname.localdomain    $hostname" >> /etc/hosts
echo root:$root_passwd | chpasswd


### PACKAGES ###
# general
pacman -S sudo grub efibootmgr networkmanager firewalld

# packages for vm
# pacman -S xdg-utils xdg-user-dirs virtualbox-guest-utils 

# for dualboot
# pacman -S mtools dosfstools os-prober ntfs-3g

### GRUB ###
mkdir /boot/efi
mount /dev/$efi_system_partition /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

### GRUB FOR DUALBOOT ###
# mkdir -p /boot/efi
# mount /dev/$windows_efi_system_partition /boot/efi
# echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
# grub-mkconfig -o /boot/grub/grub.cfg


### SERVICES ###
systemctl enable NetworkManager
systemctl enable firewalld
systemctl enable fstrim.timer

### NEW USER AND SUDO ###
useradd -m $user
echo $user:$passwd | chpasswd
usermod -aG audio,video,storage $user

echo "$user ALL=(ALL) ALL" >> /etc/sudoers.d/$user

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




