sudo pacman -S bspwm sxhkd kitty nitrogen thunar firefox dmenu xorg xorg-xinit lightdm lightdm-gtk-greeter 

echo -e "exec sxhkd & \nexec bspwm" >> .xinitrc

mkdir -p ~/.config/{bspwm,sxhkd}
#touch .config/bspwm/bspwmrc
#cp ./translated-cfgs/bspwmrc ~/.config/bspwm/
#sudo chmod 775 ~/.config/bspwm/bspwmrc
#cp ./translated-cfgs/sxhkdrc ~/.config/sxhkd/
#sudo chmod 775 ~/.config/sxhkd/sxhkdrc

cat > ~/.config/gtk-3.0/gtk.css << "EOF"
.window-frame, .window-frame:backdrop {
    box-shadow: 0 0 0 black;
    border-style: none;
    margin: 0;
    border-radius: 0;
}
.titlebar {
    border-radius: 0;
}
EOF

echo -e "\nxsetroot -cursor_name left_ptr &" >> .config/bspwm/bspwmrc

sudo systemctl enable lightdm