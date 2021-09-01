mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p5

mount /dev/nvme0n1p5 /mnt

mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

mkdir /mnt/windows11
mount /dev/nvme0n1p3 /mnt/windows11

pacstrap /mnt base linux linux-firmware vim amd-ucode

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

pacman -S git
git clone https://github.com/defmthd/arch.git

cd /arch
