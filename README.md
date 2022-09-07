# Установка Arch Linux
- links:
	- [arcwiki](https://wiki.archlinux.org/title/Installation_guide)

## Проверка соединения
1. `ping archlinux.org`

## Включение синхронизации времени
1. `timedatectl status`
2. `timedatectl set-ntp true`
4. `ls /sys/firmware/efi/efivars`

## Разметка диска
1. `lsblk` или `fdisk -l` для просмотра существующей ФС.
2. `cfdisk` - команда для создания ФС.
```
Пример разметки:
- **EFI раздел** - 350M, EFI System (для установки единственной системой)
- **Раздел подкачки** - 4G, Linix swap
- **/** - все остальное свободное место, Linux filesystem
```

## Создание ФС
1. EFI - `mkfs.fat -F32 /dev/_efi_system_partition_`
2. `/` - `mkfs.ext4 /dev/_root_partition_`
3. Раздел подкачки - `mkswap /dev/_swap_partition_` 

## Монтирование разделов
1. `/` - `mount /dev/_root_partition_ /mnt`
2. Раздел подкачки - `swapon /dev/_swap_partition_`
3. EFI - `mount --mkdir /dev/_efi_system_partition_ /mnt/boot`

## Установка основных пакетов с помощью утилиты pacstrap
1. `pacstrap -i /mnt base linux linux-firmware intel-ucode nano git`

## Создание fstab для автоматического монтирования дисков при загрузке
1. `genfstab -U /mnt >> /mnt/etc/fstab`

## Установка дополнительных пакетов и настройка через chroot
1. `arch-chroot /mnt`
2. `pacman -S networkmanager nano sudo network-manager-applet`
3. `systectl enable NetworkManager`

### Выбор таймзоны
1. `ln -sf /usr/share/zoneinfo/Asia/Krasnoyarsk /etc/localtime`
2. `hwclock --systohc` 
3. `date` для проверки времени

### Настройка локалей и раскладки клавиатуры

**Способ 1:**
1. `nano /etc/locale.gen`
2. Откоментировать строки `еn_US.UTF-8 UTF-8` и `ru_RU.UTF-8 UTF-8`

**Способ 2:**
1. `echo "еn_US.UTF-8 UTF-8" >> /etc/locale.gen`
2. `echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen`

3. `locale-gen`
4. `echo "LANG=ru_RU.UTF-8" > /etc/locale.conf`
5. `echo "KEYMAP=ru" > /etc/vconsole.conf`
6. `echo "FONT=cyr-sun16" >> /etc/vconsole.conf`

### Создание hostname и hosts
1. `nano /etc/hostname` - записать имя компьютера 
2. `nano /etc/hosts` 
3. Записать туда:
```bash
127.0.0.1    localhost # 4 пробела
::1          localhost # 10 пробелов
127.0.1.1    ИмяПК.localdomain    ИмяПК # 4 пробела
```

### Создание пользователей и их паролей
1. `passwd` - пароль для root'а
2. `useradd -m -G wheel,audio,video,storage -s /bin/bash имя_пользователя`
3. `passwd имя_пользователя` - задание пароля для нового пользователя
4. `EDITOR=nano visudo`
	1. Откоментировать строчку с `%wheel ALL=(ALL) ALL`
	2. Или добавить пользователя в формате `Имя_пользователя ALL=(ALL) ALL`

### Создание grubinstall
**Установка единственной системой:**
1. `pacman -S grub efibootmgr`
2. `mkdir /boot/efi`
3. `mount /dev/_efi_system_partition_ /boot/efi`
4. `grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable`
5. `grub-mkconfig -o /boot/grub/grub.cfg`

**Dual boot:**
1. `mkdir /boot/efi`
2. `mount /dev/_windows_efi_system_partition_ /boot/efi`
3. `pacman -S grub efibootmgr dosfstools mtools`

**Вариант 1:**
4. `nano /etc/default/grub`
откоментить строку \#GRUB_DISABLE_OS_PROBER=false
5. `pacman -S os-prober`
6. `grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck`
7. `grub-mkconfig -o /boot/grub/grub.cfg`

**Вариант 2:**
4. `sudo nano /etc/grub.d/40_custom`
Вписать:
```bash
submenu "Windows 10" {
 regexp -s root '\((.+)\)' "$cmdpath"
 chainloader /EFI/Microsoft/Boot/bootmgfw.efi
}
```

5. `grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck`
6. `grub-mkconfig -o /boot/grub/grub.cfg`

## Reboot и тест
1. `exit`
2. `umount -R /mnt`
3. `reboot`

# Настройка Arch после установки

### Настройка reflector

Список зеркал находится в /etc/pacman.d/mirrorlist
Настройки pacman'а находятся в /etc/pacman.conf

`$ sudo pacman -S reflector rsync curl`
`$ sudo cp /etc/pacman.d/mirrorlist mirrorlist.bak`
`$ sudo reflector -a 20 --sort rate --save /etc/pacman.d/mirrorlist`
`$ sudo pacman -Syy`
`$ systemctl enable reflector.timer`

`$ cat /etc/xdg/reflector/reflector.conf` для просмотра отсортированных зеркал

### Настройка firewalld
`$ sudo pacman –S firewalld`
`$ systemctl enable firewalld`
`$ sudo firewall-cmd --add-port=1025-65535/tcp --permanent`
`$ sudo firewall-cmd --add-port=1025-65535/udp --permanent`
`$ sudo firewall-cmd --reload`

### Установка Xorg
`$ sudo pacman –S xorg xorg-xinit`

### Установка драйверов Nvdia
`$ sudo pacman -S nvidia nvidia-utils nvidia-settings`
`$ sudo nano /etc/mkinitcpio.conf`
Добавить MODULES=(nvidia)
`$ sudo mkinitcpio -P`
`$ sudo grub-mkconfig -o /boot/grub/grub.cfg`

#### pacman hook

Для того, чтобы не забывать обновлять initramfs после обновления nvidia, вы можете использовать pacman hook следующим образом:

`$ sudo nano /etc/pacman.d/hooks/nvidia.hook`
```bash
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux

# Измените "linux" в строках Target и Exec, если вы используете другое ядро

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'

#Пропишите в `Target` тот пакет, который вы установили в шагах выше (то есть `nvidia`, `nvidia-dkms`,`nvidia-lts` или `nvidia-ck-_что-нибудь_`).
```

### Установка DE

#### Gnome: 
`$ pacman –S gnome gdm ttf-dejavu gnome-extra `
`$ sudo systemctl enable gdm`
`$ reboot`

#### KDE Plasma
`$ pacman –S plasma kde-applications`

Терминал, файловый менеджер и менеджер настроек KDE:
`$ pacman –S konsole dolphin systemsettings `
`$ sudo systemctl enable sddm ` или `systemctl enable sddm.service`
`$ reboot `

#### XFCE:
`$ pacman –S xfce4 sddm xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings arc-gtk-theme arc-icon-theme`

Терминал, файловый менеджер и менеджер настроек XFCE:
`$ pacman –S xfce4-terminal thunar xfce4-settings`
`$ sudo systemctl enable sddm `
`$ reboot`

#### Отключение синхронизации времени на Windows 10:
```
Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_QWORD /d 1

sc config w32time start=disabled
```