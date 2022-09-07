# Установка и настройка reflector'а
pacman -S reflector rsync curl
cp /etc/pacman.d/mirrorlist mirrorlist.bak
reflector -a 20 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy


pacman -S network-manager-applet nvidia nvidia-utils alsa-lib alsa-utils pulseaudio

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

mkdir ~/.{themes,icons,fonts}