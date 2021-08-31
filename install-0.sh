timedatectl set-ntp true

pacman -Syyy
reflector -c Russia -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syyy

pacman -S git
git clone https://github.com/defmthd/arch.git

cd arch
