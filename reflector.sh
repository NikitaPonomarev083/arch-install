cp /etc/pacman.d/mirrorlist mirrorlist.bak
reflector -a 20 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

sudo systemctl enable reflector.timer