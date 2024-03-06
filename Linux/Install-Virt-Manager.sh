sudo pacman -S qemu-full virt-manager virt-viewer dnsmasq bridge-utils libguestfs vde2 openbsd-netcat --noconfirm
sudo pacman -S ebtables --noconfirm

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

sudo sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g; s/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf

sudo usermod -aG libvirt $USER

sudo systemctl restart libvirtd.service
