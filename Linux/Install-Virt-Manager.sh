paru -S qemu virt-manager --noconfirm
paru -S ebtables --noconfirm
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo usermod -a $USER -G libvirt
