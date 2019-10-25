# 初期設定(WSLのパスワード設定終了後に実行する)
read -p "umask 022とシェル上で打って、実行しましたか? (y/N): " yn
 case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

echo ""
echo "wslのubuntuでの初期設定になります。"
echo ""
echo "VcxSrvのインストールはできましたか?"
echo "https://sourceforge.net/projects/vcxsrv/ でインストールできます"
echo "設定方法は https://www.kunihikokaneko.com/tools/win/vcxsrv.html を参照してください"
read -p " (y/N): " yn
 case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

echo ""
 cd
#------------------------------------------------------------------------------------------------------
# 以下はhttp://www.aise.ics.saitama-u.ac.jp/~gotoh/HowToInstallUbuntu1804OnWSL.htmlを参考に設定している
#------------------------------------------------------------------------------------------------------
#/etc/apt/source.list のリポジトリを日本国内に変更する
 cd /etc/apt
 sudo sed -i.bak -e "s/http:\/\/archive\.ubuntu\.com/http:\/\/jp\.archive\.ubuntu\.com/g" sources.list
 diff sources.list.bak sources.list
#インストールされているソフトウェアの更新（apt update, apt upgrade）
 yes | sudo apt update
 sudo apt upgrade
#日本語環境の設定 
 yes | sudo apt install language-pack-ja
 yes | sudo update-locale LANG=ja_JP.UTF-8
#タイムゾーンを日本（JST）にする(一番最後に表示させたかったので一番↓に置置いた。)
# sudo dpkg-reconfigure tzdata
#日本語マニュアルをインストールする
 yes | sudo apt install manpages-ja manpages-ja-dev
#Ubuntu上でのXserverの起動
 yes | sudo apt install  x11-apps x11-utils x11-xserver-utils dbus-x11
 cd
 echo 'export DISPLAY=localhost:0.0' >> ~/.bash_profile
#------------------------------------------------------------------------------------------------------
#ここまでが↑のリンクを参考にした設定
#------------------------------------------------------------------------------------------------------
#.bash_profileに書いておきたい設定(wsl)
 echo 'umask 022' >> ~/.bash_profile
# 便利ツール
 yes | sudo apt install firefox
 yes | sudo apt install fish
 yes | sudo apt install tree
 yes | sudo apt install make

#usbのマウントポイントを作成する
 cd
 sudo mkdir -p /mnt/usb
#minpacのインストール
 cd
 mkdir -p ~/.vim/pack/minpac/opt
 cd ~/.vim/pack/minpac/opt
 git clone https://github.com/k-takata/minpac.git
#vimのwriteを有効化する
 cd
 mkdir -p ~/.vim/tmp
#vimの永続的undoを有効にする
 cd
 mkdir -p ~/.vim/undodir
#vimのクリップボード共有を有効にする
 yes | sudo apt-get install vim-gnome

#nvimの設定ファイルを.vimrcから読み込む
cd ~/.config
mkdir nvim
cd nvim
touch init.vim
echo 'source ~/.vimrc' >> init.vim
cd

#pythonの設定
 yes | sudo apt install python3-pip
 yes | sudo apt install build-essential
 yes | sudo apt install python3-pip python3-pandas python3-sklearn
 pip3 install matplotlib
 yes | sudo apt install jupyter-notebook
 pip3 install --upgrade neovim

#npmのインストール
 yes | sudo apt install npm node-legacy
#wsl-openコマンドを有効にしてubuntu側からwindowsアプリケーションを開けるようにする
#yes | sudo npm install -g wsl-open


# configファイル群------------------
 cd
 mkdir -p .vim/bundle/neosnippet-snippets/snippets
 cd

 mkdir vimrc_conf
 cd vimrc_conf
 cd
 touch .vimrc
 echo "set packpath^=~/.vim\n
packadd minpac\n
call minpac#init()\n
\n
call minpac#add('k-takata/minpac',{'type':'opt'})\n
call minpac#add('sjl/badwolf')\n
set number\n
set wildmenu\n
set clipboard^=unnamedplus,unnamed\n
set background=dark\n
set t_Co=256\n
colorscheme badwolf" >> ~/.vimrc
 cd

 mkdir snippet_conf
 cd

 mkdir git_conf
 cd

 mkdir wsltty_conf
 cd
#------------------------------------------
#タイムゾーンを日本（JST）にする
 sudo dpkg-reconfigure tzdata

