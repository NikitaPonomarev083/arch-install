sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector -a 20 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy