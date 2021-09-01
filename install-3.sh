sudo pacman -S xorg xorg-xinit i3-gaps i3status dmenu terminator alacritty stow feh thunar lxappearance picom

sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc

# add exec i3 to ~/.xinitrc

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

yay -Syu
yay -S google-chrome github-desktop vscode slack-desktop polybar ttf-windows ttf-font-awesome nerd-fonts-iosevka noto-fonts-emoji
