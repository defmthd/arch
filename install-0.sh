timedatectl set-ntp true

pacman -Syyy
reflector -c Russia -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syyy
