### PACMAN ###
echo "Color" | sudo tee -a /etc/pacman.conf > /dev/null
echo "VerbosePkgLists" | sudo tee -a /etc/pacman.conf > /dev/null
echo "ParrallelDownloads = 10" | sudo tee -a /etc/pacman.conf > /dev/null

### PACKAGES ###
sudo pacman -S bash-completion curl rsync reflector terminus-font dialog base-devel linux-headers nvidia nvidia-utils nvidia-settings

# internet
# sudo pacman -S inetutils dnsutils network-manager-applet openssh openbsd-netcat iptables-nft ipset avahi nfs-utils nss-mdns wpa_supplicant bridge-utils dnsmasq

# bluetooth
# sudo pacman -S bluez bluez-utils

# audio
# pulseaudio
sudo pacman -S alsa-lib alsa-utils pulseaudio
#pipewire
#sudo pacman -S pipewire pipewire-alsa pipewire-pulse pipewire-jack sof-firmware

# power managment
# sudo pacman -S acpi acpi_call acpid tlp

# cups
# sudo pacman -S cups hplip

# cups
# sudo pacman -S gvfs gvfs-smb virt-manager qemu qemu-arch-extra edk2-ovmf vde2

# fonts
mkdir ~/.{themes,icons,fonts}

sudo pacman -S dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji

### YAY ###
#git clone https://aur.archlinux.org/yay.git ~/
#cd ~/yay
#makepkg -si

### FIREWALL DEFAULT SETTINGS ###
sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

### SERVICES ###
# sudo systemctl enable bluetooth
# sudo systemctl enable cups.service
# sudo systemctl enable sshd
# sudo systemctl enable avahi-daemon
# sudo systemctl enable tlp 
# sudo systemctl enable reflector.timer
# sudo systemctl enable libvirtd
# sudo systemctl enable acpid

