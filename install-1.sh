# $PASSWD
# $SSID

iwctl --passphrase $PASSWD station wlan0 connect $SSID

timedatectl set-ntp true

pacman -Syyy
pacman -S reflector
reflector -c Russia -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syyy

mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p5

mkdir /mnt/boot
mkdir /mnt/windows11

mount /dev/nvme0n1p1 /mnt/boot
mount /dev/nvme0n1p3 /mnt/windows11
mount /dev/nvme0n1p5 /mnt

pacstrap /mnt base linux linux-firmware vim amd-ucode

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
