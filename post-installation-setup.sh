pacman -S reflector rsync curl network-manager-applet nvidia nvidia-utils nvidia-settings alsa-lib alsa-utils pulseaudio fakeroot base-devel

git clone https://aur.archlinux.org/yay.git ~lain/
cd ~lain/yay
makepkg -si 

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

mkdir ~user/.{themes,icons,fonts}