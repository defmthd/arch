# -----

timedatectl set-ntp true

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

sed -i '178s/.//' /etc/locale.gen
sed -i '404s/.//' /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "Berry" >> /etc/hostname

echo root:$PASS | chpasswd

pacman -S rsync reflector

reflector -c Russia -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syyy

pacman -S git grub grub-btrfs efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools ntfs-3g base-devel linux-headers os-prober

echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

useradd -m defmthd
echo defmthd:$PASS | chpasswd

echo "defmthd ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/defmthd

pacman -S sway waybar wofi mako alacritty

pacman -S sof-firmware alsa-utils alsa-ucm-conf pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol

pacman -S acpi intel-media-driver xf86-video-intel mesa mesa-demos vulkan-icd-loader vulkan-intel vulkan-mesa-layers vulkan-tools

# -----

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

yay -Syu
yay -S ly google-chrome github-desktop 1password visual-studio-code-bin slack-desktop ttf-windows ttf-font-awesome nerd-fonts-victor-mono noto-fonts-emoji

systemctl enable NetworkManager
systemctl enable ly.service
