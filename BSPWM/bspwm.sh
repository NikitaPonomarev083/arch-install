sudo pacman -S bspwm sxhkd kitty nitrogen thunar firefox dmenu xorg xorg-xinit polybar

# LIGHTDM
#sudo pacman -S lightdm lightdm-gtk-greeter 

cp /etc/X11/xinit/xinitrc ~/.xinitc
echo -e "exec sxhkd & \nexec bspwm" >> ~/.xinitrc

mkdir -p ~/.config/{bspwm,sxhkd,polybar}

install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
cp /usr/share/doc/polybar/examples/config.ini ~/.config/polybar/config

chmod 775 ~/.config/bspwm/bspwmrc
chmod 775 ~/.config/sxhkd/sxhkdrc

#sudo systemctl enable lightdm