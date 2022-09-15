sudo pacman -S bash-completion curl rsync reflector terminus-font dialog base-devel linux-headers nvidia nvidia-utils 

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector -a 20 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

# internet
# pacman -S inetutils dnsutils network-manager-applet openssh openbsd-netcat iptables-nft ipset avahi nfs-utils nss-mdns wpa_supplicant bridge-utils dnsmasq

# bluetooth
# pacman -S bluez bluez-utils

# audio
pacman -S alsa-lib alsa-utils pulseaudio #pipewire pipewire-alsa pipewire-pulse pipewire-jack sof-firmware

# power managment
# pacman -S acpi acpi_call acpid tlp

# cups
# pacman -S cups hplip

# cups
# pacman -S gvfs gvfs-smb virt-manager qemu qemu-arch-extra edk2-ovmf vde2

### YAY ###
#git clone https://aur.archlinux.org/yay.git ~user/
#cd ~user/yay
#makepkg -si

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload


# systemctl enable bluetooth
# systemctl enable cups.service
# systemctl enable sshd
# systemctl enable avahi-daemon
# systemctl enable tlp 
sudo systemctl enable reflector.timer
# systemctl enable libvirtd
# systemctl enable acpid

mkdir ~user/.{themes,icons,fonts}

