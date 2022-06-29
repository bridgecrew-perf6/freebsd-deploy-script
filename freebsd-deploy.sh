#!/bin/sh

echo "OpenSSH..."
pkg install -y openssh-portable
sysrc openssh_enable="YES"
sed -i '' 's/#Port 22/Port 22/g' /usr/local/etc/ssh/sshd_config
service openssh start
echo "Done."

echo "Shell..."
pkg install -y zsh curl git exa autojump fzf cowsay grc bat htop

curl -o install.sh -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod +x install.sh
./install.sh

echo "Powerlevel10K..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
cp configs/p10kzsh $HOME/.p10k.zsh
chmod 644 $HOME/.p10k.zsh

echo "Addons..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
cp configs/zshrc $HOME/.zshrc
chmod 644 $HOME/.zshrc
echo "Done."

echo "Vim..."
mkdir -p $HOME/.vim/colors/
cp configs/vim_colors_solarized.vim $HOME/.vim/colors/solarized.vim
cp configs/vimrc $HOME/.vimrc
chmod 644 $HOME/.vimrc

curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
echo "Done."
