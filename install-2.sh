# $ROOT_PASS

fallocate -l 2GB /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

echo "/swapfile none swap defaults 0 0" >> /etc/fstab

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc
timedatectl set-ntp true

sed -i '177s/.//' /etc/locale.gen
sed -i '403s/.//' /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" >> /etc/locale.con
echo "Arch" >> /etc/hostname

echo root:$ROOT_PASS | chpasswd

pacman -S grub efibootmgr os-prober ntfs-3g networkmanager network-manager-applet wireless_tools wpa_supplicant dialog mtools dosfstools base-devel linux-headers avahi inetutils dnsutils alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol acpi acpi_call git bluez bluez-utils pulseaudio-bluetooth xf86-video-amdgpu

pacman -S xf86-video-amdgpu

echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable avahi-daemon
systemctl enable acpid

useradd -mG wheel defmthd
passwd defmthd

chown -R defmthd:defmthd /arch

# don't forget visudo ;)