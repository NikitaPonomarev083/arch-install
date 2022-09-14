sudo pacman -S xorg xorg-xinit kitty nitrogen ranger firefox lightdm lightdm-gtk-greeter dmenu

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

git clone https://aur.archlinux.org/yay.git ~lain/
cd ~lain/yay
makepkg -si 

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

mkdir ~user/.{themes,icons,fonts}