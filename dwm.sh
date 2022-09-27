sudo pacman -S --noconfirm xorg xorg-xinit kitty nitrogen pcmanfm dmenu

#sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter

cp /etc/X11/xinit/xinitrc ~/.xinitrc

mkdir ~/.{themes,icons,fonts}

git clone https://github.com/bakkeby/dwm-flexipatch

echo "exec dwm" >> ~/.xinitrc

#sudo systemctl enable lightdm
