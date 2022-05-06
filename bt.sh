# source <(curl -sL https://t.ly/ps5g)

# export WIFI_PASS="password"
# export PASS="password"

# iwctl --passphrase $WIFI_PASS station wlan0 connect "Juno 5G"

mkfs.btrfs -f /dev/nvme0n1p5
mount /dev/nvme0n1p5 /mnt
cd /mnt
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @var
cd
umount /mnt

mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/nvme0n1p5 /mnt
mkdir /mnt/{boot,home,var,windows11}

mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/nvme0n1p5 /mnt/home
mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@var /dev/nvme0n1p5 /mnt/var
mount /dev/nvme0n1p1 /mnt/boot
mount /dev/nvme0n1p3 /mnt/windows11

pacstrap /mnt base linux linux-firmware vim btrfs-progs
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

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

pacman -S grub grub-btrfs efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools ntfs-3g base-devel linux-headers os-prober

echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

useradd -m defmthd
echo defmthd:$PASS | chpasswd

echo "defmthd ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/defmthd

pacman -S sway waybar wofi mako alacritty

pacman -S sof-firmware alsa-utils alsa-ucm-conf pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol

pacman -S acpi intel-media-driver xf86-video-intel mesa mesa-demos vulkan-icd-loader vulkan-intel vulkan-mesa-layers vulkan-tools

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

yay -Syu
yay -S ly google-chrome github-desktop 1password visual-studio-code-bin slack-desktop ttf-windows ttf-font-awesome nerd-fonts-victor-mono noto-fonts-emoji

systemctl enable NetworkManager
systemctl enable ly.service
