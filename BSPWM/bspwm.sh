sudo pacman -S xorg xorg-xinit bspwm sxhkd kitty nitrogen thunar kwrite firefox lightdm lightdm-gtk-greeter

sudo systemctl enable lightdm

cat > /etc/X11/xorg.conf.d/00-keyboard.conf << "EOF"
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "us,ru"
    Option "XkbModel" "pc105"
    Option "XkbOptions" "grp:alt_shift_toggle"
EndSection
EOF

echo -e "exec sxhkd & \nexec bspwm" >> .xinitrc

mkdir -p ~/.config/{bspwm,sxhkd}
#touch .config/bspwm/bspwmrc
cp ./translated-cfgs/bspwmrc ~/.config/bspwm/
sudo chmod 775 ~/.config/bspwm/bspwmrc
cp ./translated-cfgs/sxhkdrc ~/.config/sxhkd/
sudo chmod 775 ~/.config/sxhkd/sxhkdrc

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