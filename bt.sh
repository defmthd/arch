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
