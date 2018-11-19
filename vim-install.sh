" install oh-my-zsh and dracula theme "
cd ~ 
sudo apt-get install zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/dracula/zsh.git
mv zsh .zsh_theme
ln -s .zsh_theme/dracula.zsh-theme /home/zxy/.oh-my-zsh/themes/dracula.zsh-theme
sed 's/ZSH_THEME="robbyrussell"//g' ~/.zshrc
echo "ZSH_THEME="dracula"" >> ~/.zshrc

" install vim dependency "
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
	libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
	libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
	python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git

git clone https://github.com/vim/vim.git
cd vim

./configure --with-features=huge \
	--enable-multibyte \
	--enable-rubyinterp=yes \
	--enable-pythoninterp=yes \
	--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
	--enable-python3interp=yes \
	--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
	--enable-perlinterp=yes \
	--enable-luainterp=yes \
	--enable-gui=gtk2 \
	--enable-cscope \
	--prefix=/home/zxy/.local

make VIMRUNTIMEDIR=/home/zxy/.local/share/vim/vim81
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" install vim colortheme "
mkdir ~/.vim
git clone https://github.com/NLKNguyen/papercolor-theme.git
cp papercolor-theme/colors ~/.vim/ -r

git clone https://github.com/NLKNguyen/c-syntax.vim
cp c-syntax.vim/after ~/.vim -r

" install ctags "
git clone https://github.com/universal-ctags/ctags.git
cd ctags
sh autogen.sh
./configure --prefix=/home/zxy/.local
make 
make install

" get newest vimrc "
cd /tmp
git clone https://github.com/Keepmoving-ZXY/vim.git
cd vim
cp .vimrc ~
cp .ycm_extra_conf.py ~
cd ~

" install plugins "
echo "please run :PlugInstall in vim"
read tmp -p "PRESS any key to open vim"
vim

" compile ycm.sore "
cd ~/.vim/autoload/YouCompleteMe
python install.py --clang-completer
cd ~