sudo pacman -S --noconfirm xorg xorg-xinit kitty nitrogen ranger firefox dmenu

#sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter

cp /etc/X11/xinit/xinitrc ~/.xinitrc

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

mkdir ~/.{themes,icons,fonts}

git clone https://github.com/bakkeby/dwm-flexipatch

echo "exec dwm" >> ~/.xinitrc

#sudo systemctl enable lightdm
